# scripts/06_viz_model.R

# 01. 패키지 설치 및 로드
if (!require("data.table")) install.packages("data.table")
if (!require("ggplot2")) install.packages("ggplot2")

library(data.table)
library(ggplot2)

# 02. 모델 & 데이터 불러오기
fit <- readRDS("models/lm_fit.rds")
df <- readRDS("data_tidy/pitstop_cluster.rds")

# 03. 회귀선 시각화
ggplot(df, aes(x = first_pit_lap, y = delta_time)) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "lm", se = TRUE, color = "blue") +
  labs(title = "회귀선: 피트 인 랩 vs 손실 시간", x = "첫 피트 인 랩", y = "손실 시간 (ms)")

# 04. 계수 막대 시각화
coefs <- summary(fit)$coefficients
coef_df <- data.frame(
  term = rownames(coefs),
  estimate = coefs[, "Estimate"],
  se = coefs[, "Std. Error"]
)
coef_df$ci_lower <- coef_df$estimate - 1.96 * coef_df$se
coef_df$ci_upper <- coef_df$estimate + 1.96 * coef_df$se
 
ggplot(coef_df[-1, ], aes(x = term, y = estimate)) +  # Intercept 제외
  geom_bar(stat = "identity", fill = "steelblue") +
  geom_errorbar(aes(ymin = ci_lower, ymax = ci_upper), width = 0.2) +
  labs(title = "회귀 계수 및 95% 신뢰구간", x = "변수", y = "계수")

# 05. 잔차 vs 적합값
plot(fit$fitted.values, fit$residuals,
     main = "잔차 vs 적합값",
     xlab = "예측값", ylab = "잔차")
abline(h = 0, col = "red")

# 06. QQ 플롯
qqnorm(fit$residuals)
qqline(fit$residuals, col = "blue")
