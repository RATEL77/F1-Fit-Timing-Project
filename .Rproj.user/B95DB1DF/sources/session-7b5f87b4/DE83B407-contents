# 1. 경로 설정 및 로딩
raw_path <- "data/raw/"
files <- list.files(raw_path, pattern = "\\.csv$", full.names = TRUE)
names(files) <- tools::file_path_sans_ext(basename(files))

raw_data <- lapply(files, read.csv, stringsAsFactors = FALSE)

# 2. 구조 요약
lapply(raw_data, function(df) {
  list(
    dim = dim(df),
    names = names(df),
    head = head(df, 2)
  )
})

# 3. 결측치 비율 계산 함수
check_na <- function(df) {
  sapply(df, function(col) sum(is.na(col)) / length(col))
}
na_report <- lapply(raw_data, check_na)

# 4. 요약 통계 및 타입 정보
summary_report <- lapply(raw_data, summary)
str_report <- lapply(raw_data, str)
