import pandas as pd
import ast

# 1. 파일 경로 및 열 선택택
file1 = 'Python/csv_folder/job_list.csv'
file2 = 'Python/csv_folder/job_list_details.csv'

columns_file1 = ['jobdicSeq', 'job', 'summary', 'salery']
columns_file2 = ['aptitude', 'capacity_major']

df1 = pd.read_csv(file1, usecols=columns_file1)
df2 = pd.read_csv(file2, usecols=columns_file2)

# 2. capacity_major 가공
def parse_capacity_major(raw):
    result = {"capacity": None, "major_seqs": None, "major_names": None}
    if pd.isna(raw):
        return result
    try:
        data_list = ast.literal_eval(raw)  # 문자열 → 리스트
        for item in data_list:
            if isinstance(item, dict):
                if 'capacity' in item:
                    result['capacity'] = item['capacity']
                if 'major' in item:
                    majors = item['major']
                    result['major_names'] = ", ".join(
                        m.get('MAJOR_NM', '') for m in majors if 'MAJOR_NM' in m
                    )
                    result['major_seqs'] = ", ".join(
                        str(m.get('MAJOR_SEQ', '')) for m in majors if 'MAJOR_SEQ' in m
                    )
    except Exception as e:
        print("⚠️ 파싱 오류:", raw, "→", e)

    return result
# 3. capacity_major 열 가공
parsed_df = df2["capacity_major"].apply(parse_capacity_major).apply(pd.Series)

# 4. 기존 df2에 병합
df2 = pd.concat([df2.drop(columns=["capacity_major"]), parsed_df], axis=1)

# 5. 병합 (원한다면 df1과 df2도 병합 가능)
final_df = pd.concat([df1, df2], axis=1)

# 6. 저장
final_df.to_csv("Python/job_list_info_plus.csv", index=False, encoding="utf-8-sig")

print(f"✅ 저장 완료: job_list_info_plus.csv (행 수: {len(final_df)})")
