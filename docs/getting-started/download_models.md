---
title: Downloading LLMs
description: Steps on how to download models using `ilab`
logo: images/ilab_dog.png
---

# 📥 Download the model

- Run the `ilab model download` command.

```shell
ilab model download
```

`ilab model download` downloads a compact pre-trained version of the [model](https://huggingface.co/instructlab/) (~4.4G) from HuggingFace:

```shell
(venv) $ ilab model download
Downloading model from Hugging Face: instructlab/merlinite-7b-lab-GGUF@main to /Users/USERNAME/Library/Caches/instructlab/models...
...
INFO 2024-08-01 15:05:48,464 huggingface_hub.file_download:1893: Download complete. Moving file to /Users/USERNAME/Library/Caches/instructlab/models/merlinite-7b-lab-Q4_K_M.gguf
```

!!! note
    ⏳ This command can take few minutes or immediately depending on your internet connection or model is cached. If you have issues connecting to Hugging Face, refer to the [Hugging Face discussion forum](https://discuss.huggingface.co/) for more details.

## Downloading an entire Hugging Face repository (Safetensors Model)

- Specify repository, and a Hugging Face token if necessary. For example:

```shell
HF_TOKEN=<YOUR HUGGINGFACE TOKEN GOES HERE> ilab model download --repository=instructlab/granite-7b-lab
```

These types of models are useful for GPU-enabled systems or anyone looking to serve a model using vLLM. InstructLab provides Safetensor versions of our Granite models on HuggingFace.

## Listing downloaded models

All downloaded models can be seen with the `ilab model list` command.

```shell
ilab model list
```

*Example output of `ilab model list` after `ilab model download`*

```shell
(venv) $ ilab model list
+------------------------------+---------------------+--------+
| Model Name                   | Last Modified       | Size   |
+------------------------------+---------------------+--------+
| merlinite-7b-lab-Q4_K_M.gguf | 2024-08-01 15:05:48 | 4.1 GB |
+------------------------------+---------------------+--------+
```
