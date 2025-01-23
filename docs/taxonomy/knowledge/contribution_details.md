---
title: Knowledge Contribution Guidelines
description: The overview of 🐶 InstructLab's Knowledge contribution guidelines
logo: images/ilab_dog.png
---

You can create a Git repository to host your knowledge contributions anywhere (GitLab, Gerrit, etc.) but it might be favorable to create one on GitHub. The following instructions show you how to create a knowledge repository in GitHub and contribute to the taxonomy.

## Prerequisites

- You have a GitHub account
- You have a forked copy of the [taxonomy](https://github.com/instructlab/taxonomy/tree/main) repository
- You have verified that the model does not already know the knowledge you want to submit

## Creating your own knowledge repository

To create a new GitHub repository, follow the GitHub documentation in [Creating a new repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-new-repository).

The specific steps are listed as follows:

1. In your GitHub profile page, navigate to the repositories tab. You will see a search bar where you can search your repositories or create a new one.
2. This takes you to a page titled “Create a new repository”. Create a custom name for your repository and add a `README.md` file. For example, “knowlege_contributions” could be a good name for your repository.
3. Click “Create” when you are all set.

## Convert your knowledge documentation to markdown

There are many online tools that can help you convert your documents to markdown. If you are using a wiki page for your contributions, you can use [pandocs](https://pandoc.org/try/) to convert the documents. For wikipedia sources on pandoc, use `from: mediawiki` and convert `to: markdown_strict` to access the proper markdown format.

## Add the markdown file to your repository

To add a file to your GitHub repository, follow the GitHub documentation in [Adding a file to a repository](https://docs.github.com/en/repositories/working-with-files/managing-files/adding-a-file-to-a-repository).

The specific steps are listed as follows:

1. Navigate to “Add files”. Click “Create new file” if you want to manually add your markdown content. Click “Upload files” if you have a file locally to add.
2. Add a description and commit your changes.

    Since this is your own repository, you can commit directly to the `main` branch.

3. You can then see your new content in your repository.

!!! important
    Make a note of your commit SHA; you'll need it for your `qna.yaml`.

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

The following table outlines the expected timing for the PRs you have submitted. The PRs go through a few steps, and checks, but you should be able to map your `label` to
the place that it is in.

| Label | Actor | Action | Duration |
| --- | --- | --- | --- |
| | Contributor | Submit PR | - |
| | Contributor | Fix failed PR checks | - |
| [triage-needed](https://github.com/instructlab/taxonomy/labels/triage-needed) | Triager | Review PR, ask for changes | Days |
| [triage-requested-changes](https://github.com/instructlab/taxonomy/labels/triage-requested-changes) | Contributor | Make requested changes | Days |
| [precheck-generate-ready](https://github.com/instructlab/taxonomy/labels/precheck-generate-ready) | Triager | Run prechecks and generate  | Days |
| [community-build-ready](https://github.com/instructlab/taxonomy/labels/community-build-ready) | Backend | Model gets retrained | Weeks |
| | Triager | Check the numbers and PR merged or closed | - |
