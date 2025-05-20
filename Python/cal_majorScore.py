import pandas as pd
import random

# 1) 데이터 로드
df_q     = pd.read_csv("Python/updated_ques_science_group.csv")
df_major = pd.read_csv("Python/major_subjects_이과계열.csv")

# 2) 질문 10개 랜덤 샘플링
sample_n    = 10
random_seed = 42
df_q_sample = df_q.sample(n=sample_n, random_state=random_seed).reset_index(drop=True)

# 3) 키워드 & 분류
science_keywords = ['과학','생명','물리','화학','기술','공학','컴퓨터','수학','전자','기계']

def classify_question(text):
    return '이과계열' if any(kw in text for kw in science_keywords) else '기타'

df_q_sample['계열추정'] = df_q_sample['question'].apply(classify_question)

# 4) 전공별 이상응답 벡터 생성
def generate_major_pref(row, questions, keywords):
    major_text = " ".join([
        str(row.get('공통과목','')),
        str(row.get('일반선택과목','')),
        str(row.get('진로선택과목','')),
        str(row.get('Iclass','')),
        str(row.get('type','')),
    ])
    M = []
    for _, q in questions.iterrows():
        q_txt, q_cat = q['question'], q['계열추정']
        # 직접 매칭 (질문 키워드가 전공 텍스트에도 있을 때)
        if any(kw in q_txt and kw in major_text for kw in keywords):
            M.append(5)
        # 간접 매칭 (이과 문항이고 전공에 과학 키워드만 있으면)
        elif q_cat == '이과계열' and any(kw in major_text for kw in keywords):
            M.append(3)
        else:
            M.append(1)
    return M

# 5) 적합도 계산 함수
def mae_score(S, M):
    mae = sum(abs(s - m) for s, m in zip(S, M)) / len(S)
    return round((1 - mae / 4) * 100, 2)

def weighted_score(S, M):
    W = [2 if m==5 else 1 if m==3 else 0.1 for m in M]
    raw    = sum(w*s for w, s in zip(W, S))
    max_raw= sum(w*5 for w in W)
    return round(raw / max_raw * 100, 2)

# 6) 학생 응답 (Spring에서 주입; 길이 == sample_n)
# 예시 값: 실제로는 외부 입력으로 대체
student_scores = [5, 3, 1, 5, 3, 5, 1, 1, 3, 3]

# 7) 전공별 적합도 계산
results = []
for _, major_row in df_major.iterrows():
    M = generate_major_pref(major_row, df_q_sample, science_keywords)
    results.append({
        'major': major_row['major'],
        'MAE_적합도': mae_score(student_scores, M),
        '가중치_적합도': weighted_score(student_scores, M),
    })

df_res = pd.DataFrame(results)

# 8) 가중치_적합도 기준 내림차순 정렬 후 상위 3개 추출
df_top3 = df_res.sort_values('가중치_적합도', ascending=False).head(3).reset_index(drop=True)

print("=== 랜덤 샘플링된 10문항으로 계산한 Top 3 추천 학과 ===")
print(df_top3)
