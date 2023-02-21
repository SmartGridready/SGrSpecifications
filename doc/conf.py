# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

project = 'SmartGridready Technical Documentation'
copyright = '2023, Simon Zeller, Chris Brönnimann, Gino Abgomemewa'
author = 'Simon Zeller, Chris Brönnimann, Gino Abgomemewa'

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

extensions = ["myst_parser", "sphinx_rtd_theme"]

templates_path = ['_templates']
exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']



# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_theme = 'sphinx_rtd_theme'
html_logo = '_static/SGR_LOGO_RGB.png'
html_theme_options = {
    'logo_only': True,
    'display_version': False,
}
html_static_path = ['_static']
html_css_files = ["custom.css"]