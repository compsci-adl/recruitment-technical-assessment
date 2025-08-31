from flask import Flask, request
from typing import List, Dict, Union

# ==== DO NOT CHANGE ==========================================================
app = Flask(__name__)

# ==== Type Definitions, feel free to add or modify ===========================
project_registry: Dict[str, Dict] = {}

class Slug:
    def __init__(self, slug: str):
        self.slug = slug


class ProjectEntry:
    def __init__(self, name: str, requiredResources: List[Dict[str, Union[str, int]]]):
        self.type = "project"
        self.name = name
        self.requiredResources = requiredResources


class ResourceEntry:
    def __init__(self, name: str, buildTime: int):
        self.type = "resource"
        self.name = name
        self.buildTime = buildTime

# ==== Task 1 =================================================================
@app.route("/slugToTitle", methods=["GET"])
def slug_to_title():
    slug = request.args.get("slug")
    # TODO: Convert hyphenated lowercase string into title-cased string
    return "", 200

# ==== Task 2 =================================================================
@app.route("/projectEntry", methods=["POST"])
def add_project_entry():
    data = request.get_json()
    # TODO: Validate input and store in `project_registry`
    return "", 200


# ==== Task 3 =================================================================
@app.route("/summary", methods=["GET"])
def get_summary():
    name = request.args.get("name")
    # TODO: Lookup entry and compute total build time and base resources
    return "", 200


# ==== DO NOT CHANGE ==========================================================
if __name__ == "__main__":
    app.run(debug=True, port=8080)
