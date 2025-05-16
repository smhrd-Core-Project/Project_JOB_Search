import pandas as pd

# 1. CSV 파일 불러오기 (첫 번째 줄이 열 이름이라고 가정)
df = pd.read_csv("Python\question_list_1.csv")

# 2. group 열 추가 (0부터 시작, 9개씩 나누기)
df["group"] = df.index // 9

# 3. 저장
df.to_csv("group_question.csv", index=False, encoding="utf-8-sig")

print("✅ 그룹 열 추가 완료 → group_question.csv 로 저장됨")