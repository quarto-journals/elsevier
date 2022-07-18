# elsevier

This Quarto format will help you create documents for journals published by Elsevier. For more about producing LaTeX output for Elsevier journals, see <https://www.elsevier.com/authors/policies-and-guidelines/latex-instructions>.

## Creating a New Article

You can use this as a template to create an article for one of the Elsevier journals. To do this, use the following command:

```quarto use template quarto-journals/elsevier```

This will install the extension and create an example qmd file and bibiography that you can use as a starting place for your article.


## Installation For Existing Document

You may also use this format with an existing Quarto project or document. From the quarto project or document directory, run the following command to install this format:

```quarto install extension quarto-journals/elsevier```

## Usage 

To use the format, you can use the format names `elsevier-pdf` and `elsevier-html`. For example:

```quarto render article.qmd --to elsevier-pdf```

or in your document yaml

```yaml
format:
  pdf: default
  elsevier-pdf:
    keep-tex: true    
```

You can view a preview of the rendered template at <https://quarto-journals.github.io/elsevier/>. 

