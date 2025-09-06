import json
import requests
import pytest
import time

BASE_URL = "http://127.0.0.1:8080"

# Load test cases once for all tests
with open("../autotester/test_cases.json") as f:
    cases = json.load(f)

def wait_for_server():
    for _ in range(10):
        try:
            res = requests.get(BASE_URL + "/slugToTitle")
            if res.status_code == 200:
                return True
        except requests.exceptions.ConnectionError:
            time.sleep(1)
    pytest.exit("Server didn't start in time.")

# Ensure server is up before running tests
@pytest.fixture(scope="session", autouse=True)
def setup():
    wait_for_server()

@pytest.mark.parametrize("case", cases["slugToTitle"])
def test_slug_to_title(case):
    res = requests.get(f"{BASE_URL}/slugToTitle", params={"slug": case["input"]})
    assert res.status_code == 200
    assert res.text.strip() == case["expected"]

@pytest.mark.parametrize("case", cases["projectEntry"])
def test_project_entry(case):
    res = requests.post(f"{BASE_URL}/projectEntry", json=case["input"])
    assert res.status_code == case["expectedStatus"]

@pytest.mark.parametrize("case", cases["summary"])
def test_summary(case):
    res = requests.get(f"{BASE_URL}/summary", params={"name": case["query"]})
    assert res.status_code == case["expectedStatus"]
