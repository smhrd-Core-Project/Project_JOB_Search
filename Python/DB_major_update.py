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
UPDATE tb_major
SET
    major_name = :2,
    major_division = :3,
    major_description = :4,
    university = :5,
    major_skill = :6,
    common_subj = :7,
    no_marl_subj = :8,
    major_iclass = :9,
    career_selec = :10,
    created_at = SYSDATE
WHERE
    major_idx = :1
"""

total = 0
for path in csv_files:
    df = pd.read_csv(path)
    df = df.dropna(subset=[
        'majorSeq', 'major', 'class_type', 'property', 'schoolName', 'interest',
        '공통과목', '일반선택과목', '진로선택과목', 'lClass'
    ])
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
    print(f"{path}: {len(data)} rows updated")
    total += len(data)

print(f"Total updated in tb_major: {total}")

cursor.close()
conn.close()
