---
title: Knowledge File Structure
description: The file structure for knowledge
logo: images/ilab_dog.png
---
# The knowledge files

Taxonomy trees in InstructLab have leaf-node directories. These leaf nodes contain at least one file, and usually two:

- A `qna.yaml` file that asks and answers questions about the information in the git repository where you have stored a knowledge document.
- An `attribution.txt` file that includes the sources for the information used in the `qna.yaml`. This file is only required when submitting knowledge [to the InstructLab taxonomy repository](https://github.com/instructlab/taxonomy).

## The `qna.yaml` file

In general, here are the fields in the YAML file:

Key | Type | Required | Constraints | Value | Notes
--|--|--|--|--|--
`version` | integer | Y | - | `3` | The taxonomy schema version used in the `qna.yaml` file. Defined in [instructlab/schema](https://github.com/instructlab/schema)
`created_by` | string | Y | no spaces | Your GitHub username (for the upstream taxonomy) or your name with no spaces (for general intructlab use) | -
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

#### `version`

The `version` field is the version of the [schema](https://github.com/instructlab/schema) that is in use. Currently, the value here should be `3`.

```yaml hl_lines="1" title="qna.yaml" linenums="1"
version: 3
domain: # ...
created_by: # ...
seed_examples:
  # ...
document_outline: # ...
document:
  # ...
```

#### `domain`

The `domain` field helps the synthetic data generation (SDG) process by identifying what specialized area the knowledge provided covers.

```yaml hl_lines="2" title="qna.yaml" linenums="1"
version: # ...
domain: astronomy
created_by: # ...
seed_examples:
  # ...
document_outline: # ...
document:
  # ...
```

#### `created_by`

The `created_by` field defines the user who submitted the knowledge. If you're working upstream, it would be your GitHub username. If you're working on your own taxonomy, it would be some kind of identifier with no spaces.

```yaml hl_lines="3" title="qna.yaml" linenums="1"
version: # ...
domain: # ...
created_by: juliadenham
seed_examples:
  # ...
document_outline: # ...
document:
  # ...
```

#### `seed_examples`

The `seed_examples` field does not have anything next to it because it is an array. An array in YAML is a collection of other values, and those values are indicated through indentation on subsequent lines.

```yaml hl_lines="4" title="qna.yaml" linenums="1"
version: # ...
domain: # ...
created_by: # ...
seed_examples:
  - context: # ...
    questions_and_answers:
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
document_outline: # ...
document:
  # ...
```

#### `context`

The `context` field is a snippet from the knowledge document that is used to answer the questions and answers that follow. It should be directly copied and pasted from the knowledge document as found in your knowledge repository. 

There will be more than one `context` field in the document.

```yaml hl_lines="5-12" title="qna.yaml" linenums="1"
version: # ...
domain: # ...
created_by: # ...
seed_examples:
  - context: |
      **Phoenix** is a minor constellation in the southern sky. Named after the mythical
      phoenix, it was first depicted on a celestial atlas by Johann Bayer in his 1603
      *Uranometria*. The French explorer and astronomer Nicolas Louis de
      Lacaille charted the brighter stars and gave their Bayer designations
      in 1756. The constellation stretches from roughly −39 degrees to −57 degrees
      declination, and from 23.5h to 2.5h of right ascension. The constellations Phoenix,
      Grus, Pavo, are known as the Southern Birds.
    questions_and_answers:
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
document_outline: # ...
document:
  # ...
```

#### `questions_and_answers`

The `questions_and_answers` field starts another array.

```yaml hl_lines="6" title="qna.yaml" linenums="1"
version: # ...
domain: # ...
created_by: # ...
seed_examples:
  - context: # ...
    questions_and_answers:
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
document_outline: # ...
document:
  # ...
```

### `question`

The `question` field is a sample question that the teacher model can use to train the student model during the synthetic data generation process.

There will be more than one `question` field in the document.

```yaml hl_lines="7-8 10-11 13-14" title="qna.yaml" linenums="1"
version: # ...
domain: # ...
created_by: # ...
seed_examples:
  - context: # ...
    questions_and_answers:
      - question: |
          What is the Phoenix constellation?
        answer: # ...
      - question: |
          Who charted the Phoenix constellation?
        answer: # ...
      - question: |
          How far does the Phoenix constellation stretch?
        answer: # ...
document_outline: # ...
document:
  # ...
```

### `answer`

The `answer` field is a sample expected answer for a question that the teacher model can use to train the student model during the synthetic data generation process.

There will be more than one `answer` field in the document.

```yaml hl_lines="8-9 11-13 15-17" title="qna.yaml" linenums="1"
version: # ...
domain: # ...
created_by: # ...
seed_examples:
  - context: # ...
    questions_and_answers:
      - question: # ...
        answer: |
          Phoenix is a minor constellation in the southern sky.
      - question: # ...
        answer: |
          The Phoenix constellation was charted by french explorer and
          astronomer Nicolas Louis de Lacaille.
      - question: # ...
        answer: |
          The phoenix constellation stretches from roughly −39° to −57°
          declination, and from 23.5h to 2.5h of right ascension.
document_outline: # ...
document:
  # ...
```

### `document_outline`

```yaml hl_lines="5-7" title="qna.yaml" linenums="1"
version: # ...
domain: # ...
created_by: # ...
seed_examples: # ...
document_outline:  |
  Information about the Phoenix Constellation including the
  history, characteristics, and features of the stars in the constellation.
document:
  # ...
```

### `document`

The `document` field starts another array.

```yaml hl_lines="6" title="qna.yaml" linenums="1"
version: # ...
domain: # ...
created_by: # ...
seed_examples: # ...
document_outline: # ...
document:
    repo: # ...
    commit: # ...
    patterns: # ...
```

### `repo`

```yaml hl_lines="7" title="qna.yaml" linenums="1"
version: # ...
domain: # ...
created_by: # ...
seed_examples: # ...
document_outline: # ...
document:
    repo: https://github.com/juliadenham/Summit_knowledge
    commit: # ...
    patterns: # ...
```

### `commit`

```yaml hl_lines="8" title="qna.yaml" linenums="1"
version: # ...
domain: # ...
created_by: # ...
seed_examples: # ...
document_outline: # ...
document:
    repo: # ...
    commit: 0a1f2672b9b90582e6115333e3ed62fd628f1c0f
    patterns: # ...
```

### `patterns`

```yaml hl_lines="9-10" title="qna.yaml" linenums="1"
version: # ...
domain: # ...
created_by: # ...
seed_examples: # ...
document_outline: # ...
document:
    repo: # ...
    commit: # ...
    patterns:
      - phoenix_constellation.md
```

## Example of a knowledge submission
 
You can review a full example of a knowledge submission for the upstream taxonomy in [this commit in the taxonomy repository](https://github.com/instructlab/taxonomy/commit/1fdbbe0cf3136c14bfd6b45dfadb532b027eeb11).

=== "The submission"
    - [the `qna.yaml` file](#__tabbed_1_2)
    - [the `attribution.txt` file](#__tabbed_1_3)

=== "The `qna.yaml` file"
    ```yaml
    version: 3
    domain: astronomy
    created_by: juliadenham
    seed_examples:
      - context: |
          **Phoenix** is a minor constellation in the southern sky. Named after the mythical
          phoenix, it was first depicted on a celestial atlas by Johann Bayer in his 1603
          *Uranometria*. The French explorer and astronomer Nicolas Louis de
          Lacaille charted the brighter stars and gave their Bayer designations
          in 1756. The constellation stretches from roughly −39 degrees to −57 degrees
          declination, and from 23.5h to 2.5h of right ascension. The constellations Phoenix,
          Grus, Pavo, are known as the Southern Birds.
        questions_and_answers:
          - question: |
              What is the Phoenix constellation?
            answer: |
              Phoenix is a minor constellation in the southern sky.
          - question: |
              Who charted the Phoenix constellation?
            answer: |
              The Phoenix constellation was charted by french explorer and
              astronomer Nicolas Louis de Lacaille.
          - question: |
              How far does the Phoenix constellation stretch?
            answer: |
              The phoenix constellation stretches from roughly −39° to −57°
              declination, and from 23.5h to 2.5h of right ascension.
      - context: |
          Phoenix was the largest of the 12 constellations established by Petrus
          Plancius from the observations of Pieter Dirkszoon Keyser and Frederick de
          Houtman. It first appeared on a 35cm diameter celestial globe published
          in 1597 (or 1598) in Amsterdam by Plancius with Jodocus Hondius. The first
          depiction of this constellation in a celestial atlas was in Johann Bayer's
          *Uranometria* of 1603. De Houtman included it in his southern star catalog
          the same year under the Dutch name *Den voghel Fenicx*, "The Bird Phoenix",
          symbolising the phoenix of classical mythology. One name of the brightest star Alpha
          Phoenicis—Ankaa—is derived from the Arabic: العنقاء, romanized: al-‘anqā’,
          lit. 'the phoenix', and was coined sometime after 1800 in relation to the constellation.
        questions_and_answers:
          - question: |
              What is the brightest star in the Phoenix constellation
              called?
            answer: |
              Alpha Phoenicis or Ankaa is the brightest star in the Phoenix
              Constellation.
          - question: Where did the Phoenix constellation first appear?
            answer: |
              The Phoenix constellation first appeared on a 35-cm diameter
              celestial globe published in 1597 (or 1598) in Amsterdam by
              Plancius with Jodocus Hondius.
          - question: |
              What does "The Bird Phoenix" symbolize?
            answer: |
              "The Bird Phoenix" symbolizes the phoenix of classical mythology.
      - context: |
          Phoenix is a small constellation bordered by Fornax and Sculptor to the north,
          Grus to the west, Tucana to the south, touching on the corner of Hydrus to the
          south, and Eridanus to the east and southeast. The bright star Achernar is
          nearby. The three-letter abbreviation for the constellation, as adopted by the
          International Astronomical Union in 1922, is "Phe". The official constellation
          boundaries, as set by Belgian astronomer Eugène Delporte in 1930,
          are defined by a polygon of 10 segments. In the equatorial coordinate system, the right
          ascension coordinates of these borders lie between 23h 26.5m and 02h 25.0m,
          while the declination coordinates are between −39.31° and −57.84°. This means it remains
          below the horizon to anyone living north of the 40th parallel in the Northern
          Hemisphere, and remains low in the sky for anyone living north of the equator.
          It is most visible from locations such as Australia and South Africa during
          late Southern Hemisphere spring. Most of the constellation lies within, and
          can be located by, forming a triangle of the bright stars Achernar, Fomalhaut
          and Beta Ceti—Ankaa lies roughly in the centre of this.
        questions_and_answers:
          - question: What are the characteristics of the Phoenix constellation?
            answer: |
              Phoenix is a small constellation bordered by Fornax and Sculptor to
              the north, Grus to the west, Tucana to the south, touching on the
              corner of Hydrus to the south, and Eridanus to the east and southeast.
              The bright star Achernar is nearby.
          - question: |
              When is the phoenix constellation most visible?
            answer: |
              Phoenix is most visible from locations such as Australia and
              South Africa during late Southern Hemisphere spring.
          - question: |
              What are the Phoenix Constellation boundaries?
            answer: |
              The official constellation boundaries for Phoenix, as set by Belgian
              astronomer Eugène Delporte in 1930, are defined by a polygon of 10
              segments.
      - context: |
          Ten stars have been found to have planets to date, and four planetary
          systems have been discovered with the SuperWASP project. HD 142 is a yellow
          giant that has an apparent magnitude of 5.7, and has a planet HD 142b 1.36
          times the mass of Jupiter which orbits every 328 days.  HD 2039 is a yellow
          subgiant with an apparent magnitude of 9.0 around 330 light years away which
          has a planet HD 2039 b six times the mass of Jupiter. WASP-18 is a star of
          magnitude 9.29 which was discovered to have a hot Jupiter-like planet taking
          less than a day to orbit the star. The planet is suspected to be causing WASP-18 to
          appear older than it really is. WASP-4 and WASP-5 are solar-type yellow stars around 1000
          light years distant and of 13th magnitude, each with a single planet larger
          than Jupiter. WASP-29 is an orange dwarf of spectral type K4V and visual magnitude
          11.3, which has a planetary companion of similar size and mass to Saturn. The planet
          completes an orbit every 3.9 days.
        questions_and_answers:
          - question: In the Phoenix constellation, how many stars have planets?
            answer: |
              In the Phoenix constellation, ten stars have been found to have
              planets to date, and four planetary systems have been discovered
              with the SuperWASP project.
          - question: |
              What is HD 142?
            answer: |
              HD 142 is a yellow giant that has an apparent magnitude of 5.7, and
              has a planet (HD 142 b) 1.36 times the mass of Jupiter which
              orbits every 328 days.
          - question: |
              Are WASP-4 and WASP-5 solar-type yellow stars?
            answer: |
              Yes, WASP-4 and WASP-5 are solar-type yellow stars around 1000 light
              years distant and of 13th magnitude, each with a single planet
              larger than Jupiter.
      - context: |
          The constellation does not lie on the galactic plane of the Milky Way, and there
          are no prominent star clusters. NGC 625 is a dwarf irregular galaxy of apparent magnitude 11.0
          and lying some 12.7 million light years distant. Only 24000 light years in
          diameter, it is an outlying member of the Sculptor Group. NGC 625 is
          thought to have been involved in a collision and is experiencing a burst
          of active star formation. NGC 37 is a lenticular galaxy of apparent magnitude
          14.66. It is approximately 42 kiloparsecs in diameter and about 12.9 billion years old.
          Robert's Quartet , and three spiral galaxies NGC 88 and NGC 92) is a group of
          four galaxies located around 160 million light-years away which are in the process of colliding
          and merging. They are within a circle of radius of 1.6 arcmin, corresponding to about
          75,000 light-years. Located in the galaxy ESO 243-49 is HLX-1, an intermediate-mass
          black hole intermediate-mass_black_hole —the first one of its kind identified.
          It is thought to be a remnant of a dwarf galaxy that was absorbed in a collision
          with ESO 243-49. Before its discovery, this class of black hole was only hypothesized.
        questions_and_answers:
          - question: |
              Is the Phoenix Constellation part of the Milky Way?
            answer: |
              The Phoenix constellation does not lie on the galactic plane of
              the Milky Way, and there are no prominent star clusters.
          - question: |
              How many light years away is NGC 625?
            answer: |
              NGC 625 is 24000 light years in diameter and is an outlying
              member of the Sculptor Group.
          - question: |
              What is Robert's Quartet composed of?
            answer: |
              Robert's Quartet is composed of the irregular galaxy NGC 87,
              and three spiral galaxies NGC 88, NGC 89 and NGC 92.
    document_outline: |
      Information about the Phoenix Constellation including the
      history, characteristics, and features of the stars in the constellation.
    document:
        repo: https://github.com/juliadenham/Summit_knowledge
        commit: 0a1f2672b9b90582e6115333e3ed62fd628f1c0f
        patterns:
          - phoenix_constellation.md
    ```

=== "The `attribution.txt` file"
    ```text
    Title of work: Phoenix (constellation)
    Link to work: https://en.wikipedia.org/wiki/Phoenix_(constellation)
    Revision: https://en.wikipedia.org/w/index.php?title=Phoenix_(constellation)&oldid=1237187773
    License of the work: CC-BY-SA-4.0
    Creator names: Wikipedia Authors
    ```

For more information on what to include in your `attribution.txt` file, see [For your attribution.txt file](https://github.com/instructlab/taxonomy/blob/main/CONTRIBUTING.md#for-your-attributiontxt-file) in the CONTRIBUTING.md file.

### Example of a knowledge document file

The previous knowledge example references one Markdown file: `phoenix_constellation.md`. You can also add multiple Markdown files or PDFs for knowledge contributions.

Here's what a snippet of `phoenix_constellation.md` might look like in your Git repository.

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

You can organize the knowledge files in your repository however you want. You need to ensure the YAML is pointing to the correct file.

