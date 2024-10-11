---
title: InstructLab UI Overview
description: The overview of 🐶 InstructLab UI.
logo: images/ilab_dog.png
---

The InstructLab User Interface (UI) is an additional component in the InstructLab project to make Knowledge/Skills 
contributions more accessible to the general user. Instead of having to edit a `qna.yaml` file,
users can fill out the contribution forms on the web. The user can also view their all of their contributions in a
centralised list. You can also chat with the models directly on the playground.

There are 2 ways to access the UI:

1. Visit the website at [ui.instructlab.ai](https://ui.instructlab.ai/).

2. Install and run the UI locally.


!!! note
    To log into the UI and submit Knowledge and Skills contributions, you must be a member of the [instructlab-public](https://github.com/instructlab-public) github repository.

    If you aren't a member of the repository, but still wish to experiment with the UI, we recommend you to download it locally.

!!! note
    To become a member of the [instructlab-public](https://github.com/instructlab-public) github repository, join our slack channel and ask! For more information please visit the [slack guide](/community/InstructLab_SLACK_GUIDE/).


## Prerequisites 

Before you can run the User Interface locally, you first must: 

* Have a [github](https://github.com/) account

* Have InstructLab installed 

* Have Node.js installed

!!! warning
    This guide was written with `Node.js v20.17.0`. If you are using an older version of Node.js, please be aware that the application
    may not work as intended. 

## Installation Guide

1) Download the InstructLab UI by running the following command in your desired directory:

`git clone https://github.com/instructlab/ui`

You can also download by visting the [InstructLab UI github page](https://github.com/instructlab/ui) and clicking the code, and then the download button.

2) Set up the .env file. Go into the UI folder by running

`cd ui`

Inside the UI folder, create a new file called `.env` and paste the following content inside:

```bash
IL_UI_ADMIN_USERNAME=admin
IL_UI_ADMIN_PASSWORD=password
IL_UI_DEPLOYMENT=dev

OAUTH_GITHUB_ID=<OAUTH_APP_ID>
OAUTH_GITHUB_SECRET=<OAUTH_APP_SECRET>

NEXTAUTH_SECRET=your_super_secret_random_string
NEXTAUTH_URL=http://localhost:3000

IL_GRANITE_API=<GRANITE_HOST>
IL_GRANITE_MODEL_NAME=<GRANITE_MODEL_NAME>
IL_MERLINITE_API=<MERLINITE_HOST>
IL_MERLINITE_MODEL_NAME=<MERLINITE_MODEL_NAME>

GITHUB_TOKEN=<TOKEN FOR OAUTH INSTRUCTLAB MEMBER LOOKUP>
TAXONOMY_DOCUMENTS_REPO=github.com/instructlab-public/taxonomy-knowledge-docs
NEXT_PUBLIC_AUTHENTICATION_ORG=<AUTHENTICATION_ORG>
NEXT_PUBLIC_TAXONOMY_REPO_OWNER=<GITHUB_ACCOUNT>
NEXT_PUBLIC_TAXONOMY_REPO=<REPO_NAME>
```

As of now, we are only concerned with `IL_UI_ADMIN_USERNAME`, `IL_UI_ADMIN_PASSWORD` and `IL_UI_DEPLOYMENT`. But throughout this UI guide we will be visiting the .env frequently. 

__Save and close the .env file.__

3) Running Node commands to install and run.

Back inside the UI folder, run this command to install needed files for the UI to run:

`npm install`

!!! note
    Depending on your internet speed and connectivity, this process may take a few minutes.

When the install is finished, start the UI by running:

`make start-dev-local` 

The UI should now be up and running, you can visit it by entering `localhost:3000` in your browser, where it should bring you to the login screen.

![UI Login Screen](../images/user-interface/ui_login_screen.png)

4) Logging in 

For now, we will log in by entering `admin` and `password` in the username and password fields respectively. You can change the username and password by editing the `IL_UI_ADMIN_USERNAME` and `IL_UI_ADMIN_PASSWORD` values in the .env file.

We are not able to log in with github right now since we haven't set up the github token in the .env file. When logged in, you may see a popup saying that the UI is fetching your submissions, exit out of this notification. If you wish to set up the OAuth, visit the [.env and OAuth config page](/user-interface/env_oauth_config/).

[Next Steps](/user-interface/playground_chat/){: .md-button .md-button--primary }
