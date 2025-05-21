import pandas as pd

csv_path = 'Python/job_list_info_plus.csv'
df = pd.read_csv(csv_path)

# null, 빈 값 삭제
cond = (~df['major_seqs'].isnull()) & (df['major_seqs'].astype(str).str.strip() != "")
cond2 = (~df['major_names'].isnull()) & (df['major_names'].astype(str).str.strip() != "")
df = df[cond & cond2].copy()

# 각 값을 리스트로 변환
df['major_seqs'] = df['major_seqs'].astype(str).str.split(',')
df['major_names'] = df['major_names'].astype(str).str.split(',')

# 길이가 맞지 않는 경우는 제거
df = df[df.apply(lambda x: len(x['major_seqs']) == len(x['major_names']), axis=1)]

# 쌍별로 행 만들기
df_expanded = df.apply(
    lambda row: [
        {**row.drop(['major_seqs', 'major_names']).to_dict(), 
         'major_seqs': row['major_seqs'][i].strip(),
         'major_names': row['major_names'][i].strip()}
        for i in range(len(row['major_seqs']))
    ],
    axis=1
).explode().apply(pd.Series)

df_expanded = df_expanded.reset_index(drop=True)

# 결과 확인
print(df_expanded[['major_seqs', 'major_names']].head(10))

# 저장까지 하려면
df_expanded.to_csv('Python/job_clean.csv', index=False, encoding='utf-8-sig')
