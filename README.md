# COBOL Web Modernization Demo

![COBOL](https://img.shields.io/badge/COBOL-Business%20Logic-004B87?style=for-the-badge)
![COBOL Modernization](https://img.shields.io/badge/COBOL-Modernization-orange?style=for-the-badge)
![COBOL Not Legacy](https://img.shields.io/badge/COBOL-%E2%89%A0%20Legacy-red?style=for-the-badge)

![Node.js](https://img.shields.io/badge/Node.js-Backend-339933?style=for-the-badge&logo=node.js&logoColor=white)
![React](https://img.shields.io/badge/React-Frontend-61DAFB?style=for-the-badge&logo=react&logoColor=black)
![Vite](https://img.shields.io/badge/Vite-Build%20Tool-646CFF?style=for-the-badge&logo=vite&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Containerized-2496ED?style=for-the-badge&logo=docker&logoColor=white)

---

This repository continues the discussion about **COBOL modernization**.

Modernizing COBOL systems does **not necessarily mean replacing COBOL**.

In many cases, the best approach is to **preserve existing business logic and integrate it with modern technologies**.

This project demonstrates that approach by exposing COBOL programs through a modern web architecture while keeping the COBOL logic intact.

The stack integrates:

* COBOL business logic executed with GnuCOBOL
* A REST API built with Node.js
* A modern React interface
* Containerized deployment using Docker

---

This project demonstrates a **COBOL application modernization approach** using a modern web architecture running inside Docker containers.

The system executes COBOL programs compiled for Linux and exposes them in two ways:

* **Web Mode** – through a REST API consumed by a React frontend
* **Character Mode** – direct execution through the container terminal

The purpose is to show how legacy COBOL applications can be **integrated with modern technologies without rewriting the business logic**.

---

# Architecture

```
Browser
   ↓
Frontend (React + Vite)
   ↓
Backend API (Node.js + Express)
   ↓
COBOL Executables (GnuCOBOL)
```

All components run inside **Docker containers**.

---

# Technologies Used

## Backend

* Node.js
* Express
* TypeScript

## Frontend

* React
* Vite
* TypeScript

## COBOL

* GnuCOBOL
* Linux COBOL executables

## Infrastructure

* Docker
* Docker Compose

---

# Project Structure

```
project
│
├─ backend
│   API responsible for executing COBOL programs
│
├─ frontend
│   React web interface
│
├─ cobol
│   ├─ objects
│   │   compiled COBOL executables
│   │
│   └─ data
│       data files used by COBOL programs
│
└─ docker-compose.yml
```

**COBOL source code is not included in this repository**, only compiled executables.

---

# Running the Project

## Requirements

* Docker
* Docker Compose

From the project root directory run:

```
docker compose up --build
```

After startup the services will be available at:

Frontend

```
http://localhost:5173
```

Backend API

```
http://localhost:3000
```

---

# Testing the COBOL API

Endpoint:

```
POST /api/exec
```

Example request:

```
POST http://localhost:3000/api/exec
```

Request body example:

```json
{
  "program": "PROG001",
  "func": "RECORD-ACCESS",
  "data": "1"
}
```

The backend will execute the COBOL program and return the response as JSON.

---

# Running COBOL in Character Mode

The COBOL programs can also be executed directly inside the backend container.

Access the backend container:

```
docker exec -it cobol-api /bin/bash
```

Navigate to the COBOL executable directory:

```
cd /app/cobol/objects
```

Run a program:

```
./MAINPROG
```

This allows the application to run in the **traditional terminal mode**, without using the API.

---

# Project Purpose

This project illustrates a typical **legacy system modernization strategy**:

* preserving existing COBOL business logic
* exposing functionality through a REST API
* providing a modern web interface
* using containers for portability and reproducibility

This approach allows organizations to **evolve COBOL systems incrementally** instead of performing a full rewrite.

---

# License

This project was created for educational and demonstration purposes.
