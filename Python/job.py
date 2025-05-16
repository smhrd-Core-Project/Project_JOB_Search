import requests
import pandas as pd

# API 기본 설정
api_url = "https://www.career.go.kr/cnet/openapi/getOpenApi"
api_key = "40a3da87cb22a970f00568a36eb974b1"

def fetch_job_data():
    page = 1
    per_page = 100
    total_data = []

    while True:
        params = {
            'apiKey': api_key,
            'svcType': 'api',
            'svcCode': 'JOB',
            'contentType': 'json',
            'gubun': 'job_dic_list',
            'thisPage': page,
            'perPage': per_page
        }

        response = requests.get(api_url, params=params)
        json_data = response.json()

        # ✅ 올바른 위치에서 데이터 추출
        page_data = json_data.get("dataSearch", {}).get("content", [])

        print(f"📄 {page}페이지에서 {len(page_data)}개 항목 수집됨")

        if not page_data:
            break

        total_data.extend(page_data)
        page += 1

    return total_data

def save_to_csv(data, filename="job_list.csv"):
    df = pd.DataFrame(data)
    if df.empty:
        print("❌ 수집된 데이터가 없습니다.")
    else:
        df.to_csv(filename, index=False, encoding='utf-8-sig')
        print(f"✅ CSV 저장 완료: {filename} (총 {len(df)}개 항목)")

if __name__ == "__main__":
    job_data = fetch_job_data()
    save_to_csv(job_data)
