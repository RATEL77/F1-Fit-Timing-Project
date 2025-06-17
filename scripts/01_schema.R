# scripts/01_schema.R

# 01. 패키지 로드
library(data.table)   # 고속 CSV 로딩
library(feather)      # Feather 포맷 저장

# 02. 미리보기 저장 폴더 생성
dir.create("data_preview", showWarnings = FALSE)

# 03. 사용할 원본 CSV 목록 정의
files <- c(
  "Lap_Timings.csv",
  "Pit_Stop_Records.csv",
  "Race_Results.csv",
  "Race_Schedule.csv",
  "Track_Information.csv"
)

# 04. 반복 처리: 파일 읽고 구조 확인 + feather 저장
for (f in files) {
  name <- tools::file_path_sans_ext(f)
  path <- file.path("data_raw", f)
  df <- fread(path)
  
  # feather로 저장 (fast load + 구조 확인용)
  feather::write_feather(df, file.path
                         ("data_preview", paste0(name, ".feather")))
  
  # 콘솔 출력: 구조 요약
  cat("====", name, "====\n")
  print(str(df))
  cat("\n\n")
}
