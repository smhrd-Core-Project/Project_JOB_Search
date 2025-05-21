import pandas as pd

df = pd.read_csv("Python\ques_artgroup.csv")

df['answer02'] = '보통이다'
df['answer03'] = '매우 좋다'
df['answerScore02'] = 3
df['answerScore03'] = 5

df_1 = df.drop(['answer04','answerScore04'], axis=1)


# 4. 파일 저장
df_1.to_csv("Python\\updated_ques_artgroup.csv", index=False, encoding='utf-8-sig')
print("✅ 파일 저장 완료: updated_ques_artgroup.csv")
