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
- An `attribution.txt` file that includes the sources for the information used in the `qna.yaml`. Note that this file is not required if you are not submitting to the upstream taxonomy repository.

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

### Structure of the `qna.yaml` file

In general, here are the fields in the YAML file:

Key | Type | Required | Constraints | Value | Notes
--|--|--|--|--|--
`version` | integer | Y | - | `3` | The taxonomy schema version used in the `qna.yaml` file. Defined in [instructlab/schema](https://github.com/instructlab/schema)
`created_by` | string | Y | - | Your GitHub username | -
`domain` | string | Y | - | Knowledge sub-category | The knowledge domain which is used in prompts to the teacher model during synthetic data generation. The domain should be brief such as the title to a textbook chapter or section.
`seed_examples` | Y | array | at least 5 sets | null | This is a collection of questions and answers with context from the knowledge document that InstructLab uses to generate data synthetically.
`context` | string | Y | < 500 words | A chunk of information from the original knowledge document | This should be a copy-paste from the Markdown version of your document
`questions_and_answers` | Y | array | at least 3 pairs per context | null | This is a collection of questions and answers.
`question` | Y | string | > 250 words | A question related to the context | Questions are things you'd expect someone to ask the model based on the context given. This will be used for synthetic data generation.
`answer` | Y | string | > 250 words | An answer for the question | Answers are what you'd like the model to give as an answer. It will not be an exact answer the model always gives.
`document_outline` | Y | string | - | A brief summary of the document | -
`document` | Y | object | - | null | The collection of data for the knowledge document.
`repo` | Y | string | a git URL | The URL (with a `.git` suffix) that identifies your git repo where you've stored your knowledge documents | -
`commit` | Y | string | full commit hash | A SHA1 full commit hash that corresponds to the document in the repo | This hash must be exactly where the system can find the document.
`patterns` | Y | array | `*.md`, `*.pdf` | A list of glob patterns specifying the files in the repo. | Any glob pattern that starts with `*` must be quoted due to YAML rules. Currently, the system accepts `.md` and `.pdf` files.

For the upstream taxonomy specifically, reference the structure provided in the [contribution details guide](../upstream/knowledge_contribution_details.md#the-qnayaml-file) to understand the required keys and values.

#### Version

```yaml hl_lines="1" title="qna.yaml" linenums="1"
    version: 3
    domain: astronomy
    created_by: juliadenham
    seed_examples:
      # ... 
```

#### Domain

```yaml hl_lines="2" title="qna.yaml" linenums="1"
    version: 3
    domain: astronomy
    created_by: juliadenham
    seed_examples:
      # ... 
```

#### Created By

```yaml hl_lines="3" title="qna.yaml" linenums="1"
    version: 3
    domain: astronomy
    created_by: juliadenham
    seed_examples:
      # ... 
```

### Example of a knowledge submission



### Example of a Markdown file

The previous knowledge example references one markdown file: `phoenix_constellation.md`. You can also add multiple markdown files for knowledge contributions.

!!! note
    Due to the higher volume, **it will naturally take longer to receive acceptance for
    a knowledge contribution pull request than for a skill pull request**. Smaller
    pull requests are simpler and require less time and effort to review.

What might these markdown files look like? They can be freeform. Here's what a
snippet of `phoenix_constellation.md` might look like in your Git repository.

*Example of a `.md` file*

```markdown
# Phoenix (constellation)

**Phoenix** is a minor constellation in the southern sky. Named after the mythical
phoenix, it was first depicted on a celestial atlas by Johann Bayer in his 1603
*Uranometria*. The French explorer and astronomer Nicolas Louis de
Lacaille charted the brighter stars and gave their Bayer designations
in 1756. The constellation stretches from roughly −39 degrees to −57 degrees
declination, and from 23.5h to 2.5h of right ascension. The constellations Phoenix,
Grus, Pavo, are known as the Southern Birds.

The brightest star, Alpha Phoenicis, is named Ankaa, an Arabic word meaning 'the Phoenix'.
It is an orange giant of apparent magnitude 2.4. Next is Beta Phoenicis, actually a
binary system composed of two yellow giants with a combined apparent magnitude of 3.3. Nu
Phoenicis has a dust disk, while the constellation has ten star systems with known planets and the recently
discovered galaxy clusters El Gordo and the Phoenix
Cluster—located 7.2 and 5.7 billion light years away respectively, two of the largest objects in the visible
universe. Phoenix is the radiant of two annual meteor showers: the Phoenicids in December, and the July
Phoenicids.
```

You can organize the knowledge markdown files in your repository however you want. You just need to ensure the YAML is pointing to the correct file.

### Example of a directory tree

In the taxonomy repository, here's what the previously referenced knowledge might look like in the tree:

```ascii
[...]

└── knowledge
    └── science
        ├── astronomy
        │ └── constellations
        │     └── Phoenix <=== here it is :)
        │     |    └── qna.yaml
        |     |        attribution.txt
        │     └── Orion
        │          └── qna.yaml
        |              attribution.txt
[...]
```
