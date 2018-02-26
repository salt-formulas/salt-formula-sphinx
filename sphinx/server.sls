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

{%- if doc.get("prebuilded_venv", False) %}
  {%- set sphinx_build_bin = doc.prebuilded_venv + "/sphinx-build"  %}
{% else %}
  {%- set sphinx_build_bin = "sphinx-build"  %}
{%- endif %}

{% with sphinx_build_bin=sphinx_build_bin %}
{%- if doc.source.engine in ['reclass', 'salt-mine'] %}
{%- include "sphinx/_salt.sls" %}
{%- endif -%}

{%- if doc.source.engine in ['pillar-schema'] %}
{%- include "sphinx/_schema.sls" %}
{%- endif -%}

{%- if doc.source.engine == 'git' %}
{%- include "sphinx/_git.sls" %}
{%- endif -%}
{% endwith %}

{%- endfor %}

{%- endif %}
