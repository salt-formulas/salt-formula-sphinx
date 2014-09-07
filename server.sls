{%- if pillar.sphinx.server.enabled %}

sphinx_packages:
  pkg.installed:
  - names:
    - python-sphinx

/srv/sphinx/sites:
  file.directory:
  - mode: 755
  - makedirs: true

/srv/sphinx/extern:
  file.directory:
  - mode: 755
  - makedirs: true

{%- for doc_name, doc in server.doc.iteritems() %}

/srv/sphinx/sites/{{ doc_name }}:
  file.directory:
  - mode: 755
  - makedirs: true
  - require:
    - file: /srv/sphinx/sites

{%- if doc.source.engine == 'git' %}

sphinx_source_{{ doc_name }}:
  {{ doc.source.engine }}.latest:
  - name: {{ doc.source.address }}
  - target: /srv/sphinx/extern/{{ doc_name }}
  - rev: {{ plugin.source.revision }}
  - require:
    - file: /srv/sphinx/extern
  - require_in:
    - cmd: generate_sphinx_doc_{{ doc_name }}

generate_sphinx_doc_{{ doc_name }}:
  cmd.run:
  - name: sphinx-build -b {{ doc.builder }} /srv/sphinx/extern/{{ doc_name }} /srv/sphinx/sites/{{ doc_name }}
  - require:
    - git: sphinx_source_{{ doc_name }}
    - file: /srv/sphinx/sites/{{ doc_name }}

{%- endif -%}

{%- if doc.source.engine == 'local' %}

generate_sphinx_doc_{{ doc_name }}:
  cmd.run:
  - name: sphinx-build -b {{ doc.builder }} {{ doc.source.path }} /srv/sphinx/sites/{{ doc_name }}
  - require:
    - file: /srv/sphinx/sites/{{ doc_name }}

{%- endif %}

{%- endfor %}

{%- endif %}