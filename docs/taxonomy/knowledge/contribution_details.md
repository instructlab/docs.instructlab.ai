---
title: Knowledge Contribution Guidelines
description: The overview of 🐶 InstructLab's Knowledge contribution guidelines
logo: images/ilab_dog.png
---

!!! info
    The following information is if you are comfortable contributing using GitHub, a version control system primarily used for code. If you are **not** comfortable with this platform, you can use the InstructLab UI to submit knowledge. To learn more, [head to the UI overview page](../../user-interface/ui_overview.md).

You can create a Git repository to host your knowledge contributions anywhere (GitLab, Gerrit, etc.), but it might be favorable to create one on GitHub. At the current time, we require a GitHub username to contribute, and all work is done in GitHub.

The following instructions show you how to create a knowledge repository in GitHub and contribute to the taxonomy.

## Prerequisites

If you are submitting to the repository directly:
- You have a GitHub account
- You have a forked copy of the [taxonomy](https://github.com/instructlab/taxonomy/tree/main) repository
- You have verified that the model does not already know the knowledge you want to submit

If you are using the [UI](https://ui.instructlab.ai) to submit:
- You have a GitHub account
- You have verified that the model does not already know the knowledge you want to submit

## Preparing your knowledge documents

You need to set up your source documents as Markdown files in a git repository.

!!! warning
    **We are currently only accepting sources from [this list](https://github.com/instructlab/community/blob/main/docs/DataSources.md) at this time due to legal requirements to keep InstructLab open source.** Our taxonomy triage team will reject any contributions that do not match this pattern. Thanks for helping us keep InstructLab 100% open source!

### Creating your own knowledge repository

To create a new GitHub repository, follow the GitHub documentation in [Creating a new repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-new-repository).

The specific steps are listed as follows:

1. In your GitHub profile page, navigate to the repositories tab. You will see a search bar where you can search your repositories or create a new one.
2. This takes you to a page titled “Create a new repository”. Create a custom name for your repository and add a `README.md` file. For example, “knowledge_contributions” could be a good name for your repository.
3. Click “Create” when you are all set.

### Convert your knowledge documentation to Markdown

There are many online tools that can help you convert your documents to Markdown. If you are using a wiki page for your contributions, you can use [pandocs](https://pandoc.org/try/) to convert the documents. For Wikipedia sources on pandoc, use `from: mediawiki` and convert `to: markdown_strict` to access the proper Markdown format.

### Add the Markdown file to your repository

To add a file to your GitHub repository, follow the GitHub documentation in [Adding a file to a repository](https://docs.github.com/en/repositories/working-with-files/managing-files/adding-a-file-to-a-repository).

The specific steps are listed as follows:

1. Navigate to “Add files”. Click “Create new file” if you want to manually add your Markdown content. Click “Upload files” if you have a file locally to add.
2. Add a description and commit your changes.

    Since this is your own repository, you can commit directly to the `main` branch.

3. You can then see your new content in your repository.

!!! important
    Make a note of your commit SHA; you'll need it for your `qna.yaml`.

## Creating your knowledge submission in GitHub

For knowledge submissions, we need a `qna.yaml` file and an `attribution.txt` file.

### The `qna.yaml` file

For the current version of the taxonomy, version 3, here are the available fields:

!!! note
    Tokens in the case of context, questions, and answers can fit to "words," but it's specifically tokens, and not words, that are the limitations.

Key | Type | Required | Constraints | Value | Notes
--|--|--|--|--|--
`version` | Y | integer | - | `3` | The taxonomy schema version used in the `qna.yaml` file. Defined in [instructlab/schema](https://github.com/instructlab/schema)
`created_by` | Y | string | - | Your GitHub username | -
`domain` | Y | string | - | Knowledge sub-category | The knowledge domain which is used in prompts to the teacher model during synthetic data generation. The domain should be brief such as the title to a textbook chapter or section.
`seed_examples` | Y | array | at least 5 sets | null | This is a collection of questions and answers with context from the knowledge document that InstructLab uses to generate data synthetically.
`context` | Y | string | < 500 tokens | A chunk of the document showing off the different **unique** content to help guide the teacher model. If you have only text, that's one thing, but if you have tables or other content, be sure to add that, too. | This should be a copy-paste from the Markdown version of your document
`questions_and_answers` | Y | array | at least 3 pairs per context | null | This is a collection of questions and answers.
`question` | Y | string | > 250 tokens | A question related to the grounded in the relivant context | Questions are things you'd expect someone to ask the model based on the context given. This will be used for synthetic data generation.
`answer` | Y | string | > 250 tokens | An answer for the question, longer then a one word answer. | Answers are what you'd like the model to give as an answer. It will not be an exact answer the model always gives.
`document_outline` | Y | string | - | This provides the context specific for each document chunk, this should be as **specific** as you possibly can get.
`document` | Y | object | - | null | The collection of data for the knowledge document.
`repo` | Y | string | a git URL | The URL (with a `.git` suffix) that identifies your git repo where you've stored your knowledge documents | -
`commit` | Y | string | full commit hash | A SHA1 full commit hash that corresponds to the document in the repo | This hash must be exactly where the system can find the document.
`patterns` | Y | array | `*.md`, `*.pdf` | A list of glob patterns specifying the files in the repo. | Any glob pattern that starts with `*` must be quoted due to YAML rules. Currently, the system accepts `.md` and `.pdf` files.

!!! important
    There must be at least 5 sets of 3 questions and 3 answers with context in every `qna.yaml` file. Also the "context blocks" should be as diverse and unique as possible. The goal is to get as much different
    information in so as the teacher LLM reads through the document it gets "inspired" by the different content.

#### An example file

To build a strong taxonomy,

## Create a pull request in the taxonomy repository

Navigate to your forked taxonomy repository and ensure it is up-to-date.

There are a few ways you can create a pull request:

- For details on the local process, check out [The GitHub Workflow Guide](https://github.com/kubernetes/community/blob/master/contributors/guide/github-workflow.md) in the Kubernetes documentation and the [GitHub flow](https://docs.github.com/en/get-started/using-github/github-flow) in the GitHub documentation.
- For details on contributing using the GitHub webpage UI, see [Contributing using the GH UI](https://github.com/instructlab/taxonomy/docs/contributing_via_GH_UI.md) or [Creating a pull request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request?tool=webui) in the GitHub documentation.

## Verification

Here are a few things to check before seeking reviews for your contribution:

- Your `qna.yaml` follows the proper formatting. See examples in [Knowledge: YAML examples](https://github.com/instructlab/taxonomy/blob/main/README.md#knowledge-yaml-examples)
- Ensure all parameters are set. Especially the `document`, `repo`, `commit` and `pattern` keys; these parameters are specific to knowledge contributions and require more analysis.
- Include an `attribution.txt` file for citing your sources. see [For your attribution.txt file](https://github.com/instructlab/taxonomy/blob/main/CONTRIBUTING.md#for-your-attributiontxt-file) for more information.

## PR Upstream Workflow

The following table outlines the expected timing for the PRs you have submitted. The PRs go through a few steps, and checks, but you should be able to map your `label` to the place that it is in.

| Label | Actor | Action | Duration |
| --- | --- | --- | --- |
| | Contributor | Submit PR | - |
| | Contributor | Fix failed PR checks | - |
| [triage-needed](https://github.com/instructlab/taxonomy/labels/triage-needed) | Triager | Review PR, ask for changes | Days |
| [triage-requested-changes](https://github.com/instructlab/taxonomy/labels/triage-requested-changes) | Contributor | Make requested changes | Days |
| [precheck-generate-ready](https://github.com/instructlab/taxonomy/labels/precheck-generate-ready) | Triager | Run prechecks and generate  | Days |
| [community-build-ready](https://github.com/instructlab/taxonomy/labels/community-build-ready) | Backend | Model gets retrained | Weeks |
| | Triager | Check the numbers and PR merged or closed | - |
