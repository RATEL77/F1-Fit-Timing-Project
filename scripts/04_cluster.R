# scripts/04_cluster.R

# 01. 출력 폴더 생성 (없으면 자동 생성)
dir.create("plots", showWarnings = FALSE)

# 02. 패키지 설치 및 로드
if (!require("data.table")) install.packages("data.table")
if (!require("ggplot2"))    install.packages("ggplot2")
if (!require("feather"))    install.packages("feather")

library(data.table)
library(ggplot2)
library(feather)

# 03. 데이터 불러오기
df <- feather::read_feather("data_tidy/pitstop.feather")
setDT(df)

# 04. K-means 분석 대상 변수 선택
clust_data  <- df[, .(first_pit_lap, delta_time)]

# 05. 정규화
clust_scaled <- scale(clust_data)

# 06. K-means 실행 (k = 3)
set.seed(42)
kfit <- kmeans(clust_scaled, centers = 3)

# 07. 결과 병합
df[, cluster := as.factor(kfit$cluster)]

# 08. 결과 저장
saveRDS(df, file = "data_tidy/pitstop_cluster.rds")

# 09. 시각화 (산점도)
p <- ggplot(df, aes(first_pit_lap, delta_time,
                    colour = cluster)) +
  geom_point(alpha = 0.4, size = 1.2) +
  scale_colour_brewer(palette = "Set2") +
  labs(title = "K-means 군집 결과",
       x = "첫 피트 인 랩",
       y = "손실 시간(ms)") +
  theme_minimal()

# 10. 그래프 파일로 저장
ggsave("plots/cluster_scatter.jpg",
       plot   = p,
       width  = 6,
       height = 4,
       dpi    = 300)

# 11. 확인 출력
print(table(df$cluster))
