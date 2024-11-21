---
title: Downloading LLMs
description: Steps on how to download models using `ilab`
logo: images/ilab_dog.png
---

# 📥 Download the model

1) Run the ilab model download command to download a compact pre-trained version of the `granite-7b-lab-GGUF`, `merlinite-7b-lab-GGUF`, and `Mistral-7B-Instruct-v0.2-GGUF` models (~4.4G each) from HuggingFace.

```shell
ilab model download
```

`ilab model download` downloads a compact pre-trained version of the [model](https://huggingface.co/instructlab/) (~4.4G) from HuggingFace:

*Example output of the models downloading*

```shell
Downloading model from Hugging Face:
    Model: instructlab/granite-7b-lab-GGUF@main
    Destination: /Users/<user>/.cache/instructlab/models
Downloading model from Hugging Face:
    Model: instructlab/merlinite-7b-lab-GGUF@main
    Destination: /Users/<user>/.cache/instructlab/models
Downloading model from Hugging Face:
    Model: TheBloke/Mistral-7B-Instruct-v0.2-GGUF@main
    Destination: /Users/<user>/.cache/instructlab/models

TheBloke/Mistral-7B-Instruct-v0.2-GGUF requires a HF Token to be set.
Please use '--hf-token' or 'export HF_TOKEN' to download all necessary models.
```

a) You may be prompted to use your Hugging Face token to download the `Mistral-7B-Instruct-v0.2-GGUF` model.

```shell
ilab model download --hf-token <your-huggingface-token>
```

!!! note
    ⏳ This command can take few minutes or immediately depending on your internet connection or model is cached. If you have issues connecting to Hugging Face, refer to the [Hugging Face discussion forum](https://discuss.huggingface.co/) for more details.

## Downloading an entire Hugging Face repository (Safetensors Model)

1) Specify repository, and a Hugging Face token if necessary. For example:

```shell
ilab model download --repository instructlab/granite-7b-lab-GGUF --filename granite-7b-lab-Q4_K_M.gguf --hf-token <your-huggingface-token>
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
+-------------------------------------+---------------------+--------+
| Model Name                          | Last Modified       | Size   |
+-------------------------------------+---------------------+--------+
| granite-7b-lab-Q4_K_M.gguf          | 2024-08-01 15:05:48 | 4.1 GB |
| merlinite-7b-lab-Q4_K_M.gguf        | 2024-08-01 15:05:48 | 4.1 GB |
| mistral-7b-instruct-v0.2.Q4_K_M.gguf| 2024-08-01 15:05:48 | 4.1 GB |
+-------------------------------------+---------------------+--------+
```
