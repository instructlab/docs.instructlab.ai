---
title: Skills File Structure
description: The file structure for the Skills files
logo: images/ilab_dog.png
---

# The skills files

Taxonomy trees in InstructLab have leaf-node directories. These leaf nodes contain at least one file, and usually two:

- A `qna.yaml` file that asks and answers questions about the information in the git repository where you have stored a knowledge document.
- An `attribution.txt` file that includes the sources for the information used in the `qna.yaml`. This file is only required when submitting knowledge [to the InstructLab taxonomy repository](https://github.com/instructlab/taxonomy). Learn more about this file in [the upstream skill contribution guidelines](../upstream/skills_contribution_details.md).

- Skills require a much smaller volume of content than knowledge contributions. An entire skill contribution can be just a few lines of YAML in the `qna.yaml` file.

Compositional skills can either be grounded (includes a context) or ungrounded (does not include a context).  Grounded or ungrounded is declared by placement in a taxonomy tree, such as `linguistics/writing/poetry/haiku/` for an ungrounded skill or `grounded/linguistics/grammar` for a grounded skill. The `qna.yaml` is in the final node.

## The structure of the `qna.yaml` file

Taxonomy skill files must be a valid [YAML](https://yaml.org/) file named `qna.yaml`. Each `qna.yaml` file contains a set of key/value entries with the following keys:

Field | Type | Required? | Constraints | Content
--|--|--|--|--
`version` | integer | yes | -- | The taxonomy schema version used in the `qna.yaml` file. Defined in [instructlab/schema](https://github.com/instructlab/schema)
`task_description` | string | yes | | A description of the task which is used in prompts to the teacher model during synthetic data generation. The description should be detailed and prescriptive to improve the teacher model's responses.
`created_by` | string | yes | | The GitHub username of the contributor.
`seed_examples` | array | yes | at least 5 sets | A collection of key/value entries. New submissions should have at least five entries, although older files may have fewer.<br/><br/>Note collections are nested lists, like sub-entries in a bulleted list.
`context` | string | only for grounded skills | < 500 tokens | Part of the `seed_examples` collection.<br/><br/>Grounded skills require the user to provide context containing information that the model is expected to take into account during processing. This is different from knowledge, where the model is expected to gain facts and background knowledge from the tuning process.<br/><br/>A chunk of the knowledge document showing off the different **unique** content to help guide the teacher model. It should be related to the skill. This should be a copy-paste from the Markdown version of your document. <br/><br/>**Note:** The context key should not be used for ungrounded skills.
`question` | string | yes | \> 250 tokens | Part of the `seed_examples` collection.<br/><br/>A question for the model. Questions are things you'd expect someone to ask the model based on the context given. This will be used for synthetic data generation. Note that if this is a grounded skill, questions should be grounded in the context provided.
`answer` | string | yes | \> 250 tokens | Part of the `seed_examples` collection.<br/><br/>The desired response from the model. Longer than a one-word or one-number answer.

Other keys at any level are currently ignored.

!!! important
    Each `qna.yaml` file requires a minimum of five question and answer pairs.

### `version`

The `version` field is the version of the [schema](https://github.com/instructlab/schema) that is in use. Currently, the value here should be `3`.

=== "Ungrounded"

    ```yaml hl_lines="1" title="qna.yaml" linenums="1"
    version: 3
    task_description: # ...
    created_by: # ...
    seed_examples:
      # ...
    ```

=== "Grounded"

    ```yaml hl_lines="1" title="qna.yaml" linenums="1"
    version: 3
    task_description: # ...
    created_by: # ...
    seed_examples:
      # ...
    ```

### `task_description`

The `task_description` field is

=== "Ungrounded"

    ```yaml hl_lines="2" title="qna.yaml" linenums="1"
    version: # ...
    task_description: 'Teach the model how to rhyme.'
    created_by: # ...
    seed_examples:
      # ...
    ```

=== "Grounded"

    ```yaml hl_lines="2-3" title="qna.yaml" linenums="1"
    version: # ...
    task_description: |
        This skill provides the ability to read a markdown-formatted table.
    created_by: # ...
    seed_examples:
      # ...
    ```

### `created_by`

The `created_by` field defines the user who submitted the skill. If you're working upstream, it would be your GitHub username. If you're working on your own taxonomy, it would be some kind of identifier with no spaces.

=== "Ungrounded"

    ```yaml hl_lines="3" title="qna.yaml" linenums="1"
    version: # ...
    task_description: # ...
    created_by: juliadenham
    seed_examples:
      # ...
    ```

=== "Grounded"

    ```yaml hl_lines="3" title="qna.yaml" linenums="1"
    version: # ...
    task_description: # ...
    created_by: mairin
    seed_examples:
      # ...
    ```

### `seed_examples`

The `seed_examples` field does not have anything next to it because it is an array. An array in YAML is a collection of other values, and those values are indicated through indentation on subsequent lines.

=== "Ungrounded"

    ```yaml hl_lines="4" title="qna.yaml" linenums="1"
    version: # ...
    task_description: # ...
    created_by: # ...
    seed_examples:
      - question: # ...
        answer: # ...
      - question: # ...
        answer: # ...
      - question: # ...
        answer: # ...
      - question: # ...
        answer: # ...
      - question: # ...
        answer: # ...
    ```

=== "Grounded"

    ```yaml hl_lines="4" title="qna.yaml" linenums="1"
    version: # ...
    task_description: # ...
    created_by: # ...
    seed_examples:
      - context: # ...
        question: # ...
        answer: # ...
      - context: # ...
        question: # ...
        answer: # ...
      - context: # ...
        question: # ...
        answer: # ...
      - context: # ...
        question: # ...
        answer: # ...
      - context: # ...
        question: # ...
        answer: # ...
    ```

### `context` (grounded skills only)

The `seed_examples` field does not have anything next to it because it is an array. An array in YAML is a collection of other values, and those values are indicated through indentation on subsequent lines.

=== "Ungrounded"
    
    N/A

=== "Grounded"

    ```yaml hl_lines="5-11 14-21 24-29" title="qna.yaml" linenums="1"
    version: # ...
    task_description: # ...
    created_by: # ...
    seed_examples:
      - context: |
          | **Breed**      | **Size**     | **Barking** | **Energy** |
          |----------------|--------------|-------------|------------|
          | Afghan Hound   | 25-27 in     | 3/5         | 4/5        |
          | Labrador       | 22.5-24.5 in | 3/5         | 5/5        |
          | Cocker Spaniel | 14.5-15.5 in | 3/5         | 4/5        |
          | Poodle (Toy)   | <= 10 in     | 4/5         | 4/5        |
        question: # ...
        answer: # ...
      - context: |
          | **Name** | **Date** | **Color** | **Letter** | **Number** |
          |----------|----------|-----------|------------|------------|
          | George   | Mar 5    | Green     | A          | 1          |
          | Gráinne  | Dec 31   | Red       | B          | 2          |
          | Abigail  | Jan 17   | Yellow    | C          | 3          |
          | Bhavna   | Apr 29   | Purple    | D          | 4          |
          | Rémy     | Sep 9    | Blue      | E          | 5          |
        question: # ...
        answer: # ...
      - context: |
          | Banana | Apple      | Blueberry | Strawberry |
          |--------|------------|-----------|------------|
          | Yellow | Red, Green | Blue      | Red        |
          | Large  | Medium     | Small     | Small      |
          | Peel   | Peel       | No peel   | No peel    |
        question: # ...
        answer: # ...
    ```

### `question`

The `question` field is a sample question that a teacher model would use to train a student model on the skill.

=== "Ungrounded"

    ```yaml hl_lines="5 7 9 11 13" title="qna.yaml" linenums="1"
    version: # ...
    task_description: # ...
    created_by: # ...
    seed_examples:
      - question: What are 5 words that rhyme with horn?
        answer: # ...
      - question: What are 5 words that rhyme with cat?
        answer: # ...
      - question: What are 5 words that rhyme with poor?
        answer: # ...
      - question: What are 5 words that rhyme with bank?
        answer: # ...
      - question: What are 5 words that rhyme with bake?
        answer: # ...
    ```

=== "Grounded"

    ```yaml hl_lines="6-7 10-11 14-15" title="qna.yaml" linenums="1"
    version: # ...
    task_description: # ...
    created_by: # ...
    seed_examples:
      - context: # ...
        question: |
          Which breed has the most energy?
        answer: # ...
      - context: # ...
        question: |
          What is Gráinne's letter and what is her color?
        answer: # ...
      - context: # ...
        question: |
          Which fruit is blue, small, and has no peel?
        answer: # ...
    ```

### `answer`

The `answer` field is an example answer that the teacher model uses to check the answer from a student model and train it to answer more accurately. Note that this would not be an exact answer the final student model would eventually give every time as the goal of fine-tuning with InstructLab is that it will give similar answers.

=== "Ungrounded"

    ```yaml hl_lines="6 8 10 12 14" title="qna.yaml" linenums="1"
    version: # ...
    task_description: # ...
    created_by: # ...
    seed_examples:
      - question: # ...
        answer: warn, torn, born, thorn, and corn.
      - question: # ...
        answer: bat, gnat, rat, vat, and mat.
      - question: # ...
        answer: door, shore, core, bore, and tore.
      - question: # ...
        answer: tank, rank, prank, sank, and drank.
      - question: # ...
        answer: wake, lake, steak, make, and quake.
    ```

=== "Grounded"

    ```yaml hl_lines="7-8 11-12 15-16" title="qna.yaml" linenums="1"
    version: # ...
    task_description: # ...
    created_by: # ...
    seed_examples:
      - context: # ...
        question: # ...
        answer: |
          The breed with the most energy is the Labrador.
      - context: # ...
        question: # ...
        answer: |
          Gráinne's letter is B and her color is red.
      - context: # ...
        question: # ...
        answer: |
          The blueberry is blue, small, and has no peel.
    ```

## Writing YAML

If you have not written YAML before, YAML is a text file where indentation matters.

!!! tip

    - Spaces and indentation matter in YAML. Use two spaces to indent.
        - Don't use tabs!
    - Do not have trailing spaces at the end of a line.
    - Each example in `seed_examples` begins with a dash (`-`). Place this dash in front of the first field (`question` or `context`). The remaining keys in the example should not have this dash.
    - Some special characters such as a double quotation mark (`"`) and an apostrophe or single quotation mark (`'`) need to be escaped with backslash. This is why some of the lines for keys in the example YAML start the value with the pipe character (`|`) followed a new line and then an indented multi-line string. This character disables all of the special characters in the value for the key.<br/><br/>You might also want to use the pipe character (`|`) for multi-line strings.
    - Consider quoting all values with double quotation marks (`"`) to avoid surprising YAML parser behavior (e.g., Yes answer can be interpreted by the parser as a boolean of `True` value, unless "Yes" is quoted.)
    - See [yaml-multiline.info](https://yaml-multiline.info/) for more info.

We recommend you **lint**, or verify, your YAML using a tool. One linter option is [yamllint.com](https://yamllint.com). You can copy/paste your YAML into the box and select **Go** to have it analyze your YAML and make recommendations. Online tools like [prettified](https://onlineyamltools.com/prettify-yaml) and [yaml-validator](https://jsonformatter.org/yaml-validator) can automatically reformat your YAML to adhere to default `yamllint` parameters, such as breaking lines longer than 80 characters.

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

Here is the location of this YAML in a sample taxonomy tree. Note that the YAML file itself, plus any added directories that contain the file, is the entirety of the skill in terms of a taxonomy contribution:

#### Ungrounded compositional skill: Directory tree example

```ascii
[...]
compositional_skills
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
compositional_skills
└── grounded
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