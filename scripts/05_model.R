# scripts/05_model.R

# 01. 패키지 설치 및 로드
if (!require("data.table")) install.packages("data.table")
if (!require("feather")) install.packages("feather")

library(data.table)
library(feather)

# 02. 데이터 불러오기
df <- readRDS("data_tidy/pitstop_cluster.rds")
setDT(df)

# 03. 외부 정보 추가: 그리드 위치 불러오기
results <- fread("data_raw/Race_Results.csv")
grid_info <- results[, .(grid = min(grid)), by = .(raceId, driverId)]

df <- merge(df, grid_info, by = c("raceId", "driverId"), all.x = TRUE)

# 04. 회귀 모델 적합 (delta_time ~ first_pit_lap + cluster + grid)
lm_fit <- lm(delta_time ~ first_pit_lap + cluster + grid, data = df)

# 05. 결과 저장
saveRDS(lm_fit, file = "models/lm_fit.rds")

# 06. 요약 출력
print(summary(lm_fit))