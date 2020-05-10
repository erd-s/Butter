from fastapi import FastAPI
import uvicorn
import os


app = FastAPI()


@app.get("/test/a")
def get_test_data_for_endpoint_a():
    return {"movie_list": ["fast and the furious", "2 fast 2 furious"]}


@app.get("/test/b")
def get_test_data_for_endpoint_a():
    return {"movie_list": ["fast and the furious: tokyo drift", "fast 4"]}


@app.get("/test/c")
def get_test_data_for_endpoint_a():
    return {"movie_list": ["fast 5", "2 fast 2 furious"]}


if __name__ == "__main__":
    port = int(os.getenv("PORT", 8070))
    uvicorn.run(app, host='localhost', port=port)
