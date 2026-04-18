@echo off
echo [Arena Assist] Starting backend server with venv...
call "%~dp0venv\Scripts\activate.bat"
python -m uvicorn  backend.main:app --host 0.0.0.0 --port 8000 --reload
