import pandas as pd
import ast

################################################################
#  학과특징 + 계열(class_type) 추가 코드
################################################################

# 1) 원본 상세 데이터 불러오기
details_df = pd.read_csv("Python/major_univ_list_details.csv", encoding="utf-8-sig")

TARGETS = ["공통과목", "일반선택과목", "진로선택과목"]
def extract_three(raw):
    out = {t: None for t in TARGETS}
    if pd.isna(raw):
        return out
    for item in ast.literal_eval(raw):
        if item.get("subject_name") in TARGETS:
            out[item["subject_name"]] = item.get("subject_description")
    return out

# 2) 과목 3종 컬럼화
subj_df = details_df["relate_subject"].apply(extract_three).apply(pd.Series)

# 3) 기본 정보 컬럼만 뽑아서 합치기
base_cols = ["majorSeq", "major", "majorSummary", "job_salary", "interest", "property"]
base_cols = [c for c in base_cols if c in details_df.columns]
final_df = pd.concat([details_df[base_cols], subj_df], axis=1)

# 4) 매핑 파일 불러오기 (lClass 포함)
map_df = pd.read_csv("Python/major_list.csv", dtype={"majorSeq": int}, encoding="utf-8-sig")
#    → map_df 에는 ['majorSeq','lClass',…] 가 들어있어야 합니다.

# 5) majorSeq 기준으로 merge
final_df = final_df.merge(
    map_df[["majorSeq", "lClass"]],
    on="majorSeq",
    how="left"
)

# 6) 누락된 계열은 기본값으로 채우기
final_df["lClass"] = final_df["lClass"].fillna("기타계열")

# 7) class_type 컬럼 추가: 문과·이과·예체능·기타
def classify_type(lclass):
    if lclass in ["인문계열", "사회계열", "교육계열"]:
        return "문과계열"
    elif lclass in ["자연계열", "공학계열", "의약계열"]:
        return "이과계열"
    elif lclass == "예체능계열":
        return "예체능계열"
    else:
        return "기타"

final_df["class_type"] = final_df["lClass"].apply(classify_type)

# 8) 최종 CSV 저장
final_df.to_csv(
    "Python/major_subjects_plus_with_lclass_and_type.csv",
    index=False,
    encoding="utf-8-sig"
)

print(f"✅ 저장 완료: major_subjects_plus_with_lclass_and_type.csv (행 {len(final_df)})")
