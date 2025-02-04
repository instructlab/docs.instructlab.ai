---
title: Taxonomy Contribution Guidelines
description: The overview of 🐶 InstructLab's contribution guidelines for taxonomy
logo: images/ilab_dog.png
---

# Taxonomy Contribution Guidelines

We welcome contributions to [the upstream InstructLab taxonomy.](https://github.com/instructlab/taxonomy)(1)
{ .annotate }

1. `upstream` here refers to the idea in open source of an "upstream" project that is before your product in a workstream.

A contribution to the upstream taxonomy involves

- identifying whether your submission is [a knowledge submission](../knowledge/index.md) or [a skills submission](../skills/index.md),
- defining the domain for the submission, or the branches and leaf node that will contain your knowledge,
- converting any source data to Markdown or PDF and storing them in a git-based repository (required for knowledge submissions),
- writing a YAML file called `qna.yaml` that contains the seed content that will inform synthetic data generation and the repo URL where your converted source data is stored,
- creating an attribution file called `attribution.txt` that provides licensing information for source data, and
- submitting those two files in the proper spot in the taxonomy tree to the InstructLab taxonomy.

You can submit knowledge or compositional skills. More information on the two types of contribution can be found in [our knowledge contribution details guide](knowledge_contribution_details.md) or [our compositional skills contribution guide](skills_contribution_details.md).

## `attribution.txt`

An important part of contributing to the InstructLab project is citing your sources of information. This comes in the form of your attribution.txt that you add to the pull requests. Almost all instances of attribution can be covered by the parameters required for Creative Commons Attribution licenses. Some parameters are as follows:

- Title of work
- Link to work
- Include link to a specific revision where possible
- License of the work
- Include an SPDX identifier where possible
- Creator names
- Copyright information
- Modification information
- Indicate if work was itself derived from another openly licensed work

- You can also see this citation style in the [Data sources documentation](https://github.com/instructlab/community/blob/main/docs/DataSources.md).

## Taxonomy tree layout

The taxonomy tree is organized in a cascading directory structure. At the end of each branch, there is a YAML file (qna.yaml) that contains the examples for that domain. Maintainers can decide to change the names of the existing branches or to add new branches.

> [!IMPORTANT]
> Folder names do not have spaces. Use underscores between words.

Below is an illustrative directory structure to show this layout:

```ascii
.
└── linguistics
    ├── writing
    │   ├── brainstorming
    │   │   ├── idea_generation
    |   │       └── qna.yaml
    │   │           attribution.txt
    │   │   ├── refute_claim
    |   │       └── qna.yaml
    │   │           attribution.txt
    │   ├── prose
    │   │   ├── articles
    │   │       └── qna.yaml
    │   │           attribution.txt
    └── grammar
        └── qna.yaml
        │   attribution.txt
        └── spelling
            └── qna.yaml
                attribution.txt
```

### Taxonomy diagram

> [!Note]
> This diagram shows a subset of the taxonomy. It is not a complete representation.

```mermaid
 flowchart TD;
   na[not accepting contributions\n at this time]:::na
   taxonomy --> foundational_skill & compositional_skills & knowledge

   foundational_skill:::na --> reasoning:::na
   reasoning:::na --> common_sense_reasoning:::na
   reasoning:::na --> mathematical_reasoning:::na
   reasoning:::na --> theory_of_mind:::na

   compositional_skills --> engineering
   compositional_skills --> grounded
   compositional_skills --> lingustics

   grounded --> grounded/arts
   grounded --> grounded/geography
   grounded --> grounded/history
   grounded --> grounded/science

   knowledge --> knowledge/arts

   knowledge --> knowledge/miscellaneous_unknown
   knowledge --> knowledge/science
   knowledge --> knowledge/technology
   knowledge/science --> animals --> birds --> black_capped_chickadee --> black_capped_chickadee-a & black_capped_chickadee-q
   knowledge/science --> astronomy --> constellations --> phoenix --> phoenix-a & phoenix-q

   black_capped_chickadee-a{attribution.txt}
   black_capped_chickadee-q{qna.yaml}
   phoenix-a{attribution.txt}
   phoenix-q{qna.yaml}
   classDef na fill:#EEE
```


## Considerations

When working with the upstream taxonomy, there are some things to keep in mind, like [topics to avoid](#avoid-these-topics), [what LLMs are great at doing](#llms-are-great-at), and [what LLMs will fail at](#llms-are-not-so-great-at). Explore this information before deciding what to contribute, especially the note about hallucinations at the end of this page.

### Avoid These Topics

While the tuning process may eventually benefit from being used to help the models work with complex social topics, at this time this is an area of active research we do not want to take lightly. Therefore, please keep your submissions clear of the following topics:

- PII (personally identifiable information) or any content invasive of individual privacy rights
- Violence including self-harm
- Cyber Bullying
- Internal documentation or other that is confidential to your employer or organization, e.g. trade secrets
- Discrimination
- Religion
    - Facts such as, "[Christianity is, according to the 2011 census, the fifth most practiced religion in Nepal, with 375,699 adherents, or 1.4% of the population](https://en.wikipedia.org/wiki/Christianity_in_Nepal)", are fine as a knowledge contribution. However, advocating in favor of or against any religious faith is not acceptable.
- Medical or health information
    - Facts such as,  "[In mammals, pulmonary ventilation occurs via inhalation (breathing)](https://opentextbc.ca/biology/chapter/11-3-circulatory-and-respiratory-systems/)," are fine as a knowledge contribution. However, tailored medical/health advice is not acceptable.
- Financial information
    - Facts such as "[laissez-faire economics ... argues that market forces alone should drive the economy and that governments should refrain from direct intervention in or moderation of the economic system](https://openstax.org/books/world-history-volume-2/pages/6-3-capitalism-and-the-first-industrial-revolution)," are fine as a knowledge contribution. However, tailored financial advice is not acceptable.
- Legal settlements/mitigations
- Gender Bias
- Hostile language, threats, slurs, derogatory or insensitive jokes or comments 
- Profanity 
- Pornography and sexually explicit or suggestive content 
- Any contributions that would allow for automated decision-making that affect an individual's rights or well-being, such as social scoring 
- Any contributions that engage in political campaigning or lobbying

We are also not accepting submissions of the following content:

- Jokes
    - We received many joke submissions at the beginning of the project, and with jokes being "in the eye of the beholder" and puns requiring nuance for native English speakers, we realized we were possibly unconsciously biasing our model. We have discovered that working with jokes has its own challenges, and if we want something generalized, finding consensus was unsuccessful. For now, we're not accepting additional submissions of jokes.
- Poems
    - We received many poem submissions at the beginning of the project, and with poems being "in the eye of the beholder" and puns requiring nuance for native English speakers, we realized we were possibly unconsciously biasing our model. We have discovered that working with both topics has its own challenges, and if we want something generalized, finding consensus was unsuccessful. For now, we're not accepting additional submissions of poems.
- Code
    - Anything code-related that can be traced back to code for a computer. Not limited to `sed` or `bash` but `yaml`s for OpenShift or Kubernetes, to `python` snippets to `Java` suggestions. There are specific models focused on this space and this isn't for this model for the time being.
- "Guardrails" for AI
    - We expect our upstream engineering team to create these types of skills and safeguards. We appreciate our community wanting to help with this, but there are underlying engineering decisions and taking this from the community may conflict with these.

### Building Your LLM Intuition

LLMs have inherent limitations that make certain tasks extremely difficult, like doing math problems. They're great at other tasks, like creative writing. And they could be better at things like logical reasoning.

In regard to skills, consider these limitations and advantages when you're generating skills. Skills in the first and second categories are welcomed. Skills in the third category are usually borderline and may be rejected.

In regard to knowledge, providing an LLM training pipeline with knowledge helps create a basis of information that the model can learn from. With InstructLab, you can teach it to use this knowledge via the `qna.yaml` files. For example, you can give an LLM the entire periodic table, then in a `qna.yaml` add something like:

```yaml
question: What is the symbol and atomic number for Chlorine?
answer: |
  The symbol for chlorine is "Cl", and the atomic number is 17.
```

With a few of these question-and-answer pairs, the model will learn the periodic table because it has the knowledge data.

#### LLMs are great at

- Brainstorming
- Creativity
- Connecting information
- Cross-lingual behavior

For these, however, it's common for LLMs to already have excellent performance. Try 3-5 examples in `ilab model chat` to confirm a deficit in the model before you build your submission, and share the examples in your Pull Request (PR).

Skills in this category are welcomed, as refining these abilities helps us get better at the kinds of tasks where LLMs can excel.

#### LLMs need help with

- Chains of reasoning
- Analysis
- Story plots
- Reassembling information
- Effective and succinct summaries

LLM behavior in these sorts of topics are very difficult for the model to get right. Skills in this category are particularly welcome. Try several examples to understand the nuances of the model's ability to do these sorts of tasks, and then consider using corrections to the results you get in your tuning process.

#### LLMs are not so great at

- Math
- Computation
- "Turing-complete" type tasks
- Generating only true real-world information (they're prone to hallucinations)

LLMs may struggle with solving math and computation problems, and LLMs may always struggle here. Solving math and computation problems via probability on natural language queries is probably not the best way to solve them. That said, improving some of these foundational skills may be something this work tackles in the future, but not at this time.

Most skill submissions in these categories are likely to be rejected.

!!! note "On Hallucinations"
    For hallucinations in particular, trying to solve this with a skill is unlikely to work. Consider contributing to the knowledge taxonomy instead to improve the model's understanding of facts.
