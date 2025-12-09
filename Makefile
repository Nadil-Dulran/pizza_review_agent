APP_DIR := AI Pizza Agent
PY := python3
VENV_DIR := venv

.PHONY: venv install run clean

venv:
	cd "$(APP_DIR)" && $(PY) -m venv $(VENV_DIR)
	@echo "Virtual env created at $(APP_DIR)/$(VENV_DIR)"

install:
	cd "$(APP_DIR)" && source $(VENV_DIR)/bin/activate && pip install -U pip && pip install -r requirements.txt
	@echo "Dependencies installed in $(APP_DIR)/$(VENV_DIR)"

run:
	cd "$(APP_DIR)" && source $(VENV_DIR)/bin/activate && python main.py

clean:
	rm -rf "$(APP_DIR)/$(VENV_DIR)"
	rm -rf "$(APP_DIR)/__pycache__"
	rm -rf "$(APP_DIR)/chroma_langchain_db"
	@echo "Cleaned venv, caches, and local DB"