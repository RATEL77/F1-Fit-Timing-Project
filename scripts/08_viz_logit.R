# scripts/08_viz_logit.R

# 01. 패키지 설치 및 로드
if (!require("data.table")) install.packages("data.table")
if (!require("ggplot2")) install.packages("ggplot2")
if (!require("pROC")) install.packages("pROC")

library(data.table)
library(ggplot2)
library(pROC)

# 02. 모델 및 데이터 불러오기
fit <- readRDS("models/logit_fit.rds")
df <- readRDS("data_tidy/pitstop_cluster.rds")
setDT(df)

# 중요: 타겟 변수 정의 (delta_time < 15초 기준)
df[, undercut_success := ifelse(delta_time < 15000, 1, 0)]

# 03. 예측 확률 계산
df$pred_prob <- predict(fit, type = "response")

# 04. ROC 곡선
roc_obj <- roc(df$undercut_success, df$pred_prob)
plot(roc_obj, main = paste("ROC Curve (AUC =", round(auc(roc_obj), 3), ")"))

# 05. 계수 시각화
coefs <- summary(fit)$coefficients
coef_df <- data.frame(
  term = rownames(coefs),
  estimate = coefs[, "Estimate"],
  se = coefs[, "Std. Error"]
)
coef_df$ci_lower <- coef_df$estimate - 1.96 * coef_df$se
coef_df$ci_upper <- coef_df$estimate + 1.96 * coef_df$se

ggplot(coef_df[-1, ], aes(x = term, y = estimate)) +
  geom_bar(stat = "identity", fill = "darkgreen") +
  geom_errorbar(aes(ymin = ci_lower, ymax = ci_upper), width = 0.2) +
  labs(title = "Logistic Coefficients with 95% CI", x = "Variable", y = "Coefficient")

# 06. 예측 결과 저장
saveRDS(df, file = "data_tidy/pitstop_logit.rds")
