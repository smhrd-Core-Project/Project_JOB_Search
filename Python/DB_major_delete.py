import pandas as pd
import oracledb

oracledb.init_oracle_client()

db_user     = "hapjeong_24SW_DS_p2_1"
db_password = "smhrd1"
dsn = oracledb.makedsn("project-db-campus.smhrd.com", 1523, service_name="XE")

conn   = oracledb.connect(user=db_user, password=db_password, dsn=dsn)
cursor = conn.cursor()
cursor.execute(f"ALTER SESSION SET CURRENT_SCHEMA = {db_user.upper()}")

csv_files = [
    'Python/csv_folder/major_subjects_문과계열.csv',
    'Python/csv_folder/major_subjects_예체능계열.csv',
    'Python/csv_folder/major_subjects_이과계열.csv'
]

# 모든 CSV의 majorSeq 모으기
major_idx_set = set()
for path in csv_files:
    df = pd.read_csv(path)
    major_idx_set.update(df['majorSeq'].dropna().astype(int).tolist())

# major_idx를 튜플로 만들어서 삭제
placeholders = ",".join(str(idx) for idx in major_idx_set) if major_idx_set else "NULL"

sql = f"DELETE FROM tb_major WHERE major_idx NOT IN ({placeholders})"
cursor.execute(sql)
conn.commit()

print(f"Deleted tb_major rows where major_idx NOT IN CSV files")

cursor.close()
conn.close()
