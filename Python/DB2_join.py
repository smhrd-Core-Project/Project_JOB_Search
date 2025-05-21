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
    'Python/job_clean2.csv'
]

# 1. TB_MAJOR 테이블에서 major_idx 값 전부 조회
cursor.execute("SELECT major_idx FROM TB_MAJOR")
major_idx_set = set(str(row[0]) for row in cursor.fetchall())

sql = """
INSERT INTO TB_JOB (
    major_idx, job_name, job_desc,
    job_salary, required_skills, job_qualifications, created_at
) VALUES (:1, :2, :3, :4, :5, :6, sysdate)
"""

total = 0
for path in csv_files:
    df = pd.read_csv(path)
    df = df.dropna(subset=[
        "major_seqs", "job", "summary",
        "salery", "aptitude", "capacity"
    ])
    # major_seqs가 TB_MAJOR에 실제로 있는 값만 필터링
    df = df[df['major_seqs'].astype(str).isin(major_idx_set)]

    data = df[[
        'major_seqs',      # :1 major_idx
        'job',         # :2 job_name
        'summary',    # :3 job_desc
        'salery',      # :4 job_salary
        'aptitude',    # :5 required_skills
        'capacity'      # :6 job_qualifications
    ]].astype(str).values.tolist()
    cursor.executemany(sql, data)
    conn.commit()
    print(f"{path}: {len(data)} rows inserted")
    total += len(data)

print(f"Total inserted into TB_JOB: {total}")

cursor.close()
conn.close()
