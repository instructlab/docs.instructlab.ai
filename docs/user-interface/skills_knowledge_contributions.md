---
title: InstructLab UI Skills & Knowledge contributions
description: Steps to contribute to the community model via UI.
logo: images/ilab_dog.png
---

The UI Simplifies the process for Skills & Knowledge contributions by:

* Minimising risk of human error when writing YAML by using the web form. 

* Directly submit a github pull request with a press of a button.

When the form is filled out, you also are given the option to download the YAML and attribution files to your local machine, and to view the form in its original YAML structure before submission.

You can view all your submissions on the dashboard page.

!!! warning
    Even when running the UI locally, you must be logged in via github to successfully submit your Knowledge and Skills contributions. You can still fill out the form, and download the YAML and attribution files.

For tips on writing Skills & Knowledge contributions, please visit the documentation under the [Taxonomy](/taxonomy/) heading.

## Skill Contributions

### Author Information

Enter your github email address, and your full name, which will be tied to your contribution.

### Skill Information

Give a brief description on what skill you would like to teach.

### Taxonomy Directory Path

Specify where in the taxonomy repository directory structure this skill would belong in. As the taxonomy fills in with more skills, it will become more complex, make sure to give a concise location to keep the taxonomy organised. 

### Seed Examples

For a skill contribution, the seed example only requires a question and answer, but depending on what skill you wish to add, adding context for a skill may be necessary, For tips on writing Skills contributions, please visit the documentation under the [Skills Guide](/taxonomy/skills/skills_guide) heading.

### Attribution

Linking the source you used for information. Wikipedia articles change overtime, make sure to add the oid from the wikipedia article, which you can find by clicking on `View history`, and select the relevant version.

## Knowledge Contributions

### Author Information

Enter your github email address, and your full name, which will be tied to your contribution.

### Knowledge Information

Give a brief description of what knowledge you are submitting, where you received the information from, and then a detailed outline of the document, mentioning the topics and headings in your topic.

### Taxonomy Directory Path

specify where in the taxonomy repo directory structure this knowledge would belong in. As the taxonomy fills with more knowledge contributions, it will become more complex, make sure to give a concise location to keep the taxonomy organised.

### Seed Examples

For a Knowledge contribution, A user must provide context, which would usually be a snippet or a heading extrated from the main document. The user must then write at least 3 questions based on the context given, and answer said questions. For tips on writing Knowledge contributions, please visit the documentation under the [Knowledge Guide](/taxonomy/knowledge/guide) heading.

### Document Information

You must prepare a markdown file version of the document you wish to use for the knowledge submission. By dragging and dropping the markdown file into the box, and clicking the submit files button, a forked version of the taxonomy repository will be automatically created on your github profile. 

![UI Knowledge Document Information](../images/user-interface/ui_knowledge_document_info.png)

![Forked Repository Showcase](../images//user-interface/ui_knowledge_repo_created.png)

If you've already uploaded the markdown file to your github, you can switch to manually adding the document, and entering the `commit sha`.

![UI Knowledge Document Manual Information](../images/user-interface/ui_knowledge_document_manual_info.png)


### Attribution Information

Linking the source you used for information. Wikipedia articles change overtime, make sure to add the oid from the wikipedia article, which you can find by clicking on `View history`, and select the relevant version.

## Show dashboard

Once you have submitted a Skills or Knowledge Contribution, you can view it on your dashboard, and edit the submission via the UI if needed.

![UI Dashboard With Contribution](../images/user-interface/ui_dashboard_with_submission.png)

[Next Steps](/user-interface/env_oauth_config/){: .md-button .md-button--primary }
