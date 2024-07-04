# Kroki Extension For Quarto

This extensions allows you to use a Kroki service to show diagrams.

## Installation

```bash
quarto add resepemb/quarto-kroki
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

## Usage

Once installed, this extension is implemented as a filter in Quarto, making easy to use.

Put kroki in your list of filters and your diagram script inside a code block with ```{kroki-diagramType}```

Like this:

```` markdown
---
title: Simple Kroki Diagram Example
filters:
- kroki
---

```{kroki-plantuml}
class User {
-String id
-String name
+String name()
}
User <|-- SpecificUser
```

````
You can also specify the image format you want: ``` {kroki-mermaid-png} ```.

This is optional, the default format is SVG.

## Configs

In case you need to consume a custom Kroki service, you can set in each file, or define a custom default:

Example setting a different kroki service url in ```_quarto.yml``` (Quarto website project):

```markdown
project:
  type: website

website:
  title: "Mysite"
  navbar:
    left:
      - href: index.qmd
        text: Home
      - about.qmd

format:
  html:
    theme: cosmo
    css: styles.css
    toc: true

kroki:
  serviceUrl: "http://localhost:8000"

```

Example setting in a isolated file ```.qmd```:

````markdown
---
title: "Quarto-Kroki"
filters:
  - kroki
kroki:
    serviceUrl: "http://localhost:8000"
---

## Kroki extension example

This filter allows you to show diagrams.

```{kroki-plantuml}
class User {
  -String id
  -String name
  +String name()
}
User <|-- SpecificUser
```
````

> **Note** 
> Configs are under development, this section may be updated soon !!!

## Example

Here is the source code for a minimal example: [example.qmd](example.qmd).



