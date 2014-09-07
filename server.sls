{%- set server = pillar.sphinx.server %}
{%- if server.enabled %}

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

{%- if doc.source.engine == 'git' %}

sphinx_source_{{ doc_name }}:
  {{ doc.source.engine }}.latest:
  - name: {{ doc.source.address }}
  - target: /srv/static/extern/{{ doc_name }}
  - rev: {{ doc.source.revision }}
  - require:
    - file: /srv/static/extern
  - require_in:
    - cmd: generate_sphinx_doc_{{ doc_name }}

generate_sphinx_doc_{{ doc_name }}:
  cmd.run:
  - name: sphinx-build -b {{ doc.builder }} /srv/static/extern/{{ doc_name }}{% if doc.path is defined %}/{{ doc.path }}{% endif %} /srv/static/sites/{{ doc_name }}
  - require:
    - git: sphinx_source_{{ doc_name }}
    - file: /srv/static/sites/{{ doc_name }}

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