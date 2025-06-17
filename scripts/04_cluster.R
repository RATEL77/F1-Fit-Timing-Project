# scripts/04_cluster.R

# 01. 패키지 설치 및 로드
if (!require("data.table")) install.packages("data.table")
if (!require("feather")) install.packages("feather")

library(data.table)
library(feather)

# 02. 데이터 불러오기
df <- feather::read_feather("data_tidy/pitstop.feather")
setDT(df)

# 03. K-means 분석 대상 변수 선택
clust_data <- df[, .(first_pit_lap, delta_time)]

# 04. 정규화
clust_scaled <- scale(clust_data)

# 05. K-means 실행 (k = 3)
set.seed(42)
kfit <- kmeans(clust_scaled, centers = 3)

# 06. 결과 병합
df[, cluster := as.factor(kfit$cluster)]

# 07. 저장
saveRDS(df, file = "data_tidy/pitstop_cluster.rds")

# 08. 확인 출력
print(table(df$cluster))
