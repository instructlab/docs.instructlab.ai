---
title: Skills Contribution Details
description: Details on contributions of skills for 🐶 InstructLab's taxonomy
logo: images/ilab_dog.png
---

# Skills contribution details

!!! info
    The following information is if you are comfortable contributing using GitHub, a version control system primarily used for code. If you are **not** comfortable with this platform, you can use the InstructLab UI to submit knowledge. To learn more, [head to the UI overview page](../../user-interface/ui_overview.md).

Skills require a much smaller volume of content than knowledge contributions. An entire skill contribution to the taxonomy tree can be just a few lines of YAML in the `qna.yaml` file ("qna" is short for "questions and answers") and an `attribution.txt` file for citing sources.

Your skills contribution pull requests include:

- A `qna.yaml` that contains a set of key/value entries
- An `attribution.txt` that includes the sources for the information used in the `qna.yaml`. Even if you are authoring the skill with no additional sources, you must have this file for legal purposes.

!!! tip
    The skill taxonomy structure is used in several ways:

    1. To select the right subset of the taxonomy to use for data generation.
    2. To determine the interpretability by human contributors and maintainers.
    3. As part of the prompt to the LLM used to generate synthetic samples.


!!! important
    There is a limit to how much content can exist in the question/answer pairs for the model to process. Due to this, only add a maximum of around 2300 words to your question and answer seed example pairs in the `qna.yaml` file.

Compositional skills can either be grounded (includes a context) or ungrounded (does not include a context).  Grounded or ungrounded is declared in the taxonomy tree, for example: `linguistics/writing/poetry/haiku/` (ungrounded) or `grounded/linguistics/grammar` (grounded). The `qna.yaml` is in the final node.

### The structure of the `qna.yaml` file

Taxonomy skill files must be a valid [YAML](https://yaml.org/) file named `qna.yaml`. Each `qna.yaml` file contains a set of key/value entries with the following keys:

Field | Required? | Content
--|--|--
`version` | yes | The value must be the number 3.
`task_description` | yes | A description of the skill.
`created_by` | yes | The GitHub username of the contributor.
`seed_examples` | yes | A collection of key/value entries. New submissions should have at least five entries, although older files may have fewer.<br/><br/>Note collections are nested lists, like sub-entries in a bulleted list.
`context` | only for grounded skills | Part of the `seed_examples` collection.<br/><br/>Grounded skills require the user to provide context containing information that the model is expected to take into account during processing. This is different from knowledge, where the model is expected to gain facts and background knowledge from the tuning process.<br/><br/>**Note:** The context key should not be used for ungrounded skills.
 `question` | yes | Part of the `seed_examples` collection.<br/><br/>A question for the model.
`answer` | yes | Part of the `seed_examples` collection.<br/><br/>The desired response from the model.

Other keys at any level are currently ignored.

!!! important
    Each `qna.yaml` file requires a minimum of five question and answer pairs.

### Submissions

To make the `qna.yaml` files easier and faster for humans to read, it is recommended to specify `version` first, followed by `task_description`, then `created_by`, and finally `seed_examples`. In `seed_examples`, it is recommended to specify `context` first (if applicable), followed by `question` and `answer`.

*Example `qna.yaml`*

```yaml
version: 2
task_description: <string>
created_by: <string>
seed_examples:
  - question: <string>
    answer: |
      <multi-line string>
  - context: |
      <multi-line string>
    question: <string>
    answer: |
      <multi-line string>
  ...
```

Then, you create an `attribution.txt` file that includes the sources of your information, if any. These sources can also be self-authored sources for skills.

*Fields in `attribution.txt`*

```text
[Link to source]
[Link to work]
[License of the work]
[Creator name]
```

*Example of a self-authored source `attribution.txt`*

```text
Title of work: Customizing an order for tea
Link to work: -
License of the work: CC BY-SA-4.0
Creator names: Jean-Luc Picard
```

You may copy this example and replace the title of the work (your skill) and the creator name to submit a skill. The license is [Creative Commons Attribution-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-sa/4.0/), which is shortened to `CC BY-SA-4.0`.

For more information on what to include in your `attribution.txt` file, see [For your attribution.txt file](https://github.com/instructlab/taxonomy/blob/main/CONTRIBUTING.md#for-your-attributiontxt-file) in CONTRIBUTING.md.

### Writing YAML

If you have not written YAML before, YAML is a text file where indentation matters.

!!! tip

    - Spaces and indentation matter in YAML. Use two spaces to indent.
        - Don't use tabs!
    - Do not have trailing spaces at the end of a line.
    - Each example in `seed_examples` begins with a dash (`-`). Place this dash in front of the first field (`question` or `context`). The remaining keys in the example should not have this dash.
    - Some special characters such as a double quotation mark (`"`) and an apostrophe or single quotation mark (`'`) need to be escaped with backslash. This is why some of the lines for keys in the example YAML start the value with the pipe character (`|`) followed a new line and then an indented multi-line string. This character disables all of the special characters in the value for the key.<br/><br/>You might also want to use the pipe character (`|`) for multi-line strings.
    - Consider quoting all values with double quotation marks (`"`) to avoid surprising YAML parser behavior (e.g., Yes answer can be interpreted by the parser as a boolean of `True` value, unless "Yes" is quoted.)
    - See [yaml-multiline.info](https://yaml-multiline.info/) for more info.

We recommend you **lint**, or verify, your YAML using a tool. One linter option is [yamllint.com](https://yamllint.com). You can copy/paste your YAML into the box and select **Go** to have it analyze your YAML and make recommendations. Online tools like [prettified](https://onlineyamltools.com/prettify-yaml) and [yaml-validator](https://jsonformatter.org/yaml-validator) can automatically reformat your YAML to adhere to our `yamllint` PR checks, such as breaking lines longer than 120 characters.

### Examples

#### Ungrounded compositional skill: YAML example

```yaml
version: 2
task_description: 'Teach the model how to rhyme.'
created_by: juliadenham
seed_examples:
  - question: What are 5 words that rhyme with horn?
    answer: warn, torn, born, thorn, and corn.
  - question: What are 5 words that rhyme with cat?
    answer: bat, gnat, rat, vat, and mat.
  - question: What are 5 words that rhyme with poor?
    answer: door, shore, core, bore, and tore.
  - question: What are 5 words that rhyme with bank?
    answer: tank, rank, prank, sank, and drank.
  - question: What are 5 words that rhyme with bake?
    answer: wake, lake, steak, make, and quake.
```

Here is the location of this YAML in the taxonomy tree. Note that the YAML file itself, plus any added directories that contain the file, is the entirety of the skill in terms of a taxonomy contribution:

#### Ungrounded compositional skill: Directory tree example

```ascii
[...]

└── writing
    └── poetry
    |   └── haiku <=== here it is :)
    |   |   └── qna.yaml
    |   |       attribution.txt
        [...]
    └── prose
    |   └── debate
    |   |   └── qna.yaml
    |   |       attribution.txt
    [...]

[...]
```

#### Grounded compositional skill: YAML example

Remember that [grounded compositional skills](index.md#grounded-compositional-skills) require additional context and include a `context` field.

This example snippet assumes the GitHub username `mairin` and shows some of the question/answer pairs present in the actual file:

```yaml
version: 2
task_description: |
    This skill provides the ability to read a markdown-formatted table.
created_by: mairin # Use your GitHub username; only one creator supported
seed_examples:
  - context: |
      | **Breed**      | **Size**     | **Barking** | **Energy** |
      |----------------|--------------|-------------|------------|
      | Afghan Hound   | 25-27 in     | 3/5         | 4/5        |
      | Labrador       | 22.5-24.5 in | 3/5         | 5/5        |
      | Cocker Spaniel | 14.5-15.5 in | 3/5         | 4/5        |
      | Poodle (Toy)   | <= 10 in     | 4/5         | 4/5        |
    question: |
      Which breed has the most energy?
    answer: |
      The breed with the most energy is the Labrador.
  - context: |
      | **Name** | **Date** | **Color** | **Letter** | **Number** |
      |----------|----------|-----------|------------|------------|
      | George   | Mar 5    | Green     | A          | 1          |
      | Gráinne  | Dec 31   | Red       | B          | 2          |
      | Abigail  | Jan 17   | Yellow    | C          | 3          |
      | Bhavna   | Apr 29   | Purple    | D          | 4          |
      | Rémy     | Sep 9    | Blue      | E          | 5          |
    question: |
      What is Gráinne's letter and what is her color?
    answer: |
      Gráinne's letter is B and her color is red.
  - context: |
      | Banana | Apple      | Blueberry | Strawberry |
      |--------|------------|-----------|------------|
      | Yellow | Red, Green | Blue      | Red        |
      | Large  | Medium     | Small     | Small      |
      | Peel   | Peel       | No peel   | No peel    |
    question: |
      Which fruit is blue, small, and has no peel?
    answer: |
      The blueberry is blue, small, and has no peel.
```

#### Grounded compositional skill: Directory tree example

```ascii
[...]

grounded
└── technology
    └── machine_learning
        └── natural_language_processing
    |   |     └── information_extraction
    |            └── inference
    |   |            └── qualitative
    |   |               ├── sentiment
    |   |               |     └── qna.yaml
    |   |               |         attribution.txt
    │                   ├── quantitative
    │   │                   ├── table_analysis <=== here it is :)
    │   |   |               |     └── qna.yaml
    │   │   │               |         attribution.txt

[...]
```

## Accepted skills

!!!warning
    We are not accepting foundational or core skills at this time.

### Creative writing and poetics

Adding new types of documents and writing styles to the LLM are welcome. Consider:

* Song lyrics
* Soliloquies
* Five paragraph essays
* Arguments

### Learning to format information

Skills to better format and reassemble information are helpful.

### Table analysis and processing

Consider:

* Drawing verbal inferences and conclusions about what's in a table
* Sorting
* Selecting
* Joining

### Qualitative inference and chain-of-thought reasoning

Example:

> Mary is taller than John.
> John is taller than Anna.
> Is Anna taller than Mary?

Example:

> An elephant, a mouse and a horse are in a room. How would they be ordered if they were standing in order by size?

Great skills in this category should include the correct line of reasoning in the answer, not just what the answer is.

### Word problems

Is your LLM smarter than a second-grader?

### Trust and safety

Please avoid HAP (hate, abuse and profanity) and PII (personal identifiable information) in your examples.

Anything related to trust and safety will be flagged for higher-level review.

### Searching, extraction, and summarization

Skills to select odd information in a document, draw conclusions, pull out information, draw insights, or generate TODOs from information provided in the "context" field are welcome.

### Complex rulesets and games

!!! note
    This is a good example of the need for a *grounded skill*. Grounded skills require the user to provide context containing information that the model is expected to take into account during processing. This is different from *knowledge*, where the model is expected to gain facts and background knowledge from the tuning process. Context added when tuning a grounded skill would need to be again provided by the end user at inference time. The skill here is better adherence to the rule set.

To add a skill for a structured game or other task with a complex rule set, use a grounded skill. Add the rules to the game as "context" in every example. Add the interpretation as a question.

### Writing Style and Personalities

When adding a skill, expect that you're tuning a fairly general purpose LLM to behave better given particular circumstances.

If you want to add a skill to better adopt a particular personality - say, "a little boy living in the 1800s" - that context needs to be provided in either the "context" or "question" field.

### Instruction-Following Behavior

LLMs could be better at following extra instructions in a prompt about how to do a task, such as: "Keep your response to 200 words." Or: "Only produce 10 items." Skills to improve this behavior will help the model behave with more precision.

## Skills to Avoid

There are several types of skills that we don't expect this procedure to improve. Most skills in these categories will be rejected.

### Math

Trying to make the LLM solve math problems will be rejected.

### Real world knowledge-based skills

Unless it can be framed as a "grounded skill", where the user is expected to provide context, knowledge contributions will be a separate part of the taxonomy. Skills shouldn't expect the model to come up with its own facts, but instead assemble facts provided.

### Red Teaming

Adversarial questions and answers will be rejected at this time.

### Turing-complete style problems

These are an edge case, but things like palindromes and regexes, where getting the right answer with a non-stochastic program would be easy, aren't good targets for the moment.

Open an issue in the taxonomy repository if you have an idea in this space before submitting a PR.

### Small Changes to Original Response

If the original LLM response is pretty close, but it's not responding to your exact expectations, a skill is not the right way to solve that problem.