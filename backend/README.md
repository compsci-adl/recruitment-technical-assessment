> This task is relevant for **any project with a backend (minus DuckBot)**
> (CS Club Website, MyTimetable, MyVote).

# CS Club Open Source Team Recruitment Technical Assessment: Backend
> **YOU DON'T NEED TO COMPLETE ALL PARTS.** 
> Complete the parts that you think **best** reflect your skills (you can do them in any order).

## Introduction
- You can (and we would prefer) that you implement your solution in this directory, although you may decide to create your own repository
- This is a qualitative technical assessment that will be reviewed by our **Open Source & Infrastructure Manager** and **Open Source Officers** to make a judgment on progressing your application to an interview.
- Your code will be considered holistically, taking in to account correctness, efficiency and code style.
- You can use either `Python` or `TypeScript` to solve these tasks. Please select **ONE** lanaguage to complete the following tasks in. Templates for both have been set up for you.

## Tasks
### Task 1
In many backend platforms, like content management systems or URL-based APIs, data is stored or referenced using `slugs`. These are lowercase, hyphen-separated strings that are URL-friendly and easy to store.

Your task is to build a utility function that **converts slugs to human-readable titles**.

For example: `meet-and-greet-s1-2025 -> Meet and Greet S1 2025`.

This means:
- Replace hyphens with spaces.
- Capitalise each word, except for known uppercase tokens like S1, S2, T1, etc. (Assume you may be passed things like t2, s2 — you should normalise these.)
- Handle numeric values properly (like years).

## Task 2

You're building a backend system for a **student project registry**, where teams can submit and manage their work. The registry exposes a public **HTTP `POST /projectEntry`** endpoint that accepts new submissions.

Each submission is an **entry** with a `name` (`string`) and a `type` (`"project"` or `"resource"`):

### Entry Types

- **Project**:
  - **Must** include a `requiredResources` list.
  - Each item in `requiredResources` includes:
    - `name` (`string`)
    - `quantity` (`int`)
  - This allows a project to declare dependencies on other resources or projects.

- **Resource**:
  - **Must** include a `buildTime` (`int`), which represents how long it takes to provision.
  - `buildTime` must be **greater than or equal to 0**.


### Example Entries

```json
// Project with two dependencies (one resource, one project)
{
  "type": "project",
  "name": "MyVotingApp",
  "requiredResources": [
    {
      "name": "ReactLib",
      "quantity": 1
    },
    {
      "name": "AuthService",
      "quantity": 2
    }
  ]
}
```

```json
// Project with a single dependency
{
  "type": "project",
  "name": "AuthService",
  "requiredResources": [
    {
      "name": "GoRuntime",
      "quantity": 1
    }
  ]
}
```

```json
// A resource with provisioning time
{
  "type": "resource",
  "name": "GoRuntime",
  "buildTime": 10
}
```

```json
// A resource with instant setup
{
  "type": "resource",
  "name": "ReactLib",
  "buildTime": 0
}
```

### Expected Results

On success:
```
HTTP 200 OK
```

On failure (invalid submission):
```
HTTP 400 Bad Request
```

The system must **reject** the entry and return `400 Bad Request` if:

- `type` is not `project` or `resource`.
- A `resource` has a `buildTime` < 0.
- The `name` is **not unique** in the registry.
- A `project` includes duplicate resource names in `requiredResources`.

> **Note:** You do **not** need to validate whether referenced resources or projects actually exist in the registry yet.


### Template Code

Inside both `py_template/` and `ts_template/`, you'll find:

- A stub implementation of the `POST /projectEntry` endpoint.
- Predefined types for `ProjectEntry` and `ResourceEntry`.

Your task is to **complete the endpoint and implement the validation logic** described above.

## Task 3
Teams are submitting complex projects to your student project registry, and some projects depend on others. To help users understand what resources are truly required to build a project, your system should expose a **summary endpoint** that returns the full list of underlying base resources and total build time.

Your backend should expose an HTTP **`GET /summary`** endpoint that accepts a query parameter:

```
/summary?name=<project name>
```

This endpoint returns a summary of the **project** including:

- `name` (`string`): The name of the project.
- `buildTime` (`int`): The total time to build the project, calculated as the sum of the build times of all required base resources (multiplied by their quantities).
- `resources` (`RequiredResource[]`): A flattened list of only the base **resources** required by the project, with quantities aggregated across dependencies.

### Example Project Graph

Suppose you have the following entries in your system:

```json
{
  "type": "project",
  "name": "MyVotingApp",
  "requiredResources": [
    { "name": "ReactLib", "quantity": 1 },
    { "name": "AuthService", "quantity": 2 }
  ]
},
{
  "type": "project",
  "name": "AuthService",
  "requiredResources": [
    { "name": "GoRuntime", "quantity": 1 }
  ]
},
{
  "type": "project",
  "name": "ReactLib",
  "requiredResources": [
    { "name": "JSRuntime", "quantity": 2 },
    { "name": "StyleSheet", "quantity": 1 }
  ]
},
{
  "type": "resource",
  "name": "GoRuntime",
  "buildTime": 10
},
{
  "type": "resource",
  "name": "JSRuntime",
  "buildTime": 3
},
{
  "type": "resource",
  "name": "StyleSheet",
  "buildTime": 1
}
```

Requesting `/summary?name=MyVotingApp` should return:

```json
{
  "name": "MyVotingApp",
  "buildTime": 30,
  "resources": [
    { "name": "GoRuntime", "quantity": 2 },
    { "name": "JSRuntime", "quantity": 2 },
    { "name": "StyleSheet", "quantity": 1 }
  ]
}
```

Breakdown:
- `GoRuntime` is required by `AuthService`, which appears **twice** -> `10 × 2 = 20`
- `ReactLib` requires:
  - `JSRuntime × 2` -> `3 × 2 = 6`
  - `StyleSheet × 1` -> `1 × 1 = 1`
- Total buildTime: `20 + 6 + 1 = 27`

### Expected Results

On success:  
```
HTTP 200 OK
```
with the JSON summary as described above.

On error:
```
HTTP 400 Bad Request
```

Return `400` if:
  - A project with the given name **does not exist**.
  - The name refers to a `resource`, not a `project`.
  - A dependency (project or resource) in the graph **does not exist**.

---

### Assumptions

- The resource list returned in `resources` can be in any order.
- You don’t need to handle projects with an empty `requiredResources` list.
- For 400 errors, you only need to return the correct status code, error messages themselves are not tested.
- Circular dependencies will not appear in test cases.

### Template Code

This task builds on top of the entries you've submitted via `POST /projectEntry`. Use your in-memory registry or database to implement this new `GET /summary` logic.

Both `py_template/` and `ts_template/` folders already include starter code and definitions for:
- `ProjectEntry`
- `ResourceEntry`
- `RequiredResource`


## Getting set up
A basic flask/express application has been set up for you in `[py|ts]_template/task.py`, including some endpoints. To run it, enter `./run.sh` in the `[py|ts]_template` folder, and a server should be spun up on port 8080.

The script assumes you have the required runtimes installed for your chosen language.

## Testing
Basic assert-based tests are provided in the `autotester` directory, but they are not comprehensive, and we recommend doing some manual testing to ensure your solutions are correct.

In each of the `[py|ts]_template/` directories, a `test.sh` script has been provided.

You can run your implementation against the given tests by running `./test.sh` from within the directory of your chosen language. You may also choose to run tests for each individual part with:

```
./test.sh [part1 | part2 | part3]
```

The script once again assumes you have the required runtimes installed for your chosen language.

### Manual
If you would prefer to manually run the autotests. First start up your server in the `[py|ts]_template/` directory in one terminal, and then in another window:
```
cd autotester
npm i
npm run test(_part[1|2|3])
```
Note that you will need to restart the server (since the server put in some dummy data) to re-run the tests.
