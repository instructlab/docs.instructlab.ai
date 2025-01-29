---
title: Knowledge Overview
description: Knowledge in 🐶 InstructLab's Taxonomy
logo: images/ilab_dog.png
---
# What is "Knowledge"?

In the InstructLab world, knowledge consists of data and facts and is backed by documents. When you create knowledge for a model, you're giving it additional data to more accurately answer questions.

Knowledge contributions in this project contain a few things:

- A Markdown or PDF file in a git repository that holds your information. For example, these repositories can include Markdown or PDF versions of information on Oscar 2024 winners, Law books, Shakespeare, Sports, Chemistry, etc. Note that sources must be licensed using a compatible license. Learn more from [our list of accepted sources](../upstream/knowledge_contribution_details.md#accepted-sources-of-knowledge).
- A `qna.yaml` file that asks and answers questions about the information in the git repository.
- An `attribution.txt` file that includes the sources for the information used in the `qna.yaml`. **Note that this file is not required if you are not submitting to the upstream taxonomy repository at [https://github.com/instructlab/taxonomy](https://github.com/instructlab/taxonomy).**

You can learn more about the knowledge structure in [the documentation for the file structure for knowledge](file_structure.md).

## Getting Started with Knowledge

While skills are foundational or performative, knowledge is based more on answering questions that involve facts, data, or references.

Knowledge is supported by documents, such as a textbook, technical manual, encyclopedia, journal, or magazine.

Knowledge in the taxonomy tree consists of a few more elements than skills:

- Each knowledge node in the tree has a `qna.yaml`, similar to the format of the `qna.yaml` for skills.
- ⭐ Currently, for the synthetic data generation (SDG) process to work, knowledge submissions require you to create a Git repository, which can be with GitHub, that contains the markdown files of your knowledge contributions. These contributions in your repository must either be in Markdown (`.md`) format or as a PDF (`.pdf`).
- The `qna.yaml` includes parameters that contain information from your repository.

!!! tip
    Guidelines for Knowledge contributions

    - Submit the most up-to-date version of the document
    - All submissions must be text; images will be ignored

## Structure of the `qna.yaml` file

[Explore the file structure.](file_structure.md)

For the upstream taxonomy specifically, reference the structure provided in the [contribution details guide](../upstream/knowledge_contribution_details.md#the-qnayaml-file) to understand the required keys and values.

## The knowledge documents repository

Currently, all knowledge documents need to be stored in a git repository. You can use a local git repository, initialized from a local directory, if you so choose.