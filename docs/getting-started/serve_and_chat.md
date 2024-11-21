---
title: Serving and Chatting 
description: Steps on how to serve and chat with a model
logo: images/ilab_dog.png
---

# 🍴 Serving the model

Serve the model by running the following command:

```shell
ilab model serve
```

Serve a non-default model with the following command:

```shell
ilab model serve --model-path models/granite-7b-instruct.GGUF
```

*Example output of a model that is served and ready*

```shell
(venv) $ ilab model serve
INFO 2024-03-02 02:21:11,352 lab.py:201 Using model 'models/ggml-merlinite-7b-lab-Q4_K_M.gguf' with -1 gpu-layers and 4096 max context size.
Starting server process
After application startup complete see http://127.0.0.1:8000/docs for API.
Press CTRL+C to shut down the server.
```

!!! note
    If multiple `ilab` clients try to connect to the same InstructLab server at the same time, the 1st will connect to the server while the others will start their own temporary server. This will require additional resources on the host machine.

Serve a non-default Safetensors model (e.g. granite-7b-lab). NOTE: this requires a GPU.

a. Ensure vllm is installed:

```shell
pip show vllm
```

b. If it is not, please run:

```shell
pip install vllm@git+https://github.com/opendatahub-io/vllm@2024.08.01
```

```shell
ilab model serve --model-path ~/.cache/instructlab/models/instructlab/granite-7b-lab
```

# 📣 Chat with the model (Optional)

Because you're serving the model in one terminal window, you will have to create a new window and re-activate your Python virtual environment to run `ilab model chat` command:

```shell
source venv/bin/activate
ilab model chat
```

Chat with a non-default model (e.g. Mixtral-8x7B-Instruct-v0.1):

```shell
source venv/bin/activate
ilab model chat --model models/mixtral-8x7b-instruct-v0.1.Q4_K_M.gguf
```

Please note that usage of `--model` necessitates that the existing server has that model. If not, you must exit the server. `--model` in `ilab model chat` has the ability to start a server on your behalf with the specified model if one is not already running on the port.

Before you start adding new skills and knowledge to your model, you can check its baseline performance by asking it a question such as `what is the capital of Canada?`.

!!! note
    The model needs to be trained with the generated synthetic data to use any new skills or knowledge


```shell
(venv) $ ilab model chat
╭────────────────────────────────────────────────────────────────────────────────────────────────────────────────── system ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ Welcome to InstructLab Chat w/ GGML-MERLINITE-7B-lab-Q4_K_M (type /h for help)                                                                                                                                                                    │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
>>> what is the capital of Canada                                                                                                                                                                                                 [S][default]
╭────────────────────────────────────────────────────────────────────────────────────────────────────── ggml-merlinite-7b-lab-Q4_K_M ───────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ The capital city of Canada is Ottawa. It is located in the province of Ontario, on the southern banks of the Ottawa River in the eastern portion of southern Ontario. The city serves as the political center for Canada, as it is home to │
│ Parliament Hill, which houses the House of Commons, Senate, Supreme Court, and Cabinet of Canada. Ottawa has a rich history and cultural significance, making it an essential part of Canada's identity.                                   │
╰─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────── elapsed 12.008 seconds ─╯
```