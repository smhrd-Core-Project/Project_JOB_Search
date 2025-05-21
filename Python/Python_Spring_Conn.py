from fastapi import FastAPI
from pydantic import BaseModel
from fastapi.middleware.cors import CORSMiddleware
from major_score import recommend_major

app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://192.168.219.47:8081"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class QuestionScore(BaseModel):
    question: str
    score: str  

class SurveyInput(BaseModel):
    answers: list[QuestionScore]
    major_type: str  # "이과계열", "문과계열", "예체능계열" 등

@app.post("/recommend_major")
def recommend(survey: SurveyInput):
    user_answers = [(item.question, item.score) for item in survey.answers]
    result = recommend_major(user_answers, survey.major_type)  # [{'학과명': ..., '유사도': ...}, ...]
    # '학과명'만 뽑아서 리스트로 변환
    recommended_majors = [item['학과명'] for item in result]
    return {"majors": recommended_majors}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("Python_Spring_Conn:app", host="0.0.0.0", port=9001, reload=True)