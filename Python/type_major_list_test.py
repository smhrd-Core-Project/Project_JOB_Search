import pandas as pd
import ast

################################################################
#  학과특징 + 계열(class_type) + schoolName 추출 코드
################################################################

# 1) 원본 상세 데이터 불러오기 (프로젝트 루트/Python 디렉토리)
details_df = pd.read_csv("Python/major_univ_list_details.csv", encoding="utf-8-sig")

# 2) university 컬럼에서 schoolName만 추출하는 함수
def extract_school(raw):
    if pd.isna(raw):
        return None
    try:
        data = ast.literal_eval(raw)
    except Exception:
        return None
    if isinstance(data, list) and data:
        entry = data[0]
    elif isinstance(data, dict):
        entry = data
    else:
        return None
    return entry.get("schoolName")

# 3) 과목 3종 컬럼화
TARGETS = ["공통과목", "일반선택과목", "진로선택과목"]
def extract_three(raw):
    out = {t: None for t in TARGETS}
    if pd.isna(raw):
        return out
    for item in ast.literal_eval(raw):
        name = item.get("subject_name")
        if name in TARGETS:
            out[name] = item.get("subject_description")
    return out

subj_df = details_df["relate_subject"].apply(extract_three).apply(pd.Series)

# 4) schoolName 컬럼 추가
details_df["schoolName"] = details_df["university"].apply(extract_school)

# 5) 기본 정보 + 과목 + schoolName 합치기
base_cols = ["majorSeq", "major", "majorSummary", "job_salary", "interest", "property", "schoolName"]
base_cols = [c for c in base_cols if c in details_df.columns]
final_df = pd.concat([details_df[base_cols], subj_df], axis=1)

# 6) 추출된 schoolName 샘플 5개 출력
sample_schools = final_df["schoolName"].dropna().unique()[:5]
print("=== 추출된 schoolName 샘플 5개 ===")
for s in sample_schools:
    print(f"- {s}")

# 7) 매핑 파일 불러오기 (lClass 포함)
map_df = pd.read_csv("Python/major_list.csv", dtype={"majorSeq": int}, encoding="utf-8-sig")

# 8) majorSeq 기준으로 merge + 결측값 채우기
final_df = final_df.merge(map_df[["majorSeq", "lClass"]], on="majorSeq", how="left")
final_df["lClass"] = final_df["lClass"].fillna("기타계열")

# 9) class_type 컬럼 추가: 문과·이과·예체능·기타
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
# 10) class_type별 CSV 분리 저장
################################################################
for cat in ["문과계열", "이과계열", "예체능계열"]:
    sub = final_df[final_df["class_type"] == cat]
    out_path = f"Python/major_subjects_{cat}.csv"
    sub.to_csv(out_path, index=False, encoding="utf-8-sig")
    print(f"✅ {cat} 저장 → {out_path}  (행 {len(sub)})")
