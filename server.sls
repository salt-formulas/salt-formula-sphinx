{%- if pillar.sphinx.server.enabled %}

sphinx_packages:
  pkg.installed:
  - names:
    - python-sphinx

/srv/sphinx/sites:
  file:
  - directory
  - mode: 755
  - makedirs: true

{%- for doc in pillar.sphinx.server.docs %}

/srv/sphinx/sites/{{ doc.name }}:
  file:
  - directory
  - mode: 755
  - makedirs: true
  - require:
    - file: /srv/sphinx/sites

generate_sphinx_doc_{{ doc.name }}:
  cmd.run:
  - name: sphinx-build -b {{ doc.builder }} {{ doc.source }} /srv/sphinx/sites/{{ doc.name }}
  - require:
    - file: /srv/sphinx/sites/{{ doc.name }}

{%- endfor %}

{%- endif %}