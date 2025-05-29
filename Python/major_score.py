import pandas as pd
from sentence_transformers import SentenceTransformer
from sklearn.metrics.pairwise import cosine_similarity

# 계열별 파일 경로 매핑
MAJOR_TYPE_PATHS = {
    "이과계열": "Python/csv_folder/major_subjects_이과계열.csv",
    "문과계열": "Python/csv_folder/major_subjects_문과계열.csv",
    "예체능계열": "Python/csv_folder/major_subjects_예체능계열.csv",
}

# SBERT 모델 미리 로드 (속도 최적화)
MODEL = SentenceTransformer('snunlp/KR-SBERT-V40K-klueNLI-augSTS')

# 문자열 답변 → 점수 매핑
ANSWER_TO_SCORE = {
    "그렇다": 5,
    "보통이다": 3,
    "아니다": 1
}

def recommend_major(user_answers, major_type="이과계열", top_n=3):
    majors_path = MAJOR_TYPE_PATHS.get(major_type)
    if majors_path is None:
        raise ValueError(f"Unknown major_type: {major_type}")

    majors_df = pd.read_csv(majors_path)
    majors = majors_df['major'].astype(str).tolist()

    # 1) 문자열 답변 → 숫자 점수로 바로 변환
    numeric_user_answers = [
        (q, ANSWER_TO_SCORE.get(answer, 3))
        for q, answer in user_answers
    ]

    # 2) 숫자 점수를 그대로 문장에 사용
    #    ex) "세포의 구조를 이해한다: 5"
    user_sentences = [f"{q}: {score}" for q, score in numeric_user_answers]
    user_profile = " ".join(user_sentences)

    # 3) SBERT 임베딩 & 유사도 계산
    user_emb   = MODEL.encode([user_profile])
    major_embs = MODEL.encode(majors, show_progress_bar=False)
    sims       = cosine_similarity(user_emb, major_embs)[0]

    # 4) 상위 top_n 추천
    result = pd.DataFrame({'학과명': majors, '유사도': sims})
    result = result.sort_values('유사도', ascending=False)

    return result.head(top_n).to_dict(orient='records')
