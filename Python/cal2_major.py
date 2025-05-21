import pandas as pd
from sentence_transformers import SentenceTransformer
from sklearn.metrics.pairwise import cosine_similarity
import numpy as np

# 1. 데이터 로드
majors_path = 'Python/major_subjects_이과계열.csv'
majors_df = pd.read_csv(majors_path)
majors = majors_df['major'].astype(str).tolist()

# 2. 사용자 설문(문항+점수) → 예시
# user_answers = [(문항, 점수), ...]
# 13개 문항 + 임의 점수 예시 (직접 선정)
user_answers = [
    ("세포의 구조 및 물리, 화학적 특성을 연구한다.", 3),
    ("컴퓨터를 이용해 단순 반복적인 활동을 자동화한다.", 5),
    ("자동차의 성능을 연구하고 개발한다.", 3),
    ("기계공학의 원리를 응용하여 산업 생산 시스템을 설계하고 운영한다.", 1),
    ("환경오염 문제를 연구하여 오염 방지 대책을 만든다.", 5),
    ("신소재공학과 관련된 연구를 수행한다.", 1),
    ("질병을 치료하기 위해 새로운 의약품을 연구하고 개발한다.", 5),
    ("농업의 발전을 위해 새로운 기술을 개발하고 보급한다.", 3),
    ("도로, 철도, 터널, 항만, 댐 등을 점검하고 보수한다.", 1),
    ("현실의 문제를 컴퓨터가 처리할 수 있는 데이터 형태로 구현한다.", 5),
    ("특용작물을 재배하고 수확한다.", 3),
    ("에너지를 제공하기 위해 원자력의 안전한 이용방법을 연구하고 개발한다.", 5),
    ("얼굴이나 사물을 인식하는 소프트웨어를 개발한다.", 1),
]



# 3. 점수를 자연어로 변환
score_text = {5: "매우 좋다", 3: "보통이다", 1: "매우 싫다"}
user_sentences = [f"{q}: {score_text[s]}" for q, s in user_answers]

# 4. 전체 사용자 답변을 하나의 긴 문장으로 합치기 (임베딩의 의미성↑)
user_profile = " ".join(user_sentences)

# 5. 임베딩
model = SentenceTransformer('snunlp/KR-SBERT-V40K-klueNLI-augSTS')
user_emb = model.encode([user_profile])
major_embs = model.encode(majors, show_progress_bar=True)

# 6. 학과별 유사도 계산
sims = cosine_similarity(user_emb, major_embs)[0]
result = pd.DataFrame({'학과명': majors, '유사도': sims})

# 7. 추천 결과(내림차순)
result = result.sort_values('유사도', ascending=False)
result.to_csv('Python/사용자설문_학과추천.csv', index=False, encoding='utf-8-sig')
print(result.head(10))  # 상위 10개 학과

# 사용자에게 결과 보여주기!
