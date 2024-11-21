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

2) When prompted, clone the `https://github.com/instructlab/taxonomy.git` repository into the current directory by typing **enter**

   **Optional**: If you want to point to an existing local clone of the `taxonomy` repository, you can pass the path interactively or alternatively with the `--taxonomy-path` flag.

   `ilab` will use the default configuration file unless otherwise specified. You can override this behavior with the `--config` parameter for any `ilab` command.

3) When prompted, provide the path to your default model. Otherwise, the default of a quantized [Merlinite](https://huggingface.co/instructlab/merlinite-7b-lab-GGUF) model is used.

*Example output of steps 1 - 3*
```shell
----------------------------------------------------
         Welcome to the InstructLab CLI
This guide will help you to setup your environment
----------------------------------------------------

Please provide the following values to initiate the environment [press Enter for defaults]:
Path to taxonomy repo [/Users/<user>/.local/share/instructlab/taxonomy]:
Path to your model [/Users/<user>/.cache/instructlab/models/merlinite-7b-lab-Q4_K_M.gguf]:
```

You can download this model with `ilab model download` command as well.

4) The InstructLab CLI auto-detects your hardware and select the exact system profile that matches your machine. System profiles populate the `config.yaml` file with the proper parameter values based on your detected GPU types and avaiible vRAM.

*Example output of profile auto-detection*

```shell
Generating config file and profiles:
/home/user/.config/instructlab/config.yaml
/home/user/.local/share/instructlab/internal/train_configuration/profiles

We have detected the AMD CPU profile as an exact match for your system.

--------------------------------------------
   Initialization completed successfully!
   You're ready to start using `ilab`. Enjoy!
--------------------------------------------
``` 

5) If there is not an exact match for your system, you can manually select a system profile when prompted. There are various flags you can utilize with individual `ilab` commands that allow you to utilize your GPU if applicable.

*Example output of selecting a system profile*

```shell
Please choose a system profile to use.
System profiles apply to all parts of the config file and set hardware specific defaults for each command.
First, please select the hardware vendor your system falls into
[1] APPLE
[2] INTEL
[3] AMD
[4] NVIDIA
Enter the number of your choice [0]: 1
You selected: APPLE
Next, please select the specific hardware configuration that most closely matches your system.
[0] No system profile
[1] APPLE M1 ULTRA
[2] APPLE M1 MAX
[3] APPLE M2 MAX
[4] APPLE M2 ULTRA
[5] APPLE M2 PRO
[6] APPLE M2
[7] APPLE M3 MAX
[8] APPLE M3 PRO
[9] APPLE M3
Enter the number of your choice [hit enter for hardware defaults] [0]: 8
You selected: /Users/kellybrown/.local/share/instructlab/internal/system_profiles/apple/m3/m3_pro.yaml

--------------------------------------------
   Initialization completed successfully!
You're ready to start using `ilab`. Enjoy!
--------------------------------------------
```

The GPU profiles are listed by GPU type and number of GPUs present. If you happen to have a GPU configuration with a similar amount of vRAM as any of the above profiles, feel free to try them out!

### `ilab` directory layout after initializing your system

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
