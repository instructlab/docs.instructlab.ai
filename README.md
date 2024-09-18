# docs.instructlab.ai

To test documentation changes locally, you'll need to install `mkdocs` and the relevant dependencies in your Python environment.

We've included a server launching script for ease of use.

## Getting Started

1. Create a virtual environment for your installation.

```bash
python -m venv venv-ilab-docs
source venv-ilab-docs/bin/activate
```

2. Launch the server.

This will:
* Install mkdocs
* Install the PyPI dependencies
* Launch the mkdocs server locally

```bash
./launch_server.sh
```

3. Visit [https://127.0.0.1:8000/](https://127.0.0.1:8000/) to see your changes in the browser.
