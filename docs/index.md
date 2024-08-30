---
title: Welcome to InstructLab!
description: The overview of 🐶 InstructLab.
logo: images/ilab_dog.png
---
# Welcome to the 🐶 InstructLab Project

![Banner](images/instructlab-banner.png)

InstructLab is a model-agnostic open source AI project that facilitates contributions to Large Language Models (LLMs).

We are on a mission to let anyone shape generative AI by enabling contributed updates to existing LLMs in an accessible way.

**Our community welcomes all those who would like to help us enable everyone to shape the future of generative AI.**

## Why InstructLab

There are many projects rapidly embracing and extending permissively licensed AI models, but they are faced with three main challenges:

* Contribution to LLMs is not possible directly. They show up as forks, which forces consumers to choose a “best-fit” model that isn’t easily extensible. Also, the forks are expensive for model creators to maintain.
* The ability to contribute ideas is limited by a lack of AI/ML expertise. One has to learn how to fork, train, and refine models to see their idea move forward. This is a high barrier to entry.
* There is no direct community governance or best practice around review, curation, and distribution of forked models.

**InstructLab is here to solve these problems.**

The project enables community contributors to add additional "skills" or "knowledge" to a particular model.

InstructLab's model-agnostic technology gives model upstreams with sufficient infrastructure resources the ability to create regular builds of their open source licensed models not by rebuilding and retraining the entire model but by composing new skills into it.

Take a look at "lab-enhanced" models on the [InstructLab Hugging Face page](https://huggingface.co/instructlab).

## 📋 Requirements

- **🍎 Apple M1/M2/M3 Mac or 🐧 Linux system** (tested on Fedora).
  We anticipate support for more operating systems in the future.
- C++ compiler
- Python 3.10 or Python 3.11
- Approximately 60GB disk space (entire process)

!!! note
    Python 3.12 is currently not supported, because some dependencies don't work on Python 3.12, yet.

!!! tip
    When installing the `ilab` CLI on macOS, you may have to run the `xcode-select --install` command, installing the required packages previously listed.

