# scripts/08_viz_logit.R

# 01. 패키지 설치 · 로드
if (!require("data.table")) install.packages("data.table")
if (!require("ggplot2"))   install.packages("ggplot2")
if (!require("pROC"))      install.packages("pROC")

library(data.table)
library(ggplot2)
library(pROC)

# 02. 모델 · 데이터 불러오기
fit <- readRDS("models/logit_fit.rds")
df  <- readRDS("data_tidy/pitstop_cluster.rds")
setDT(df)

# 03. 타깃 정의 & 예측 확률
df[, undercut_success := ifelse(delta_time < 15000, 1, 0)]
df$pred_prob <- predict(fit, type = "response")

# 04. plots 폴더 생성
dir.create("plots", showWarnings = FALSE)

# 05. ROC 곡선
roc_obj <- roc(df$undercut_success, df$pred_prob)

jpeg("plots/roc.jpg", width = 800, height = 600, quality = 95)
plot(roc_obj,
     main = paste("ROC Curve (AUC =", round(auc(roc_obj), 3), ")"),
     col = "#D32F2F", lwd = 3)
grid()
dev.off()

# 06. 로지스틱 계수 + 95 % CI
coefs <- summary(fit)$coefficients
coef_df <- data.frame(
  term     = rownames(coefs),
  estimate = coefs[, "Estimate"],
  se       = coefs[, "Std. Error"]
)
coef_df$ci_lower <- coef_df$estimate - 1.96 * coef_df$se
coef_df$ci_upper <- coef_df$estimate + 1.96 * coef_df$se

p_coef <- ggplot(coef_df[-1, ], aes(term, estimate)) +
  geom_bar(stat = "identity", fill = "darkgreen") +
  geom_errorbar(aes(ymin = ci_lower, ymax = ci_upper), width = 0.25) +
  coord_flip() +
  labs(title = "Logistic Coefficients with 95% CI",
       x = NULL, y = "Coefficient") +
  theme_minimal(base_size = 11)

ggsave("plots/logit_coef.jpg", plot = p_coef,
       width = 6, height = 4, dpi = 300)

# 07. 예측 결과 저장
saveRDS(df, file = "data_tidy/pitstop_logit.rds")
