import pandas as pd
import oracledb

# ============================================
# Oracle Instant Client 초기화 (Thick 모드)
# ============================================

# 만약 Instant Client 경로를 직접 지정해야 하면 아래 주석을 풀고 경로를 설정하세요.
# oracledb.init_oracle_client(lib_dir=r"C:\oracle\instantclient_19_12")

# Thick 모드로 전환 (Thin 모드 만료 시 사용)
oracledb.init_oracle_client()

# ============================================
# DB 연결 정보
# ============================================
db_user     = "hapjeong_24SW_DS_p2_1"
db_password = "smhrd1"
# SERVICE_NAME 또는 SID 를 실제 값으로 바꿔주세요.
# 예: SERVICE_NAME이 ORCLCDB라면
dsn = "project-db-campus.smhrd.com:1523/XE"

# 연결 (Thick 모드)
conn = oracledb.connect(
    user=db_user,
    password=db_password,
    dsn=dsn
)
cursor = conn.cursor()

# ============================================
# CSV 파일에서 읽어 INSERT
# ============================================
csv_files = [
    'Python/csv_folder/updated_ques_liberal_arts_group.csv',
    'Python/csv_folder/updated_ques_science_group.csv',
    'Python/csv_folder/updated_ques_artgroup.csv'
]

# ======================================
# 4) INSERT 문 정의
# ======================================
sql = """
INSERT INTO tb_survey (survey_content, survey_group)
VALUES (:1, :2)
"""

# ======================================
# 5) 각 CSV 파일에 대해 처리
# ======================================
total = 0
for path in csv_files:
    # 첫 줄을 헤더로 읽어들이므로 header=0 (기본)
    df = pd.read_csv(path)

    # question(설문 내용), 계열(문제 그룹) 컬럼만 선택
    # 컬럼명이 정확히 'question' 과 '계열' 이어야 합니다.
    sub = df[['question','계열']].dropna()

    # 바인딩할 데이터 리스트로 변환
    data = sub.values.tolist()  # [(q1, g1), (q2, g2), ...]

    # 배치 INSERT
    cursor.executemany(sql, data)
    conn.commit()

    print(f"{path}: {len(data)} rows inserted")
    total += len(data)

# ======================================
# 6) 종료
# ======================================
cursor.close()
conn.close()