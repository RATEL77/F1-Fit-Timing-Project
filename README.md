# 🏁 F1 Pit Timing — Pit-Stop Strategy Optimization

**F1 Pit Timing** is a data-driven study that pinpoints the *optimal first pit-stop lap* in Formula 1 races.  
Using historical race telemetry (1950 – 2024), we cluster strategies, fit regression / classification models, and visualize the trade-off between timing, time-loss, and under-cut success.

---

## 📘 English Version

### ✨ Project Overview

| Item | Description |
|------|-------------|
| **Goal** | Quantify when to pit to minimise time-loss and maximise under-cut success |
| **Data** | Kaggle “Formula-1 World Championship History 1950-2024” (CSV 5) |
| **Core Steps** | ➊ Pre-process & derive variables ➋ EDA ➌ K-means (k = 3) ➍ Multiple linear regression ➎ Logistic regression ➏ Visual diagnostics |
| **Key Finding** | *Pitting on laps 19 – 21* (cluster 3) delivers the smallest time-loss and the highest under-cut success rate (AUC≈0.73). |
| **Stack** | R 4.x · data.table · ggplot2 · pROC · renv · Git |

### 🗂 Repository Layout

```

F1-Fit-Timing-Project/
├── data\_raw/               # original CSV
├── data\_tidy/              # feather / rds after cleaning
├── models/                 # saved lm / glm objects
├── scripts/                # 01 to 08 analysis scripts
└── README.md

```

### 🛠 Scripts & What They Show

| Script | Method / Viz | What You Learn |
|--------|--------------|----------------|
| **01_schema.R** | fread → feather | efficient data loading pipeline |
| **02_tidy.R** | feature engineering | derive `first_pit_lap`, `delta_time` |
| **03_eda.R** | scatter + boxplot | later pit ⇒ less time-loss; Early strat has wide variance |
| **04_cluster.R** | k-means (k = 3) | cluster 3 ≈ laps 19-21 (late) |
| **05_model.R** | multiple lm | cluster is strongest driver of time-loss (grid not) |
| **06_viz_model.R** | coef CI, residual plots | model assumptions hold; clusters clearly separate |
| **07_logistic.R** | glm (binomial) | later pit-laps ↑ under-cut success prob |
| **08_viz_logit.R** | ROC (AUC 0.73) + logit coef | cluster 3 most successful; model usable in race-strategy |

### 🔑 Main Conclusion

> **Pit on laps 19 - 21.**  
> This “Late” cluster minimises lap-time loss and gives the highest under-cut win likelihood.

### 🧑‍💻 Commit Convention
```

git commit -m "feat(cluster): add kmeans segmentation"
git commit -m "fix(model): correct grid variable type"
git commit -m "docs(readme): update conclusion section"

```

### 📜 License

MIT License – free to use, modify, and distribute.

---

## 📙 🇰🇷 한국어 설명

### 🏁 F1 Pit Timing — Pit-Stop Strategy Optimization

**F1 Pit Timing**은 1950-2024년의 실제 F1 경기 텔레메트리 데이터를 활용해 **첫 피트 인 랩을 최적화**하는 데이터 분석 연구입니다.  
전략을 군집화하고 회귀·분류 모델을 적용해 *피트 인 시점·손실 시간·언더컷 성공률* 간의 균형을 시각적으로 분석합니다.

### 🚀 프로젝트 개요

| 항목 | 내용 |
|------|------|
| **목적** | *첫 피트 인 랩*을 데이터로 최적화해 손실 최소·언더컷 성공 극대화 |
| **데이터** | Kaggle F1 1950-2024 CSV 5종 |
| **분석 절차** | 1) 전처리·파생 2) EDA 3) K-means(3군) 4) 다중선형회귀 5) 로지스틱 회귀 6) 시각화·모델 진단 |
| **핵심 결론** | **19-21랩**(cluster 3)에서 피트 인 → 손실 최소·언더컷 성공률 최고 |
| **기술스택** | R, data.table, ggplot2, pROC, renv, Git |

### 📂 폴더 구조

```

F1-Fit-Timing-Project/
├── data\_raw/     원본 CSV
├── data\_tidy/    정제 feather / rds
├── models/       회귀·로지스틱 모델
├── scripts/      01\~08 스크립트
└── README.md

```

### 🗂 스크립트별 주요 내용

| 스크립트 | 방법·시각화 | 얻을 수 있는 인사이트 |
|----------|-------------|------------------------|
| 01_schema.R | fread→feather | 대용량 데이터 빠른 로드 |
| 02_tidy.R | 변수 파생 | `first_pit_lap`, `delta_time` 생성 |
| 03_eda.R | 산점도·박스플롯 | 늦을수록 손실↓ / Early 분산↑ |
| 04_cluster.R | K-means(3) | cluster3 = 19-21랩 |
| 05_model.R | 다중선형회귀 | cluster가 손실에 가장 유의 |
| 06_viz_model.R | 계수·잔차·QQ | 모델 가정 만족, 해석 용이 |
| 07_logistic.R | 로지스틱 | 후반 피트 인이 성공률↑ |
| 08_viz_logit.R | ROC·계수 | AUC≈0.73, cluster3 성공률 최고 |

### 🔑 최종 결론

> **19-21랩 Late 전략(cluster3)** → 손실시간 최소, 언더컷 성공확률 최상.  
> 따라서 경기 전략 설계 시 *가능한 한 피트 인을 뒤로 미루는* 방안이 가장 효율적.

### 🧑‍💻 커밋 규칙

```

git commit -m "feat(cluster): K-평균 군집화 추가"
git commit -m "fix(viz): 로지스틱 ROC 입력 버그 수정"
git commit -m "docs(readme): 결론·스크립트 설명 업데이트"

```

### 📜 라이선스

MIT License – 누구나 무료로 사용·복제·수정·배포 가능.

---

