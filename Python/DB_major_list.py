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

sql = """
INSERT INTO tb_major (
    major_idx,          -- CSV에서 가져온 majorSeq 사용!
    major_name,
    major_division,
    major_description,
    university,
    major_skill,
    common_subj,
    no_marl_subj,
    major_iclass,
    career_selec,
    created_at
) VALUES (
    :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, SYSDATE
)
"""

total = 0
for path in csv_files:
    df = pd.read_csv(path)
    df = df.dropna(subset=[
        'majorSeq', 'major', 'class_type', 'property', 'schoolName', 'interest',
        '공통과목', '일반선택과목', '진로선택과목', 'lClass'
    ])
    # 바인딩 순서: majorSeq, major, class_type, property, schoolName, interest, 공통과목, 일반선택과목, lClass, 진로선택과목
    data = df[[
        'majorSeq',      # :1 major_idx
        'major',         # :2 major_name
        'class_type',    # :3 major_division
        'property',      # :4 major_description
        'schoolName',    # :5 university
        'interest',      # :6 major_skill
        '공통과목',       # :7 common_subj
        '일반선택과목',    # :8 no_marl_subj
        'lClass',        # :9 major_iclass
        '진로선택과목'     # :10 career_selec
    ]].values.tolist()
    cursor.executemany(sql, data)
    conn.commit()
    print(f"{path}: {len(data)} rows inserted")
    total += len(data)

print(f"Total inserted into tb_major: {total}")

cursor.close()
conn.close()
