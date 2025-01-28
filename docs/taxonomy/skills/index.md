---
title: Skills Overview
description: Skills in 🐶 InstructLab's Taxonomy
logo: images/ilab_dog.png
---
## What is a "skill"?

There are various types of skills that you can contribute to the taxonomy.

### Compositional skills

Skills are performative. When you create a skill for the model, you're teaching it how to do something such as "write me a song," "rearrange words in a sentence" or "summarize an email."

There are two types of compositional skills, freeform and grounded.

#### Freeform compositional skills

Freeform compositional skills are performative and do **not** require additional context. An example of a freeform skill is teaching the model words that rhyme. You could provide examples of "words that rhyme with 'tool'". By providing those examples, you're essentially using the latent knowledge of the LLM. In our example, you're enabling the LLM to be able to identify words that rhyme in its latent knowledge.

Freeform skills include things like:

* Speak like Yoda
* Convert to camel case
* Write me a limerick
* Generate StableDiffusion prompts

#### Grounded compositional skills

Grounded skills are performative and **do** require additional context. Examples of a grounded skill would be to read the value of a cell in a table layout or to parse a JSON file. To create a grounded skill to read a Markdown-formatted table layout, the additional context could be an example table layout. This additional context is including in the YAML for the skill and not external to it.

!!! note
    The content of the table layout will not be used in training or aligning the model; only the table layout format itself will be used.

Grounded skills include things like:

* Game creation like Sudoku or tic-tac-toe
* Summarizing or extracting from a piece of text
* Find unresolved items in a meeting transcript

[Example Grounded compositional skill pull request](https://github.com/instructlab/taxonomy/pull/250)

### Core or foundational skills

Core skills are foundational skills like math, reasoning, and coding. In the taxonomy repository, core skills are found in the `foundational_skills` directory.

!!! note
    Unlike **knowledge** and **compositional skills**, core skills are not something you can contribute to the tree. So references to contributing "skills" to the taxonomy from this point forward are to **compositional skills**.