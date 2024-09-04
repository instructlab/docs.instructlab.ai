---
title: Getting Started with Knowledge Contributions
description: Adding knowledge to 🐶 InstructLab
logo: images/ilab_dog.png
---
## Getting Started with Knowledge Contributions

While skills are foundational or performative, knowledge is based more on answering questions that involve facts, data, or references.

Knowledge is supported by documents, such as a textbook, technical manual, encyclopedia, journal, or magazine.

Knowledge in the taxonomy tree consists of a few more elements than skills:

- Each knowledge node in the tree has a `qna.yaml`, similar to the format of the `qna.yaml` for skills.
- ⭐ Knowledge submissions require you to create a Git repository, which can be with GitHub, that contains the markdown files of your knowledge contributions. These contributions in your repository must use the markdown (`.md`) format.
- The `qna.yaml` includes parameters that contain information from your repository.

!!! tip
    Guidelines for Knowledge contributions

    - Submit the most up-to-date version of the document
    - All submissions must be text; images will be ignored
    - Do not use tables in your markdown freeform contribution

The `qna.yaml` format must include the following fields:

- `version`: The version of the `qna.yaml` file; this is the format of the file that is used for SDG. The value must be the number 3.
- `created_by`: Your GitHub username.
- `domain`: Specify the category of the knowledge.
- `seed_examples`: A collection of key/value entries.
  - `context`: A chunk of information from the knowledge document. Each `qna.yaml` needs five `context` blocks. The context has a maximum token count of 500 tokens. Also, each `context` blocks should have at least 3 question and answer pairs, with a maximum token count of 250 for all 3 question and answer pairs.
  - `questions_and_answers`: The parameter that holds your questions and answers.
    - `question`: Specify a question for the model. Each `qna.yaml` file needs at least three question and answer pairs per `context` chunk.
    - `answer`: Specify the desired answer from the model. Each `qna.yaml` file needs at least three question and answer pairs per `context` chunk.
- `document_outline`: Describe an overview of the document your submitting.
- `document`: The source of your knowledge contribution.
  - `repo`: The URL for your repository that holds your knowledge markdown files.
  - `commit`: The SHA of the commit in your repository with your knowledge markdown files.
  - `patterns`: A list of glob patterns that specify the markdown files in your repository. Any glob pattern that starts with `*`, such as `*.md`, must be quoted due to YAML rules. For example, `"*.md"`.

### Knowledge: YAML examples

*Example of a `qna.yaml` file*

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

*Example of an `attribution.txt` file*

```text
Title of work: Phoenix (constellation)
Link to work: https://en.wikipedia.org/wiki/Phoenix_(constellation)
Revision: https://en.wikipedia.org/w/index.php?title=Phoenix_(constellation)&oldid=1237187773
License of the work: CC-BY-SA-4.0
Creator names: Wikipedia Authors
```

For more information on what to include in your `attribution.txt` file, see [For your attribution.txt file](https://github.com/instructlab/taxonomy/blob/main/CONTRIBUTING.md#for-your-attributiontxt-file) in the CONTRIBUTING.md file.

### Knowledge: Markdown file example

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

### Knowledge: directory tree example

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
