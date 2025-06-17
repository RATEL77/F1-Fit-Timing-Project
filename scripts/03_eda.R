# scripts/03_eda.R

# 01. 패키지 설치 및 로드
if (!require("data.table")) install.packages("data.table")
if (!require("ggplot2")) install.packages("ggplot2")
if (!require("feather")) install.packages("feather")

library(data.table)
library(ggplot2)
library(feather)

# 02. 데이터 불러오기
df <- feather::read_feather("data_tidy/pitstop.feather")

# 03. 기술통계 확인
print(summary(df[, .(first_pit_lap, delta_time)]))

# 04. 산점도: first_pit_lap vs delta_time
ggplot(df, aes(x = first_pit_lap, y = delta_time)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "피트 인 랩과 손실 시간 관계",
    x = "첫 피트 인 랩",
    y = "손실 시간 (밀리초)"
  )

# 05. 전략군 분류 (Early/Mid/Late)
df[, strategy := fifelse(first_pit_lap <= 10, "Early",
                         fifelse(first_pit_lap <= 20, "Mid", "Late"))]

# 06. 박스플롯: 전략별 손실 시간 분포
ggplot(df, aes(x = strategy, y = delta_time, fill = strategy)) +
  geom_boxplot(alpha = 0.8) +
  labs(
    title = "전략군별 손실 시간 분포",
    x = "전략군",
    y = "손실 시간 (밀리초)"
  )
