# scripts/02_tidy.R

# 01. 패키지 로드
library(data.table)
library(feather)

# 02. 디렉터리 준비
dir.create("data_tidy", showWarnings = FALSE)

# 03. 원본 데이터 로드
lap <- fread("data_raw/Lap_Timings.csv")
pit <- fread("data_raw/Pit_Stop_Records.csv")
res <- fread("data_raw/Race_Results.csv")

# 04. 피트 인 랩 계산
first_pit <- pit[, .(first_pit_lap = min(lap)), by = .(raceId, driverId)]

# 05. 기준랩 평균
lap_base <- lap[, .(base_time = mean(milliseconds[lap <= 5])), by = .(raceId, driverId)]

# 06. 피트 인 랩 정보 가져오기
lap_first <- merge(first_pit, lap, by.x = c("raceId", "driverId", "first_pit_lap"),
                   by.y = c("raceId", "driverId", "lap"))

# 07. 기준 시간 병합 + delta 계산
lap_join <- merge(lap_first, lap_base, by = c("raceId", "driverId"))
lap_join[, delta_time := milliseconds - base_time]

# 08. 결과 테이블 저장
feather::write_feather(lap_join, "data_tidy/pitstop.feather")

# 09. 확인 출력
print(head(lap_join[, .(raceId, driverId, first_pit_lap, milliseconds, base_time, delta_time)]))
