## 💻 Generate a model with new skills and knowledge

### 📜 List and validate your new data

You can use the `ilab taxonomy diff` command to ensure `ilab` is registering your new knowledge or skills and your contributions are properly formatted. 

```shell
(venv) $ ilab taxonomy diff
compositional_skills/writing/freeform/foo-lang/qna.yaml
Taxonomy in $HOME/.local/share/instructlab/taxonomy is valid :)
```

This command displays any new or modified YAML files within your taxonomy tree. For example, the following is the expected result of a valid compositional skill contribution after adding a new skill called `foo-lang` to the freeform writing subdirectory.

You can also validate your entire taxonomy by performing a diff against an empty base by using the `--taxonomy-base=empty` argument:

```shell
(venv) $ ilab taxonomy diff --taxonomy-base=empty
compositional_skills/general/tables/empty/qna.yaml
compositional_skills/general/tables/editing/add_remove/qna.yaml
...
Taxonomy in $HOME/.local/share/instructlab/taxonomy is valid :)
```

### 🚀 Generate a synthetic dataset

Before following these instructions, ensure the existing model you are adding skills or knowledge to is still running. Alternatively, `ilab data generate` can start a server for you if you provide a fully qualified model path via `--model`.

1) To generate a synthetic dataset based on your newly added knowledge or skill set in [taxonomy](https://github.com/instructlab/taxonomy.git) repository, run the following command:

 *Default SDG*

```shell
ilab data generate
```

*With GPU acceleration*

```shell
ilab data generate --pipeline full --gpus <NUM_OF_GPUS>
```

*Without GPU acceleration:*

```shell
ilab data generate --pipeline simple
```

*Using a non-default model (e.g. Mixtral-8x7B-Instruct-v0.1) to generate data:*

```shell
ilab data generate --model ~/.cache/instructlab/models/mistralai/mixtral-8x7b-instruct-v0.1 --pipeline full --gpus 4
```

⏳ This can take from 15 minutes to 1+ hours to complete, depending on your computing resources.

*Example output of `ilab data generate`*

```shell
(venv) $ ilab data generate
INFO 2024-07-30 19:57:44,093 numexpr.utils:161: NumExpr defaulting to 8 threads.
INFO 2024-07-30 19:57:44,452 datasets:58: PyTorch version 2.3.1 available.
Generating synthetic data using 'full' pipeline, 'mistral-7b-instruct-v0.2.Q4_K_M.gguf' model, './taxonomy' taxonomy, against http://localhost:8000/v1 server
INFO 2024-07-30 19:57:45,084 instructlab.sdg:375: Synthesizing new instructions. If you aren't satisfied with the generated instructions, interrupt training (Ctrl-C) and try adjusting your YAML files. Adding more examples may help.
INFO 2024-07-30 19:57:45,090 instructlab.sdg.pipeline:153: Running pipeline single-threaded
INFO 2024-07-30 19:57:47,820 instructlab.sdg.llmblock:51: LLM server supports batched inputs: False
INFO 2024-07-30 19:57:47,820 instructlab.sdg.pipeline:197: Running block: gen_skill_freeform
INFO 2024-07-30 19:57:47,820 instructlab.sdg.pipeline:198: Dataset({
features: ['task_description', 'seed_question', 'seed_response'],
num_rows: 5
})
INFO 2024-07-30 20:02:16,455 instructlab.sdg:411: Generated 1 samples
...
```

   The synthetic data set will be two files in the newly created in the datasets directory: `~/.local/share/instructlab/datasets`. These files will be named `skills_train_msgs_*.jsonl` and `knowledge_train_msgs_*.jsonl`.

2) Verify the files have been created by running the `ls datasets` command in the `.local/share/instructlab` directory.

   ```shell
   (venv) $ ls datasets/
   ├── node_datasets_2024-08-12T20_31_15
   ├── node_datasets_2024-08-13T19_51_48
   ├── knowledge_recipe_2024-08-12T20_31_15.yaml
   ├── knowledge_recipe_2024-08-13T19_51_48.yaml
   ├── knowledge_train_msgs_2024-08-12T20_31_15.jsonl
   ├── knowledge_train_msgs_2024-08-13T19_51_48.jsonl
   ├── skills_recipe_2024-08-12T20_31_15.yaml
   ├── skills_recipe_2024-08-13T19_51_48.yaml
   ├── skills_train_msgs_2024-08-12T20_31_15.jsonl
   ├── skills_train_msgs_2024-08-13T19_51_48.jsonl
   ├── messages_mixtral-8x7b-instruct-v0-1_2024-08-12T20_31_15.jsonl
   ├── messages_mixtral-8x7b-instruct-v0-1_2024-08-13T19_51_48.jsonl
   ├── test_mixtral-8x7b-instruct-v0-1_2024-08-12T20_13_21.jsonl
   ├── test_mixtral-8x7b-instruct-v0-1_2024-08-12T20_23_06.jsonl
   ├── test_mixtral-8x7b-instruct-v0-1_2024-08-12T20_31_15.jsonl
   ├── test_mixtral-8x7b-instruct-v0-1_2024-08-13T19_47_59.jsonl
   ├── test_mixtral-8x7b-instruct-v0-1_2024-08-13T19_51_48.jsonl
   ├── train_mixtral-8x7b-instruct-v0-1_2024-08-12T20_31_15.jsonl
   └── train_mixtral-8x7b-instruct-v0-1_2024-08-13T19_51_48.jsonl
   ```

*Generating synthetic data on a different model:* It is also possible to run the generate step against a different model via an
OpenAI-compatible API. For example, the one spawned by `ilab model serve` or any remote or locally hosted LLM (e.g. via [`ollama`](https://ollama.com/), [`LM Studio`](https://lmstudio.ai), etc.). Run the following command:

   ```shell
   ilab data generate --endpoint-url http://localhost:8000/v1
   ```

*Generating synthetic data on the entire taxonomy repo:* You can generate a synthetic dataset based on the entire contents of the taxonomy repo using the `--taxonomy-base=empty` option:

   ```shell
   ilab data generate --taxonomy-base=empty
   ```

### 👩‍🏫 Training the model

There are many options for training the model with your synthetic data-enhanced dataset.

### ✋ Before you begin training

There are a few models you need to download before running the InstructLab end-to-end workflow locally.

Download the `granite-7b-lab` model for training:
```shell
ilab model download --repository instructlab/granite-7b-lab 
```

Download the `prometheus-8x7b-v2.0` for *multi-phase training* and *benchmark evaluation*.
This model is not required for `simple` or `full` training.  
```shell
ilab model download --repository prometheus-eval/prometheus-8x7b-v2.0 --hf-token <your-huggingface-token> 
```

#### InstructLab model training pipelines

`ilab model train` has three pipelines: `simple`, `full`, and `accelerated`. The default is `full`.

1. `simple` uses an SFT Trainer on Linux and MLX on MacOS. This type of training takes roughly an hour and produces the lowest fidelity model but should indicate if your data is being picked up by the training process.
2. `full` uses a custom training loop and data processing functions for the granite family of models. This loop is optimized for CPU and MPS functionality. Please use `--pipeline=full` in combination with `--device=cpu` (Linux) or `--device=mps` (MacOS). You can also use `--device=cpu` on a MacOS machine. However, MPS is optimized for better performance on these systems.
3. `accelerated` uses the instructlab-training library which supports GPU accelerated and distributed training. The `full` loop and data processing functions are either pulled directly from or based off of the work in this library.

After running `ilab model train`, the output locations depend on the chosen pipeline or strategy:

| **Pipeline/Strategy**              | **Operating System** | **Output Location/Details**                                                                                             |
|------------------------------------|----------------------|--------------------------------------------------------------------------------------------------------------------------|
| `simple`                           | Linux                | Model saved in `models` directory as `ggml-model-f16.gguf`.                                                              |
| `simple`                           | MacOS                | Model saved in `<model_name>-mlx-q` directory.                                                                           |
| `full`                             | Linux & MacOS        | `.bin` and `.gguf` models saved in `~/.local/share/instructlab/checkpoints/hf_format` directory. Two models in each `sample_*` directory: one quantized (`Q4-M-K` suffix) and one full precision. |
| `accelerated`                      | Linux                | Models saved in `~/.local/share/instructlab/checkpoints`. Can be evaluated with `ilab model evaluate` to choose the best one. |
| `lab-multiphase`                   | Linux                | Phase 1 models saved in `~/.local/share/instructlab/phased/phase1/checkpoints` (Knowledge training). Phase 2 models saved in `~/.local/share/instructlab/phased/phase2/checkpoints` (Skills training). Evaluation is run for both phases to identify the best checkpoint. |

To limit training time, you can adjust the `num_epoch` paramater in the `config.yaml` file. The maximum number of epochs for running the InstructLab end-to-end workkflow is 10.

#### Train the model locally

Train the model with your synthetic data with the `ilab model train` command:

```shell
ilab model train
```

⏳ This step can potentially take **several hours** to complete depending on your computing resources. Please stop `ilab model chat` and `ilab model serve` first to free resources.

When running multiphase training evaluation is run on each phase, we will tell you which checkpoint in this folder performs the best.

#### Train the model locally on an M-series Mac or on Linux using the full pipeline

To train the model locally on your M-Series Mac using our full pipeline and MPS or on your Linux laptop/desktop using CPU:

```shell
ilab model train --pipeline full --device mps --data-path <path-to-sdg-dataset>
```

```shell
ilab model train --pipeline full --device cpu --data-path <path-to-sdg-dataset>
```

*Example command*

```shell
ilab model train --pipeline full --device cpu --data-path ~/.local/share/instructlab/datasets/knowledge_train_msgs_2024-10-23T09_14_44.jsonl
```

⏳ This process will take a while to complete. If you run for ~8 epochs it will take several hours.

`ilab model train` outputs a directory for each epoch that resembles the following structure:

```shell
$ ls ~/.local/share/instructlab/checkpoints/hf_format/samples_0/
├── added_tokens.json
├── config.json
├── pytorch_model.bin
├── pytorch_model.gguf
├── pytorch_model-Q4_K_M.gguf
├── special_tokens_map.json
├── tokenizer.json
├── tokenizer_config.json
└── tokenizer.model
```

This entire folder can be served on a system that supports vLLM using the `.bin` model. However, on most laptops you can serve either the full precision gguf: `pytorch_model.gguf` or the 4-bit-quantized one: `pytorch_model-Q4_K_M.gguf`.

#### Train the model locally on an M-series Mac or on Linux using the simple pipeline

To train the model locally on your M-Series Mac using our simple pipeline and MLX or on your Linux laptop/desktop using an SFT Trainer:

```shell
ilab model train --pipeline simple
```

⏳ This process will take a little while to complete (time can vary based on hardware and output of `ilab data generate` but on the order of 5 to 15 minutes)

On a Mac `ilab model train` outputs a brand-new model that is saved in the `<model_name>-mlx-q` directory called `adapters.npz` (in `Numpy` compressed array format). For example:

```shell
(venv) $ ls instructlab-granite-7b-lab-mlx-q/
├── adapters-010.npz
├── adapters-020.npz
├── adapters-030.npz
├── adapters-040.npz
├── adapters-050.npz
├── adapters-060.npz
├── adapters-070.npz
├── adapters-080.npz
├── adapters-090.npz
├── adapters-100.npz
├── adapters.npz
├── added_tokens.json
├── config.json
├── model.safetensors
├── special_tokens_map.json
├── tokenizer.json
├── tokenizer.model
└── tokenizer_config.json
```

#### Train the model locally with GPU acceleration

Training has support for GPU acceleration with Nvidia CUDA or AMD ROCm. Please see [the GPU acceleration documentation](https://github.com/instructlab/instructlab/blob/main/docs/gpu-acceleration.md) for more details. At present, hardware acceleration requires a data center GPU or high-end consumer GPU with at least 18 GB free memory.

```shell
ilab model train --pipeline accelerated --device cuda --data-path <path-to-sdg-data>
```

*Example command*

```shell
ilab model train --pipeline full --device cpu --data-path ~/.local/share/instructlab/datasets/knowledge_train_msgs_2024-10-23T09_14_44.jsonl
```

This version of `ilab model train` outputs brand-new models that can be served in the `~/.local/share/instructlab/checkpoints` directory.  These models can be run through `ilab model evaluate` to choose the best one.

#### Train the model locally with multiphase training and GPU acceleration

`ilab model train` supports multiphase training. This results in the following workflow:

1. We train the model on knowledge
2. Evaluate the trained model to find the best checkpoint
3. We train the model on skills
4. We evaluate the model to find the best overall checkpoint

```shell
ilab model train --strategy lab-multiphase --phased-phase1-data <knowledge train messages jsonl> --phased-phase2-data <skills train messages jsonl> -y
```

This command takes in two `.jsonl` files from your `datasets` directory, one is the knowledge jsonl and the other is a skills jsonl. The `-y` flag skips an interactive prompt asking the user if they are sure they want to run multiphase training.

⏳ This command may take 3 or more hours depending on the size of the data and number of training epochs you run.

#### Train the model in the cloud

Follow the instructions in [Training](https://github.com/instructlab/instructlab/blob/main/notebooks/README.md).

⏳ Approximate amount of time taken on each platform:

- *Google Colab*: **5-10 minutes** with a T4 GPU
- *Kaggle*: **~30 minutes** with a P100 GPU.

After that's done, you can play with your model directly in the Google Colab or Kaggle notebook. Model trained on the cloud will be saved on the cloud.
The model can also be downloaded and served locally.

### 📜 Test the newly trained model

- Run the following command to test the model:

   ```shell
   ilab model test
   ```

   The output from the command will consist of a series of outputs from the model before and after training.

### 🧪 Evaluate the newly trained model

You can use the `ilab model evaluate` command to evaluate the models you are training with several benchmarks. Currently, four benchmarks are supported.

| Benchmark | Measures | Full Name | Description | Reference |
| --- | --- | --- | --- | --- |
| MMLU | Knowledge | Massive Multitask Language Understanding | Tests a model against a standardized set of knowledge data and produces a score based on the model's performance | [Measuring Massive Multitask Language Understanding](https://arxiv.org/abs/2009.03300) |
| MMLUBranch | Knowledge | N/A | Tests your knowledge contributions against a base model and produces a score based on the difference in performance | N/A |
| MTBench | Skills | Multi-turn Benchmark | Tests a model's skill at applying its knowledge against a judge model and produces a score based on the model's performance | [MT-Bench (Multi-turn Benchmark)](https://klu.ai/glossary/mt-bench-eval) |
| MTBenchBranch | Skills | N/A | Tests your skill contributions against a judge model and produces a score based on the difference in performance | N/A |

> [!NOTE]
> Evaluation must be used with local models (safetensors or GGUF format). Using models directly from Hugging Face without downloading them is unsupported.
> GGUF models are not yet supported for mmlu and mmlu_branch evaluations
> MTBench and MTBenchBranch use [prometheus-8x7b-v2.0](https://huggingface.co/prometheus-eval/prometheus-8x7b-v2.0) as the judge model by
default. While you do not need to use this model as your judge, it is strongly recommended to do so if you have the necessary hardware
resources. You can download it via `ilab model download`.

#### Running MMLU

Example of running MMLU with a local safetensors model directory:

   ```bash
   $ export ILAB_MODELS_DIR=$HOME/.local/share/instructlab/models
   $ ilab model evaluate --benchmark mmlu --model $ILAB_MODELS_DIR/instructlab/granite-7b-test
   ...
   # KNOWLEDGE EVALUATION REPORT

   ## MODEL (SCORE)
   /home/user/.cache/instructlab/models/instructlab/granite-7b-test (0.52/1.0)

   ### SCORES (0.0 to 1.0):
   mmlu_abstract_algebra - 0.31
   mmlu_anatomy - 0.46
   mmlu_astronomy - 0.52
   mmlu_business_ethics - 0.55
   mmlu_clinical_knowledge - 0.57
   mmlu_college_biology - 0.56
   mmlu_college_chemistry - 0.38
   mmlu_college_computer_science - 0.46
   mmlu_college_mathematics - 0.34
   mmlu_college_medicine - 0.49
   mmlu_college_physics - 0.27
   mmlu_computer_security - 0.66
   mmlu_conceptual_physics - 0.38
   mmlu_econometrics - 0.39
   mmlu_electrical_engineering - 0.48
   mmlu_elementary_mathematics - 0.3
   ...
   ```

   The output of MMLU displays a much longer list of subjects.

#### Running MMLUBranch

Example of running MMLUBranch with a local safetensors model directory:

   ```bash
   $ export ILAB_MODELS_DIR=$HOME/.local/share/instructlab/models
   $ ilab model evaluate --benchmark mmlu_branch --model $ILAB_MODELS_DIR/instructlab/granite-7b-test --base-model $ILAB_MODELS_DIR/instructlab/granite-7b-lab
   ...
   # KNOWLEDGE EVALUATION REPORT

   ## BASE MODEL (SCORE)
   /home/user/.cache/instructlab/models/instructlab/granite-7b-lab (0.74/1.0)

   ## MODEL (SCORE)
   /home/user/.cache/instructlab/models/instructlab/granite-7b-test (0.78/1.0)

   ### IMPROVEMENTS (0.0 to 1.0):
   1. tonsils: 0.74 -> 0.78 (+0.04)
   ```

#### Running MTBench

Example of running MTBench with a local safetensors model directory:

   ```bash
   $ export ILAB_MODELS_DIR=$HOME/.local/share/instructlab/models
   $ ilab model evaluate --benchmark mt_bench --model $ILAB_MODELS_DIR/instructlab/granite-7b-test
   ...
   # SKILL EVALUATION REPORT

   ## MODEL (SCORE)
   /home/user/.cache/instructlab/models/instructlab/granite-7b-test (7.27/10.0)

   ### TURN ONE (0.0 to 10.0):
   7.48

   ### TURN TWO (0.0 to 10.0):
   7.05
   ```

#### Running MTBenchBranch

Below is an example of running MTBenchBranch with a local safetensors model directory:

   ```bash
   $ export ILAB_MODELS_DIR=$HOME/.local/share/instructlab/models
   $ export ILAB_TAXONOMY_DIR=$HOME/.local/share/instructlab/taxonomy
   $ ilab model evaluate --benchmark mt_bench_branch \
      --model $ILAB_MODELS_DIR/instructlab/granite-7b-test \
      --base-model $ILAB_MODELS_DIR/instructlab/granite-7b-lab \
      --taxonomy-path $ILAB_TAXONOMY_DIR \
      --branch rc \
      --base-branch main
   ...
   # SKILL EVALUATION REPORT

   ## BASE MODEL (SCORE)
   /home/user/.cache/instructlab/models/instructlab/granite-7b-lab (5.78/10.0)

   ## MODEL (SCORE)
   /home/user/.cache/instructlab/models/instructlab/granite-7b-test (6.00/10.0)

   ### IMPROVEMENTS (0.0 to 10.0):
   1. foundational_skills/reasoning/linguistics_reasoning/object_identification/qna.yaml: 4.0 -> 6.67 (+2.67)
   2. foundational_skills/reasoning/theory_of_mind/qna.yaml: 3.12 -> 4.0 (+0.88)
   3. foundational_skills/reasoning/linguistics_reasoning/logical_sequence_of_words/qna.yaml: 9.33 -> 10.0 (+0.67)

   ### REGRESSIONS (0.0 to 10.0):
   1. foundational_skills/reasoning/unconventional_reasoning/lower_score_wins/qna.yaml: 5.67 -> 4.0 (-1.67)
   2. foundational_skills/reasoning/mathematical_reasoning/qna.yaml: 7.33 -> 6.0 (-1.33)
   3. foundational_skills/reasoning/temporal_reasoning/qna.yaml: 5.67 -> 4.67 (-1.0)

   ### NO CHANGE (0.0 to 10.0):
   1. foundational_skills/reasoning/linguistics_reasoning/odd_one_out/qna.yaml (9.33)
   2. compositional_skills/grounded/linguistics/inclusion/qna.yaml (6.5)
   ```

### 🍴 Serve the newly trained model

If you have a server running, stop the server you have running by entering `ctrl+c` keys in the terminal running the server.

*🍎 Mac only:* Before serving the newly trained model you must convert it to work with
the `ilab` cli. The `ilab model convert` command converts the new model into quantized [GGUF](https://medium.com/@sandyeep70/ggml-to-gguf-a-leap-in-language-model-file-formats-cd5d3a6058f9) format which is required by the server to host the model in the `ilab model serve` command.

1) Convert the newly trained model by running the following command:

    ```shell
   ilab model convert
   ```

2) Serve the newly trained model locally via `ilab model serve` command with the `--model-path`
argument to specify your new model:

   ```shell
   ilab model serve --model-path <new model path>
   ```

   Which model should you select to serve? After running the `ilab model convert` command, some files and a directory are generated. The model you will want to serve ends with an extension of `.gguf`
   and exists in a directory with the suffix `trained`. For example:
   `instructlab-granite-7b-lab-trained/instructlab-granite-7b-lab-Q4_K_M.gguf`.

## 📣 Chat with the new model (not optional this time)

1) Try the fine-tuned model out live using the chat interface, and see if the results are better than the untrained version of the model with chat by running the following command:

   ```shell
   ilab model chat -m <New model path>
   ```

   If you are interested in optimizing the quality of the model's responses, please see [`TROUBLESHOOTING.md`](https://github.com/instructlab/instructlab/blob/main/TROUBLESHOOTING.md#model-fine-tuning-and-response-optimization)

## 🎁 Submit your new knowledge or skills

Of course, the final step is, if you've improved the model, to open a pull-request in the [taxonomy repository](https://github.com/instructlab/taxonomy) that includes the files (e.g. `qna.yaml`) with your improved data.

## 📬 Contributing

Check out our [contributing](../community/CONTRIBUTING.md) guide to learn how to contribute.