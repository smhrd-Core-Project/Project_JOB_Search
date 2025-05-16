import pandas as pd

# 1. CSV 파일 불러오기 (첫 번째 줄이 열 이름이라고 가정)
df = pd.read_csv("Python\group_question.csv")

# 2. 학과별로 묶기
science_groups = [0, 1, 2, 11, 12, 13, 14, 16]
liberal_arts_groups = [3, 4, 5, 8, 9, 10, 15]
arts_groups = [6, 7]

# 3. 계열 열 추가
def assign_category(group):
    if group in science_groups:
        return '이과계열'
    elif group in liberal_arts_groups:
        return '문과계열'
    elif group in arts_groups:
        return '예체능계열'
    else:
        return '기타'

df['계열'] = df['group'].apply(assign_category)

# 계열별로 데이터 분리
science_df = df[df['계열'] == '이과계열']
liberal_arts_df = df[df['계열'] == '문과계열']
arts_df = df[df['계열'] == '예체능계열']

science_df.to_csv("Python\ques_science_group.csv", index=False, encoding='utf-8-sig')
liberal_arts_df.to_csv("Python\ques_liberal_arts_group.csv", index=False, encoding='utf-8-sig')
arts_df.to_csv("Python\ques_artgroup.csv", index=False, encoding='utf-8-sig')