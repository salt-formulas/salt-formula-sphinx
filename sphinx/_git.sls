
sphinx_source_{{ doc_name }}:
  {{ doc.source.engine }}.latest:
  - name: {{ doc.source.address }}
  - target: /srv/static/extern/{{ doc_name }}
  - rev: {{ doc.source.revision }}
  - require:
    - file: /srv/static/extern
    - pkg: git_packages
  - require_in:
    - cmd: generate_sphinx_doc_git_{{ doc_name }}

generate_sphinx_doc_git_{{ doc_name }}:
  cmd.run:
  - name: {{ sphinx_build_bin }} -b {{ doc.builder }} /srv/static/extern/{{ doc_name }}{% if doc.path is defined %}/{{ doc.path }}{% endif %} /srv/static/sites/{{ doc_name }}
  - require:
    - git: sphinx_source_{{ doc_name }}
    - file: /srv/static/sites/{{ doc_name }}
