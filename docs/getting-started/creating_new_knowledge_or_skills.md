## 💻 Creating new knowledge or skills and training the model

### 🎁 Contribute knowledge or compositional skills

Detailed contribution instructions can be found in the [taxonomy repository](https://github.com/instructlab/taxonomy/blob/main/README.md).

!!! important
    There is a limit to how much content can exist in the question/answer pairs for the model to process. Due to this, only add a maximum of around 2300 words to your question and answer seed example pairs in the `qna.yaml` file.

### 📜 List and validate your new data

You can use the `ilab taxonomy diff` command to ensure `ilab` is registering your new knowledge or skills and your contributions are properly formatted. This command displays any new or modified YAML files within your taxonomy tree. For example, the following is the expected result of a valid compositional skill contribution after adding a new skill called `foo-lang` to the freeform writing subdirectory:

```shell
(venv) $ ilab taxonomy diff
compositional_skills/writing/freeform/foo-lang/qna.yaml
Taxonomy in $HOME/.local/share/instructlab/taxonomy is valid :)
```

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

   With GPU acceleration:

   ```shell
   ilab data generate --pipeline full --gpus <NUM_OF_GPUS>
   ```

   Without GPU acceleration:

   ```shell
   ilab data generate --pipeline simple
   ```

   Use a non-default model (e.g. Mixtral-8x7B-Instruct-v0.1) to generate data, run the following command:

   ```shell
   ilab data generate --model ~/.cache/instructlab/models/mistralai/mixtral-8x7b-instruct-v0.1 --pipeline full --gpus 4
   ```

!!! note
    ⏳ This can take from 15 minutes to 1+ hours to complete, depending on your computing resources.

   *Example output of `ilab data generate`*

   ```shell
   (venv) $ ilab data generate
   INFO 2024-07-30 19:57:44,093 numexpr.utils:161: NumExpr defaulting to 8 threads.
   INFO 2024-07-30 19:57:44,452 datasets:58: PyTorch version 2.3.1 available.
   Generating synthetic data using 'simple' pipeline, '$HOME/.cache/instructlab/models/mixtral-8x7b-instruct-v0.1.Q4_K_M.gguf' model, './taxonomy' taxonomy, against http://localhost:8000/v1 server
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

   The synthetic data set will be two files in the newly created in the datasets directory. On Linux this will be: `~/.local/share/instructlab/datasets` and on MacOS this will be `~/Library/Application Support/instructlab/datasets`. These files will be named `skills_train_msgs_*.jsonl` and `knowledge_train_msgs_*.jsonl`.

2) Verify the files have been created by running the `ls datasets` command. Note: you must be in your `XDG_DATA_HOME/instructlab` directory.

   ```shell
   (venv) $ ls datasets/
   node_datasets_2024-08-12T20_31_15                          test_mixtral-8x7b-instruct-v0-1_2024-08-12T20_23_06.jsonl
   knowledge_recipe_2024-08-12T20_31_15.yaml                      node_datasets_2024-08-13T19_51_48                          test_mixtral-8x7b-instruct-v0-1_2024-08-12T20_31_15.jsonl
   knowledge_recipe_2024-08-13T19_51_48.yaml                      skills_recipe_2024-08-12T20_31_15.yaml                     test_mixtral-8x7b-instruct-v0-1_2024-08-13T19_47_59.jsonl
   knowledge_train_msgs_2024-08-12T20_31_15.jsonl                 skills_recipe_2024-08-13T19_51_48.yaml                     test_mixtral-8x7b-instruct-v0-1_2024-08-13T19_51_48.jsonl
   knowledge_train_msgs_2024-08-13T19_51_48.jsonl                 skills_train_msgs_2024-08-12T20_31_15.jsonl                train_mixtral-8x7b-instruct-v0-1_2024-08-12T20_31_15.jsonl
   messages_mixtral-8x7b-instruct-v0-1_2024-08-12T20_31_15.jsonl  skills_train_msgs_2024-08-13T19_51_48.jsonl                train_mixtral-8x7b-instruct-v0-1_2024-08-13T19_51_48.jsonl
   messages_mixtral-8x7b-instruct-v0-1_2024-08-13T19_51_48.jsonl  test_mixtral-8x7b-instruct-v0-1_2024-08-12T20_13_21.jsonl
   ```

   **Optional**: It is also possible to run the generate step against a different model via an
   OpenAI-compatible API. For example, the one spawned by `ilab model serve` or any remote or locally hosted LLM (e.g. via [`ollama`](https://ollama.com/), [`LM Studio`](https://lmstudio.ai), etc.). Run the following command:

   ```shell
   ilab data generate --endpoint-url http://localhost:8000/v1
   ```

Note that it is also possible to generate a synthetic dataset based on the entire contents of the taxonomy repo using the `--taxonomy-base=empty` option:

   ```shell
   ilab data generate --taxonomy-base=empty
   ```

### 👩🏫 Training the model

There are many options for training the model with your synthetic data-enhanced dataset.

!!! note
    **Every** `ilab` command needs to run from within your Python virtual environment.

#### Train the model locally on Linux

```shell
ilab model train
```

!!! note
    ⏳ This step can potentially take **several hours** to complete depending on your computing resources. Please stop `ilab model chat` and `ilab model serve` first to free resources.

If you are using `ilab model train --legacy` or are on MacOS:

`ilab model train` outputs a brand-new model that can be served in the `models` directory called `ggml-model-f16.gguf`.

If you are using `ilab model train` with a GPU enabled system:

`ilab model train` outputs brand-new models that can be served in the `~/.local/share/instructlab/checkpoints` directory.  These models can be run through `ilab model evaluate` to choose the best one.

If you are using `ilab model train --strategy lab-multiphase`

#### Train the model locally on an M-series Mac

To train the model locally on your M-Series Mac is as easy as running:

```shell
ilab model train
```

!!! note
    ⏳ This process will take a little while to complete (time can vary based on hardware and output of `ilab data generate` but on the order of 5 to 15 minutes)

`ilab model train` outputs a brand-new model that is saved in the `<model_name>-mlx-q` directory called `adapters.npz` (in `Numpy` compressed array format). For example:

```shell
(venv) $ ls instructlab-merlinite-7b-lab-mlx-q
adapters-010.npz        adapters-050.npz        adapters-090.npz        config.json             tokenizer.model
adapters-020.npz        adapters-060.npz        adapters-100.npz        model.safetensors       tokenizer_config.json
adapters-030.npz        adapters-070.npz        adapters.npz            special_tokens_map.json
adapters-040.npz        adapters-080.npz        added_tokens.json       tokenizer.jso
```

#### Train the model locally with GPU acceleration

Training has experimental support for GPU acceleration with NVIDIA CUDA or AMD ROCm. Please see [the GPU acceleration documentation](./docs/gpu-acceleration.md) for more details. At present, hardware acceleration requires a data center GPU or high-end consumer GPU with at least 18 GB free memory.

```shell
ilab model train --device=cuda
```

This version of `ilab model train` outputs brand-new models that can be served in the `~/.local/share/instructlab/checkpoints` directory on Linux and `~/Library/Application Support/instructlab/checkpoints` on MacOS.  These models can be run through `ilab model evaluate` to choose the best one.

#### Train the model locally with multi-phase training and GPU acceleration

`ilab model train` supports multi-phase training. This results in the following workflow:

1. We train the model on knowledge
2. Evaluate the trained model to find the best checkpoint
3. We train the model on skills
4. We evaluate the model to find the best overall checkpoint

```shell
ilab model train --strategy lab-multiphase --phased-phase1-data <knowledge train messages jsonl> --phased-phase2-data <skills train messages jsonl> -y
```

This command takes in two `.jsonl` files from your `datasets` directory, one is the knowledge jsonl and the other is a skills jsonl. The `-y` flag skips an interactive prompt asking the user if they are sure they want to run multi-phase training.

Note: this command may take 3 or more hours depending on the size of the data and number of training epochs you run.

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

!!! note
    MTBench and MTBenchBranch use [prometheus-8x7b-v2.0](https://huggingface.co/prometheus-eval/prometheus-8x7b-v2.0) as the judge model by default. While you do not need to use this model as your judge, it is strongly recommended to do so if you have the necessary hardware resources. You can download it via `ilab model download`.

#### Running MMLU

Below is an example of running MMLU on a local model with minimal tasks:

```bash
export INSTRUCTLAB_EVAL_MMLU_MIN_TASKS=true   # don't set this if you want to run full MMLU
export ILAB_MODELS_DIR=$HOME/.local/share/instructlab/models
ilab model evaluate --benchmark mmlu --model $ILAB_MODELS_DIR/instructlab/granite-7b-lab
...
# KNOWLEDGE EVALUATION REPORT

## MODEL
/home/example-user/.local/share/instructlab/models/instructlab/granite-7b-lab

### AVERAGE:
0.45 (across 3)

### SCORES:
mmlu_abstract_algebra - 0.35
mmlu_anatomy - 0.44
mmlu_astronomy - 0.55
```

Below is an example of running MMLU on a Hugging Face model with minimal tasks:

```bash
export INSTRUCTLAB_EVAL_MMLU_MIN_TASKS=true   # don't set this if you want to run full MMLU
ilab model evaluate --benchmark mmlu --model instructlab/granite-7b-lab
...
# KNOWLEDGE EVALUATION REPORT

## MODEL
instructlab/granite-7b-lab

### AVERAGE:
0.45 (across 3)

### SCORES:
mmlu_abstract_algebra - 0.35
mmlu_anatomy - 0.44
mmlu_astronomy - 0.55
```

!!! note
    Currently, MMLU can only be run against a safetensors model directory, either locally or on Hugging Face. GGUFs are not currently supported.

#### Running MMLUBranch

Below is an example of running MMLUBranch with a local safetensors model directory:

```bash
export ILAB_MODELS_DIR=$HOME/.local/share/instructlab/models
ilab model evaluate --benchmark mmlu_branch --model $ILAB_MODELS_DIR/instructlab/granite-7b-lab --base-model $ILAB_MODELS_DIR/instructlab/granite-7b-lab
...
# KNOWLEDGE EVALUATION REPORT

## BASE MODEL
/home/example-user/.local/share/instructlab/models/instructlab/granite-7b-lab

## MODEL
/home/example-user/.local/share/instructlab/models/instructlab/granite-7b-lab

### AVERAGE:
+0.0 (across 1)

### NO CHANGE:
1. tonsils
```

Below is an example of running MMLUBranch with Hugging Face models:

```bash
ilab model evaluate --benchmark mmlu_branch --model instructlab/granite-7b-lab --base-model instructlab/granite-7b-lab
...
# KNOWLEDGE EVALUATION REPORT

## BASE MODEL
instructlab/granite-7b-lab

## MODEL
instructlab/granite-7b-lab

### AVERAGE:
+0.0 (across 1)

### NO CHANGE:
1. tonsils
```

!!! tip
    You can mix and match running local models and remote models on Hugging Face, so long as a safetensors model is present.

#### Running MTBench

Below is an example of running MTBench with a local safetensors model directory:

```bash
export ILAB_MODELS_DIR=$HOME/.local/share/instructlab/models
ilab model evaluate --benchmark mt_bench --model $ILAB_MODELS_DIR/instructlab/granite-7b-lab --judge-model $ILAB_MODELS_DIR/instructlab/granite-7b-lab
...
# SKILL EVALUATION REPORT

## MODEL
/home/example-user/.local/share/instructlab/models/instructlab/granite-7b-lab

### AVERAGE:
8.07 (across 91)

### TURN ONE:
8.64

### TURN TWO:
7.19

### ERROR RATE:
0.43
```

Below is an example of running MTBench with local GGUF models:

```bash
export ILAB_MODELS_DIR=$HOME/.local/share/instructlab/models
ilab model evaluate --benchmark mt_bench --model $ILAB_MODELS_DIR/granite-7b-lab-Q4_K_M.gguf --judge-model $ILAB_MODELS_DIR/granite-7b-lab-Q4_K_M.gguf
...
# SKILL EVALUATION REPORT

## MODEL
/home/example/.local/share/instructlab/models/granite-7b-lab-Q4_K_M.gguf

### AVERAGE:
5.0 (across 1)

### TURN ONE:
5.0

### TURN TWO:
N/A

### ERROR RATE:
0.99
```

!!! note
    Currently, MTBench must be used with local models. Using models directly from Hugging Face without downloading them is unsupported.

#### Running MTBenchBranch

Below is an example of running MTBenchBranch with a local safetensors model directory:

```bash
export ILAB_MODELS_DIR=$HOME/.local/share/instructlab/models
export ILAB_TAXONOMY_DIR=$HOME/.local/share/instructlab/taxonomy
ilab model evaluate --benchmark mt_bench_branch \
 --model $ILAB_MODELS_DIR/instructlab/granite-7b-lab \
 --judge-model $ILAB_MODELS_DIR/instructlab/granite-7b-lab \
 --base-model $ILAB_MODELS_DIR/instructlab/granite-7b-lab \
 --taxonomy-path $ILAB_TAXONOMY_DIR \
 --branch rc \
 --base-branch main
...
# SKILL EVALUATION REPORT

## BASE MODEL
/home/example/.local/share/instructlab/models/instructlab/granite-7b-lab

## MODEL
/home/example/.local/share/instructlab/models/instructlab/granite-7b-lab

### IMPROVEMENTS:
1. compositional_skills/extraction/receipt/markdown/qna.yaml (+4.0)
2. compositional_skills/STEM/science/units_conversion/temperature_conversion/qna.yaml (+3.0)
3. compositional_skills/extraction/commercial_lease_agreement/bullet_points/qna.yaml (+3.0)
...

### REGRESSIONS:
1. compositional_skills/extraction/abstractive/title/qna.yaml (-5.0)
2. compositional_skills/extraction/receipt/bullet_points/qna.yaml (-4.5)
3. compositional_skills/writing/grounded/summarization/wiki_insights/one_line/qna.yaml (-4.0)
...

### NO CHANGE:
1. compositional_skills/STEM/math/reasoning/qna.yaml
2. compositional_skills/extraction/commercial_lease_agreement/csv/qna.yaml
3. compositional_skills/roleplay/explain_like_i_am/graduate/qna.yaml
...

### NEW:
1. compositional_skills/linguistics/organize_lists/qna.yaml
2. compositional_skills/extraction/invoice/plain_text/qna.yaml
3. compositional_skills/writing/grounded/summarization/wiki_insights/concise/qna.yaml
...

### ERROR RATE:
0.32
```

Below is an example of running MTBenchBranch with local GGUF models:

```bash
export ILAB_MODELS_DIR=$HOME/.local/share/instructlab/models
export ILAB_TAXONOMY_DIR=$HOME/.local/share/instructlab/taxonomy
ilab model evaluate --benchmark mt_bench_branch --model $ILAB_MODELS_DIR/granite-7b-lab-Q4_K_M.gguf --judge-model $ILAB_MODELS_DIR/granite-7b-lab-Q4_K_M.gguf --base-model $ILAB_MODELS_DIR/granite-7b-lab-Q4_K_M.gguf --taxonomy-path $ILAB_TAXONOMY_DIR --branch rc --base-branch main
...
# SKILL EVALUATION REPORT

## BASE MODEL
/home/ec2-user/.local/share/instructlab/models/granite-7b-lab-Q4_K_M.gguf

## MODEL
/home/ec2-user/.local/share/instructlab/models/granite-7b-lab-Q4_K_M.gguf

### NO CHANGE:
1. compositional_skills/STEM/math/distance_conversion/qna.yaml

### NEW:
1. compositional_skills/linguistics/organize_lists/qna.yaml
2. compositional_skills/extraction/annual_report/reasoning/qna.yaml
3. compositional_skills/extraction/email/plain_text/qna.yaml
4. compositional_skills/extraction/technical_paper/tables/bullet_points/qna.yaml
5. compositional_skills/extraction/technical_paper/abstract/reasoning/qna.yaml

### ERROR RATE:
0.98
```

!!! note
    Currently, MTBenchBranch must be used with local models. Using models directly from Hugging Face without downloading them is unsupported.

### 🍴 Serve the newly trained model

1) Stop the server you have running by entering `ctrl+c` keys in the terminal running the server.

!!! important
    🍎 This step is only implemented for macOS with M-series chips (for now).

   - Before serving the newly trained model you must convert it to work with
   the `ilab` cli. The `ilab model convert` command converts the new model into quantized [GGUF](https://medium.com/@sandyeep70/ggml-to-gguf-a-leap-in-language-model-file-formats-cd5d3a6058f9) format which is required by the server to host the model in the `ilab model serve` command.

2) Convert the newly trained model by running the following command:

   ```shell
   ilab model convert
   ```

3) Serve the newly trained model locally via `ilab model serve` command with the `--model-path`
argument to specify your new model:

   ```shell
   ilab model serve --model-path <new model path>
   ```

   Which model should you select to serve? After running the `ilab model convert` command, some files and a directory are generated. The model you will want to serve ends with an extension of `.gguf`
   and exists in a directory with the suffix `trained`. For example:
   `instructlab-merlinite-7b-lab-trained/instructlab-merlinite-7b-lab-Q4_K_M.gguf`.
