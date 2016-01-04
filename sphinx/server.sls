{%- set server = pillar.sphinx.server %}
{%- if server.enabled %}

include:
- git

sphinx_packages:
  pkg.installed:
  - names:
    - python-sphinx

/srv/static/sites:
  file.directory:
  - mode: 755
  - makedirs: true

/srv/static/extern:
  file.directory:
  - mode: 755
  - makedirs: true

{%- for doc_name, doc in server.doc.iteritems() %}

/srv/static/sites/{{ doc_name }}:
  file.directory:
  - mode: 755
  - makedirs: true
  - require:
    - file: /srv/static/sites

{%- if doc.source.engine in ['reclass', 'salt-mine'] %}
{%- include "sphinx/_salt.sls" %}
{%- endif -%}

{%- if doc.source.engine == 'git' %}
{%- include "sphinx/_git.sls" %}
{%- endif -%}

{%- if doc.source.engine == 'local' %}

generate_sphinx_doc_{{ doc_name }}:
  cmd.run:
  - name: sphinx-build -b {{ doc.builder }} {{ doc.source.path }} /srv/static/sites/{{ doc_name }}
  - require:
    - file: /srv/static/sites/{{ doc_name }}

{%- endif %}

{%- endfor %}

{%- endif %}