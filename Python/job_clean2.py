import pandas as pd
import re

# summary 전처리 함수
def clean_summary(text):
    if pd.isnull(text):
        return ''
    lines = [line.strip() for line in str(text).splitlines()]
    lines = [re.sub(r"^- ?", "", line).strip() for line in lines if line.strip()]
    joined = " ".join(lines)
    joined = re.sub(r"\.(?! )", ". ", joined)
    joined = re.sub(r"\s+", " ", joined).strip()
    return joined

# aptitude 전처리 함수
def clean_aptitude(text):
    if pd.isnull(text):
        return ''
    lines = [line.strip() for line in str(text).splitlines()]
    lines = [re.sub(r"^[-=] ?", "", line).strip() for line in lines if line.strip()]
    joined = " ".join(lines)
    joined = re.sub(r"\.(?! )", ". ", joined)
    joined = re.sub(r"\s+", " ", joined).strip()
    return joined

# 2. CSV 읽기
csv_path = 'Python/job_clean.csv'
df = pd.read_csv(csv_path)

# 3. 컬럼별 전처리 적용
df['summary'] = df['summary'].apply(clean_summary)
df['aptitude'] = df['aptitude'].apply(clean_aptitude)

# 4. 결과 저장 (새 파일로)
save_path = 'Python/job_clean2.csv'
df.to_csv(save_path, index=False, encoding='utf-8-sig')

print(f"✔️ 전처리 완료! 파일 저장 위치: {save_path}")
