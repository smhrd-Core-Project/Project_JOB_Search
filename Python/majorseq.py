import pandas as pd
import requests
import time

API_KEY = "40a3da87cb22a970f00568a36eb974b1"
API_URL = "https://www.career.go.kr/cnet/openapi/getOpenApi"

# 1. majorSeq 불러오기
df = pd.read_csv("major_list.csv")

if 'majorSeq' not in df.columns:
    print("❌ 'majorSeq' 컬럼이 없습니다.")
    print("현재 컬럼:", df.columns)
    exit()

seq_list = df['majorSeq'].dropna().astype(str).unique().tolist()

results = []

# 2. 각 majorSeq에 대해 API 호출
for i, major_seq in enumerate(seq_list, 1):
    params = {
        'apiKey': API_KEY,
        'svcType': 'api',
        'svcCode': 'MAJOR_VIEW',
        'contentType': 'json',
        'gubun': 'univ_list',
        'majorSeq': major_seq
    }

    try:
        res = requests.get(API_URL, params=params, timeout=10)
        res.raise_for_status()

        content_list = res.json().get("dataSearch", {}).get("content", [])

        if content_list:
            for item in content_list:
                item["majorSeq"] = major_seq  # 어떤 majorSeq에서 왔는지 추가
            results.extend(content_list)
            print(f"✅ [{i}] majorSeq={major_seq} → {len(content_list)}건 수집됨")
        else:
            print(f"⚠️ [{i}] majorSeq={major_seq} → 데이터 없음")

    except Exception as e:
        print(f"❌ [{i}] majorSeq={major_seq} 실패: {e}")

    time.sleep(0.2)  # 과도한 요청 방지

# 3. 저장
if results:
    final_df = pd.DataFrame(results)
    final_df.to_csv("major_univ_list_details.csv", index=False, encoding='utf-8-sig')
    print(f"🎉 저장 완료: major_univ_list_details.csv (총 {len(final_df)}건)")
else:
    print("❌ 수집된 데이터가 없습니다.")
