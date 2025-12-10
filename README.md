# AI Pizza 🍕 Review Agent 🤖

Simple, local AI agent that answers questions about a pizza restaurant by retrieving relevant customer reviews and generating concise answers with an LLM.

**Key features**
- Retrieves the most relevant reviews using embeddings + a vector database (Chroma)
- Uses a local LLM via Ollama (no external APIs required)
- Interactive CLI: ask questions, get context-aware answers
- Data source is a CSV file today; can be extended to fetch from URLs, websites, or data stores

**Tech Stack**
- `Python` (3.10+)
- `LangChain` for prompt/chain composition
- `Ollama` for local LLM and embeddings (`llama3.2`, `mxbai-embed-large`)
- `Chroma` (LangChain integration) for persistent vector search
- `pandas` for CSV ingestion

**Project Structure**
```
AI Pizza Agent/
	main.py                  # CLI loop: prompt + answer
	vector.py                # Builds/loads Chroma DB + retriever
	realistic_restaurant_reviews.csv  # Review dataset (source data)
	requirements.txt         # Python dependencies
```

**Use Case**
- Quickly explore customer feedback about a pizza restaurant.
- Ask targeted questions such as: "What do customers say about delivery time?" or "How is the pepperoni pizza rated?"
- The agent pulls top-k relevant reviews and uses the LLM to generate a helpful answer.

**Data Source**
- Current source: `AI Pizza Agent/realistic_restaurant_reviews.csv` (Title, Review, Rating, Date).
- First run creates a local Chroma DB at `AI Pizza Agent/chroma_langchain_db/` for fast retrieval.

**Future Data Inputs**
- Replace/augment CSV with:
	- A provided link (HTTP/HTTPS) to fetch and parse reviews
	- Website scraping (robots.txt compliant) and cleaning pipelines
	- Cloud/DB sources (e.g., PostgreSQL, MySQL, MongoDB, Azure Storage, S3)
	- Public review APIs
- The `vector.py` module can be extended to ingest these sources and re-index the Chroma DB.

## Running Locally (macOS, zsh)

1) Install and run Ollama
```bash
brew install ollama
ollama serve
```

2) Pull required models (new terminal)
```bash
ollama pull llama3.2
ollama pull mxbai-embed-large
```

3) Create venv, install deps, run
```bash
cd "pizza_review_agent"
make venv
make install
make run
```

Or manually:
```bash
cd "AI Pizza Agent"
python3 -m venv venv
source venv/bin/activate
pip install -U pip
pip install -r requirements.txt
python main.py
```

Quit the app with `q` when prompted.

## CI Notes
- CI performs linting and syntax checks only; it does not run Ollama.
- CSV is loaded with a path relative to `vector.py`, so non-CWD imports are safe.

## Extending the Agent
- Update `vector.py` to add new loaders (CSV/URL/API/DB) and re-run to rebuild embeddings.
- Tune `search_kwargs` (e.g., `k`) for retrieval depth.
- Adjust the system prompt in `main.py` to change tone or answer style.

## License
- This repository contains user-provided review CSV data. Ensure you have rights to any external data sources you add.
