from fastapi import FastAPI
from pydantic import BaseModel
import uvicorn
import os
import uuid
import time

app = FastAPI()


# Movies
@app.get("/movies")
def get_celeb_movies(name: str):
	if name == "vin disel":
		return {"movie_list": ["fast and the furious", "2 fast 2 furious"]}
	else:
		return {"movie_list": []}


# Bungheads
class BungheadRequestBody(BaseModel):
	first: str
	last: str
	occupation: str


@app.post("/bungheads/apply/")
def get_test_data_for_endpoint_a(person: BungheadRequestBody):
	return {"identifier": uuid.uuid4(), "created_at": time.time(), "person": person}


# Time
@app.get("/time")
def get_time():
	return {"time": time.time()}


# Empty
@app.get("/empty")
def get_empty():
	return {}


if __name__ == "__main__":
	port = int(os.getenv("PORT", 8070))
	uvicorn.run(app, host='localhost', port=port)
