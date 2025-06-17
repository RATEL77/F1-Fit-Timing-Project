# scripts/07_logistic.R

# 01. 패키지 설치 및 로드
if (!require("data.table")) install.packages("data.table")
if (!require("feather")) install.packages("feather")

library(data.table)
library(feather)

# 02. 데이터 불러오기
df <- readRDS("data_tidy/pitstop_cluster.rds")
setDT(df)

# 03. 언더컷 성공 여부 정의 (기준: delta_time < 15000ms)
df[, undercut_success := ifelse(delta_time < 15000, 1, 0)]

# 04. 로지스틱 회귀 모델 적합
logit_fit <- glm(undercut_success ~ first_pit_lap + cluster, data = df, family = "binomial")

# 05. 결과 저장
saveRDS(logit_fit, file = "models/logit_fit.rds")

# 06. 요약 출력
print(summary(logit_fit))
