# Elsevier

This Quarto format will help you create documents for journals published by Elsevier. For more about producing LaTeX output for Elsevier journals, see <https://www.elsevier.com/authors/policies-and-guidelines/latex-instructions>.

## Creating a New Article

You can use this as a template to create an article for one of the Elsevier journals. To do this, use the following command:

`quarto use template quarto-journals/elsevier`

This will install the extension and create an example qmd file and bibiography that you can use as a starting place for your article.

## Installation For Existing Document

You may also use this format with an existing Quarto project or document. From the quarto project or document directory, run the following command to install this format:

`quarto install extension quarto-journals/elsevier`

## Usage

To use the format, you can use the format names `elsevier-pdf` and `elsevier-html`. For example:

`quarto render article.qmd --to elsevier-pdf`

or in your document yaml

``` yaml
format:
  pdf: default
  elsevier-pdf:
    keep-tex: true    
```

You can view a preview of the rendered template at <https://quarto-journals.github.io/elsevier/>.

## Format Options

The Elsevier format supports a number of options for customizing the format and appearance of the document. Specify these under the `journal` key.

---

**`formatting`**

`preprint` - default, which produces a standard preprint format

`review` - produces a document with additional spacing between elements (good for notes and comments)

`doubleblind` - omits the title block, allow for a doubleblind review

---

**`model`**

`1p` - the `1p` model of Elsevier journal formats. Always single column.

`3p` - the `3p` model of Elsevier journal formats. Sometimes single column, sometimes two column. Refer to the specific journal for guidance.

`5p` - the `5p` model of Elsevier journal formats. Always two column.

---

**`layout`**

`onecolumn` - for `3p` model documents, use a single column format (default)

`twocolumn` - for `3p` model documents, use a two column format

---

**`cite-style`**

`number` - use numbered formatting for citations (default).

`numbername` - use numbered name formatting citations.

`authoryear` - use author / year formatting (harvard) for citations.

Please refer to the specific journal for guidance.

---

**`graphical-abstract`**

Produces a separate page before the main document with a graphical abstract.

---

**`highlights`**

Produces a separate page before the main document with a list of highlights.

---

For example:

``` yaml
format:
  elsevier-pdf:
    journal:
      formatting: preprint
      model: 3p
      layout: twocolumn
      cite-style: numbered
      graphical-abstract: "![](abstract.png)"
      highlights:
        - Highlight 1
        - Highlight 2 
        - Highlight 3
```
