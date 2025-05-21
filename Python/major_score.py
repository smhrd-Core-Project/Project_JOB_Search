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
# 점수 → 자연어 해설
SCORE_TO_TEXT = {
    5: "매우 좋다",
    3: "보통이다",
    1: "매우 싫다"
}

def recommend_major(user_answers, major_type="이과계열", top_n=3):
    """
    user_answers: [(질문(str), 답변(str)), ...]  ex) ("세포의 구조...", "그렇다")
    major_type: 계열명
    top_n: 반환할 추천 학과 개수
    """
    majors_path = MAJOR_TYPE_PATHS.get(major_type)
    if majors_path is None:
        raise ValueError(f"Unknown major_type: {major_type}")

    majors_df = pd.read_csv(majors_path)
    majors = majors_df['major'].astype(str).tolist()

    # 문자열 답변 → 점수 변환
    numeric_user_answers = []
    for q, answer in user_answers:
        score = ANSWER_TO_SCORE.get(answer, 3)  # 모르면 기본 3점
        numeric_user_answers.append((q, score))

    # 점수 → 자연어 해설로 문장 생성
    user_sentences = [f"{q}: {SCORE_TO_TEXT[s]}" for q, s in numeric_user_answers]
    user_profile = " ".join(user_sentences)

    # 임베딩 및 유사도 계산
    user_emb = MODEL.encode([user_profile])
    major_embs = MODEL.encode(majors, show_progress_bar=False)
    sims = cosine_similarity(user_emb, major_embs)[0]

    result = pd.DataFrame({'학과명': majors, '유사도': sims})
    result = result.sort_values('유사도', ascending=False)

    return result.head(3).to_dict(orient='records')
