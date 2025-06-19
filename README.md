# 🏁 F1 Pit Timing — Pit-Stop Strategy Optimization

**F1 Pit Timing** is a data-driven study that pinpoints the *optimal first pit-stop lap* in Formula 1 races.  
Using historical telemetry (1950 – 2024), we cluster strategies, fit regression / classification models, and visualize the trade-off between timing, time-loss, and under-cut success.

---

## 📘 English Version

### ✨ Project Overview

| Item | Description |
|------|-------------|
| **Goal** | Quantify when to pit to minimise time-loss and maximise under-cut success |
| **Data** | Kaggle “Formula-1 World Championship History 1950-2024” (5 CSVs) |
| **Core Steps** | ➊ Pre-process & derive variables ➋ EDA ➌ K-means (k = 3) ➍ Multiple linear regression ➎ Logistic regression ➏ Visual diagnostics |
| **Key Finding** | *Pitting on laps 19 – 21* (cluster 3) delivers the smallest time-loss *and* the highest under-cut success rate (AUC ≈ 0.73). |
| **Stack** | R 4.x · data.table · ggplot2 · pROC · renv · Git |

### 🗂 Repository Layout

```
F1-Pit-Timing-Project/
├── data_raw/ # original CSV
├── data_tidy/ # feather / rds after cleaning
├── models/ # saved lm / glm objects
├── plots/ # PNG / JPG graphs for PPT
├── scripts/ # 01 – 08 analysis scripts
└── README.md
```

### 🛠 Scripts & What They Show

| Script | Method / Viz | What You Learn |
|--------|--------------|----------------|
| **01_schema.R** | fread → feather | fast, reproducible data ingestion |
| **02_tidy.R** | feature engineering | derive `first_pit_lap`, `delta_time` |
| **03_eda.R** | scatter + boxplot | later pit ⇒ less time-loss; early strategy shows high variance |
| **04_cluster.R** | k-means (k = 3) | cluster 3 ≈ laps 19-21 (“Late”) |
| **05_model.R** | multiple lm | cluster is strongest driver of time-loss (grid position isn’t) |
| **06_viz_model.R** | coef CI, residual / QQ plots | model assumptions hold; clusters clearly separate |
| **07_logistic.R** | glm (binomial) | later pit-laps ↑ under-cut success probability |
| **08_viz_logit.R** | ROC (AUC 0.73) + logit coef | cluster 3 most successful; model deployable mid-race |

### 🔑 Main Conclusion
> **Pit on laps 19 – 21.**  
> This “Late” cluster minimises lap-time loss and yields the highest under-cut win likelihood.

### 🧑‍💻 Commit Convention
git commit -m "feat(cluster): add k-means segmentation"
git commit -m "fix(model): correct grid variable type"
git commit -m "docs(readme): update conclusion section"

### 📜 License
MIT License – free to use, modify, and distribute.

---

## 📙 🇰🇷 한국어 설명
## 🏁 F1 Pit Timing — 피트 전략 최적화
F1 Pit Timing은 1950-2024년 실제 F1 경기 데이터를 활용해 첫 피트 인 랩을 최적화하는 연구입니다.
전략을 군집화하고 회귀·분류 모델을 적용해 피트 인 시점·손실 시간·언더컷 성공률의 균형을 시각적으로 분석합니다.

### ✨ 프로젝트 개요

| 항목 | 설명 |
|------|-------------|
| **목표** | 피트 타이밍을 정량화하여 시간 손실을 최소화하고 언더컷 성공률을 극대화하기 |
| **데이터** | Kaggle “Formula-1 World Championship History 1950-2024” (CSV 5개) |
| **핵심 단계** | ➊ 전처리 및 변수 도출 ➋ EDA ➌ K-평균 군집화(k = 3) ➍ 다중 선형 회귀 ➎ 로지스틱 회귀 ➏ 시각적 진단 |
| **주요 발견** | *19~21랩(클러스터 3)에 피트인*하면 시간 손실이 가장 적고 언더컷 성공률(AUC ≈ 0.73)이 가장 높음 |
| **스택** | R 4.x · data.table · ggplot2 · pROC · renv · Git |

---

### 🗂 저장소 구조

```
F1-Pit-Timing-Project/
├── data_raw/      # 원본 CSV
├── data_tidy/     # 정제 후 feather / rds
├── models/        # 저장된 lm / glm 객체
├── plots/         # PPT용 그래프(PNG/JPG)
├── scripts/       # 01~08 분석 스크립트
└── README.md
```

---

### 🛠 스크립트별 기능 및 결과

| 스크립트 | 방법 / 시각화 | 주요 내용 |
|----------|---------------|-----------|
| **01_schema.R** | fread → feather | 빠르고 재현성 있는 데이터 적재 |
| **02_tidy.R** | 피처 엔지니어링 | `first_pit_lap`, `delta_time` 도출 |
| **03_eda.R** | 산점도 + 박스플롯 | 늦은 피트인일수록 시간 손실↓, 이른 전략은 분산↑ |
| **04_cluster.R** | K-평균(k=3) | 클러스터 3 ≈ 19~21랩 (“Late”) |
| **05_model.R** | 다중 선형회귀 | 클러스터가 시간 손실에 가장 큰 영향 (그리드 포지션 영향 미미) |
| **06_viz_model.R** | 계수 CI, 잔차/QQ 플롯 | 모델 가정 충족, 클러스터 간 명확한 분리 |
| **07_logistic.R** | glm(이항) | 늦은 피트랩일수록 언더컷 성공 확률↑ |
| **08_viz_logit.R** | ROC(AUC 0.73) + 로짓 계수 | 클러스터 3이 가장 성공적, 실전 적용 가능 |

---

### 🔑 주요 결론

> **19~21랩에 피트인하세요.**  
> 이 “Late” 클러스터가 랩타임 손실을 최소화하고 언더컷 승률을 극대화합니다.

---

### 🧑‍💻 커밋 컨벤션

- git commit -m "feat(cluster): add k-means segmentation"
- git commit -m "fix(model): correct grid variable type"
- git commit -m "docs(readme): update conclusion section"

---

### 📜 라이선스

MIT License – 자유롭게 사용, 수정, 배포 가능
