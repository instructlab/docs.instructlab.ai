---
title: Initializing InstructLab
description: Steps to initilize InsutrctLab on a local machine
logo: images/ilab_dog.png
---

# 🏗️ Initialize `ilab`

1) Initialize `ilab` by running the following command:

```shell
ilab config init
```

*Example output*

```shell
Welcome to InstructLab CLI. This guide will help you set up your environment.
Please provide the following values to initiate the environment [press Enter for defaults]:
Path to taxonomy repo [taxonomy]: <ENTER>
```

2) When prompted by the interface, press **Enter** to add a new default `config.yaml` file.

3) When prompted, clone the `https://github.com/instructlab/taxonomy.git` repository into the current directory by typing **y**.

   **Optional**: If you want to point to an existing local clone of the `taxonomy` repository, you can pass the path interactively or alternatively with the `--taxonomy-path` flag.

   *Example output after initializing `ilab`*

   ```shell
   (venv) $ ilab config init
   Welcome to InstructLab CLI. This guide will help you set up your environment.
   Please provide the following values to initiate the environment [press Enter for defaults]:
   Path to taxonomy repo [taxonomy]: <ENTER>
   `taxonomy` seems to not exists or is empty. Should I clone https://github.com/instructlab/taxonomy.git for you? [y/N]: y
   Cloning https://github.com/instructlab/taxonomy.git...
   ```

`ilab` will use the default configuration file unless otherwise specified. You can override this behavior with the `--config` parameter for any `ilab` command.

4) When prompted, provide the path to your default model. Otherwise, the default of a quantized [Merlinite](https://huggingface.co/instructlab/merlinite-7b-lab-GGUF) model will be used - you can download this model with `ilab model download`. The following example output displays the paths of a Mac instance.

   ```shell
   (venv) $ ilab config init
   Welcome to InstructLab CLI. This guide will help you set up your environment.
   Please provide the following values to initiate the environment [press Enter for defaults]:
   Path to taxonomy repo [taxonomy]: <ENTER>
   `taxonomy` seems to not exists or is empty. Should I clone https://github.com/instructlab/taxonomy.git for you? [y/N]: y
   Cloning https://github.com/instructlab/taxonomy.git...
   Path to your model [/Users/USERNAME/Library/Caches/instructlab/models/merlinite-7b-lab-Q4_K_M.gguf]: <ENTER>
   ```

5) When prompted, please choose a train profile. Train profiles are GPU specific profiles that enable accelerated training behavior. **YOU ARE ON MacOS**, please choose `No Profile (CPU, Apple Metal, AMD ROCm)` by hitting Enter. There are various flags you can utilize with individual `ilab` commands that will allow you to utilize your GPU if applicable. The following example output uses the Linux paths.

   ```shell
    Welcome to InstructLab CLI. This guide will help you to setup your environment.
    Please provide the following values to initiate the environment [press Enter for defaults]:
    Path to taxonomy repo [/home/user/.local/share/instructlab/taxonomy]:
    Path to your model [/home/user/.cache/instructlab/models/merlinite-7b-lab-Q4_K_M.gguf]:
    Generating `/home/user/.config/instructlab/config.yaml` and `/home/user/.local/share/instructlab/internal/train_configuration/profiles`...
    Please choose a train profile to use.
    Train profiles assist with the complexity of configuring specific GPU hardware with the InstructLab Training library.
    You can still take advantage of hardware acceleration for training even if your hardware is not listed.
    [0] No profile (CPU, Apple Metal, AMD ROCm)
    [1] Nvidia A100/H100 x2 (A100_H100_x2.yaml)
    [2] Nvidia A100/H100 x4 (A100_H100_x4.yaml)
    [3] Nvidia A100/H100 x8 (A100_H100_x8.yaml)
    [4] Nvidia L40 x4 (L40_x4.yaml)
    [5] Nvidia L40 x8 (L40_x8.yaml)
    [6] Nvidia L4 x8 (L4_x8.yaml)
    Enter the number of your choice [hit enter for no profile] [0]:
    No profile selected - any hardware acceleration for training must be configured manually.
    Initialization completed successfully, you're ready to start using `ilab`. Enjoy!
   ```

The GPU profiles are listed by GPU type and number. If you happen to have a GPU configuration with a similar amount of VRAM as any of the above profiles, feel free to try them out!

## `ilab` directory layout after initializing your system

### Mac directory

After running `ilab config init` your directories will look like the following on a Mac system:

```shell
├─ ~/Library/Application\ Support/instructlab/models/ (1)
├─ ~/Library/Application\ Support/instructlab/datasets (2)
├─ ~/Library/Application\ Support/instructlab/taxonomy (3)
├─ ~/Library/Application\ Support/instructlab/checkpoints (4)
```

 1) `/Users/USERNAME/Library/Caches/instructlab/models/`: Contains all downloaded large language models, including the saved output of ones you generate with ilab.

 2) `~/Library/Application\ Support/instructlab/datasets/`: Contains data output from the SDG phase, built on modifications to the taxonomy repository.

 3) `~/Library/Application\ Support/instructlab/taxonomy/`: Contains the skill and knowledge data.

 4) `~/Users/USERNAME/Library/Caches/instructlab/checkpoints/`: Contains the output of the training process

### Linux directory

After running `ilab config init` your directories will look like the following on a Linux system:

```shell
├─ ~/.cache/instructlab/models/ (1)
├─ ~/.local/share/instructlab/datasets (2)
├─ ~/.local/share/instructlab/taxonomy (3)
├─ ~/.local/share/instructlab/checkpoints (4)
```

1) `~/.cache/instructlab/models/`: Contains all downloaded large language models, including the saved output of ones you generate with ilab.

2) `~/.local/share/instructlab/datasets/`: Contains data output from the SDG phase, built on modifications to the taxonomy repository.

3) `~/.local/share/instructlab/taxonomy/`: Contains the skill and knowledge data.

4) `~/.local/share/instructlab/checkpoints/`: Contains the output of the training process
