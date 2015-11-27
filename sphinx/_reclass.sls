
reclass_doc_dirs:
  file.directory:
  - names:
    - /srv/static/extern/reclass/source/_static
    - /srv/static/extern/reclass/source/overview
    - /srv/static/extern/reclass/source/nodes
    - /srv/static/extern/reclass/source/devices
  - user: root
  - mode: 755
  - makedirs: true

/srv/static/extern/reclass/Makefile:
  file.managed:
  - source: salt://sphinx/files/reclass/Makefile
  - mode: 644
  - require:
    - file: reclass_doc_dirs

/srv/static/extern/reclass/source/conf.py:
  file.managed:
  - source: salt://sphinx/files/reclass/source/conf.py
  - mode: 644
  - require:
    - file: reclass_doc_dirs

/srv/static/extern/reclass/source/index.rst:
  file.managed:
  - source: salt://sphinx/files/reclass/source/index.rst
  - template: jinja
  - mode: 644
  - require:
    - file: reclass_doc_dirs

/srv/static/extern/reclass/source/overview/nodes.rst:
  file.managed:
  - source: salt://sphinx/files/reclass/source/overview/nodes.rst
  - template: jinja
  - mode: 644
  - require:
    - file: reclass_doc_dirs

/srv/static/extern/reclass/source/overview/endpoints.rst:
  file.managed:
  - source: salt://sphinx/files/reclass/source/overview/endpoints.rst
  - template: jinja
  - mode: 644
  - require:
    - file: reclass_doc_dirs

/srv/static/extern/reclass/source/overview/services.rst:
  file.managed:
  - source: salt://sphinx/files/reclass/source/overview/services.rst
  - template: jinja
  - mode: 644
  - require:
    - file: reclass_doc_dirs

{%- for node_name, node_grains in salt['mine.get']('*', 'grains.items').iteritems() %}

/srv/static/extern/reclass/source/nodes/{{ node_name }}.rst:
  file.managed:
  - source: salt://sphinx/files/reclass/source/nodes/node.rst
  - template: jinja
  - mode: 644
  - require:
    - file: reclass_doc_dirs
  - defaults:
    node_name: {{ node_name }}
    node_grains: {{ node_grains|yaml }}

{%- endfor %}

generate_sphinx_doc_{{ doc_name }}:
  cmd.run:
  - name: sphinx-build -b {{ doc.builder }} /srv/static/extern/reclass{% if doc.path is defined %}/{{ doc.path }}{% endif %} /srv/static/sites/{{ doc_name }}
  - require:
    - file: /srv/static/sites/{{ doc_name }}
