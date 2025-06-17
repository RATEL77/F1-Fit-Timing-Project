# scripts/08_viz_logit.R

# 01 패키지
if (!require("ggplot2")) install.packages("ggplot2")
library(ggplot2)

# 02 데이터 로드
df <- readRDS("data_tidy/pitstop_logit.rds")

# 03 2랩 단위 구간 ‒ 집계
df$lap_bin <- cut(df$first_pit_lap, breaks = seq(0, 70, 2), right = FALSE)
tab <- aggregate(cbind(mean_loss = df$delta_time,
                       succ_rate = df$undercut_success) ~ lap_bin,
                 data = df, FUN = mean)

# 04 plots 폴더
dir.create("plots", showWarnings = FALSE)

# 05 평균 손실 막대그래프
ggplot(tab, aes(lap_bin, mean_loss)) +
  geom_col(fill = "#d32f2f") +
  labs(title = "구간별 평균 손실시간",
       x = "첫 피트-인 랩(2랩)", y = "손실(ms)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
ggsave("plots/strategy_loss.png", width = 7, height = 4, dpi = 300)

# 06 언더컷 성공률 선그래프
ggplot(tab, aes(lap_bin, succ_rate)) +
  geom_line(group = 1, colour = "steelblue") +
  geom_point(size = 2, colour = "steelblue") +
  scale_y_continuous(labels = scales::percent_format()) +
  labs(title = "구간별 언더컷 성공률",
       x = "첫 피트-인 랩(2랩)", y = "성공률") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
ggsave("plots/strategy_auc.png", width = 7, height = 4, dpi = 300)
