import requests
import pandas as pd

# API 기본 설정
api_url = "https://www.career.go.kr/inspct/openapi/test/questions"
api_key = "40a3da87cb22a970f00568a36eb974b1"

def fetch_question_data():
    params = {
        'apikey': api_key,   # ✅ 반드시 소문자 'apikey'
        'q': '31'
    }

    response = requests.get(api_url, params=params)
    json_data = response.json()

    questions = json_data.get("RESULT", [])

    print(f"✅ 총 질문 수: {len(questions)}개")
    return questions

def save_to_csv(data, filename="question_list_1.csv"):
    df = pd.DataFrame(data)
    if df.empty:
        print("❌ 수집된 데이터가 없습니다.")
    else:
        df = df.dropna(axis=1, how='all')
        df = df.loc[:, ~(df == '').all()]
        df.to_csv(filename, index=False, encoding='utf-8-sig')
        print(f"✅ CSV 저장 완료: {filename} (총 {len(df)}개 항목)")

if __name__ == "__main__":
    question_data = fetch_question_data()
    save_to_csv(question_data)
