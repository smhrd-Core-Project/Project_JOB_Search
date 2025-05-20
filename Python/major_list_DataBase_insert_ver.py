#### 데이터 가공하여 데이터 베이스에 넣기 위한 작업
#### 원하는 데이터만 다시 csv저장 하는 코드 
import pandas as pd, ast

df = pd.read_csv("Python/major_univ_list_details.csv")


TARGETS = ["공통과목", "일반선택과목", "진로선택과목"]

def extract_three(raw):
    out = {t: None for t in TARGETS}
    if pd.isna(raw):
        return out
    for item in ast.literal_eval(raw):
        if item.get("subject_name") in TARGETS:
            out[item["subject_name"]] = item.get("subject_description")
    return out

# 1) 과목 3종 컬럼화
subj_df = df["relate_subject"].apply(extract_three).apply(pd.Series)

# 2) 함께 담고 싶은 기본 정보 컬럼
base_cols = ["majorSeq", "major", "majorSummary", "job_salary", "interest", "property"]

#    → 존재하는 컬럼만 필터링
base_cols = [c for c in base_cols if c in df.columns]

# 3) 합치고 저장
final_df = pd.concat([df[base_cols], subj_df], axis=1)
final_df.to_csv("Python/major_subjects_plus.csv", index=False, encoding="utf-8-sig")

print(f"🎉 저장 완료: major_subjects_plus.csv  (행 {len(final_df)})")
