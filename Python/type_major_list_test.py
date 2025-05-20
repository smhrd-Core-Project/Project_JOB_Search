import pandas as pd
import ast

################################################################
#  학과특징 + 계열(class_type) + schoolName(상위 5개, 문자열) 추출 코드
################################################################

# 1) 원본 상세 데이터 불러오기
details_df = pd.read_csv("Python/major_univ_list_details.csv", encoding="utf-8-sig")

# 2) university 컬럼에서 상위 5개 schoolName 리스트 추출 함수
def extract_top5_schools(raw):
    if pd.isna(raw):
        return []
    try:
        data = ast.literal_eval(raw)
    except Exception:
        return []
    seen = set()
    result = []
    for entry in data:
        if isinstance(entry, dict):
            name = entry.get("schoolName")
            if name and name not in seen:
                seen.add(name)
                result.append(name)
                if len(result) == 5:
                    break
    return result

# 3) schoolName 컬럼에 리스트 → 문자열로 변환 (대학1, 대학2, …)
details_df["schoolName"] = (
    details_df["university"]
    .apply(extract_top5_schools)
    .apply(lambda lst: ", ".join(lst) if lst else "")
)

# 4) 과목 3종 컬럼화
TARGETS = ["공통과목", "일반선택과목", "진로선택과목"]
def extract_three(raw):
    out = {t: None for t in TARGETS}
    if pd.isna(raw):
        return out
    try:
        items = ast.literal_eval(raw)
    except Exception:
        return out
    for item in items:
        name = item.get("subject_name")
        if name in TARGETS:
            out[name] = item.get("subject_description")
    return out

subj_df = details_df["relate_subject"].apply(extract_three).apply(pd.Series)

# 5) 기본 정보 + schoolName(문자열) + 과목 컬럼 합치기
base_cols = [
    "majorSeq", "major", "majorSummary", "job_salary",
    "interest", "property", "schoolName"
]
base_cols = [c for c in base_cols if c in details_df.columns]
final_df = pd.concat([details_df[base_cols], subj_df], axis=1)

# 6) 매핑 파일 불러오기 (lClass 포함)
map_df = pd.read_csv("Python/major_list.csv", dtype={"majorSeq": int}, encoding="utf-8-sig")

# 7) majorSeq 기준으로 merge + 결측값 채우기
final_df = final_df.merge(
    map_df[["majorSeq", "lClass"]],
    on="majorSeq", how="left"
)
final_df["lClass"] = final_df["lClass"].fillna("기타계열")

# 8) class_type 컬럼 추가: 문과·이과·예체능·기타
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

################################################################
# 9) class_type별 CSV 분리 저장
################################################################
for cat in ["문과계열", "이과계열", "예체능계열"]:
    subset = final_df[final_df["class_type"] == cat]
    out_path = f"Python/major_subjects_{cat}.csv"
    subset.to_csv(out_path, index=False, encoding="utf-8-sig")
    print(f"✅ {cat} 저장 → {out_path} (행 {len(subset)})")
