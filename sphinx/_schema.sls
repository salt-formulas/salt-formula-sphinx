
salt_schema_doc_dirs:
  file.directory:
  - names:
    - /srv/static/extern/salt-schema/source/_static
    - /srv/static/extern/salt-schema/source/services
    - /srv/static/extern/salt-schema/source/nodes
  - user: root
  - mode: 755
  - makedirs: true

/srv/static/extern/salt-schema/Makefile:
  file.managed:
  - source: salt://sphinx/files/schema/Makefile
  - mode: 644
  - require:
    - file: salt_schema_doc_dirs

/srv/static/extern/salt-schema/source/conf.py:
  file.managed:
  - source: salt://sphinx/files/schema/source/conf.py
  - template: jinja
  - mode: 644
  - require:
    - file: salt_schema_doc_dirs
  - defaults:
      doc: {{ doc|yaml }}

/srv/static/extern/salt-schema/source/index.rst:
  file.managed:
  - source: salt://sphinx/files/schema/source/index.rst
  - template: jinja
  - mode: 644
  - require:
    - file: salt_schema_doc_dirs
  - defaults:
      doc_name: "{{ doc_name }}"

/srv/static/extern/salt-schema/source/services/catalog.rst:
  file.managed:
  - source: salt://sphinx/files/schema/source/services/catalog.rst
  - template: jinja
  - mode: 644
  - require:
    - file: salt_schema_doc_dirs
  - defaults:
      doc_name: "{{ doc_name }}"

{### render service-schemas #}
{%- set schema_list  = salt['modelschema.schema_list']() %}

# Schema name should be filtered by uniq.
# TBD with salt 2017+
{%- for schema_name, schema_item in schema_list.items() %}
{%- set schema  = salt['modelschema.schema_get'](schema_item.service, schema_item.role)[schema_item.service+'-'+schema_item.role] %}

schema_dir_{{schema_item.service}}_{{schema_item.role}}:
  file.directory:
  - names:
    - /srv/static/extern/salt-schema/source/services/{{ schema_item.service }}
  - user: root
  - mode: 755
  - makedirs: true

schema_rst_{{schema_item.service}}_{{schema_item.role}}:
  file.managed:
  - source: salt://sphinx/files/schema/source/services/schema.rst
  - name: /srv/static/extern/salt-schema/source/services/{{schema_item.service}}/{{schema_item.role}}.rst
  - template: jinja
  - context:
      schema_item: {{ schema_item }}
      schema: {{ schema }}
  - mode: 644
  - require:
    - file: schema_dir_{{schema_item.service}}_{{schema_item.role}}

{%- endfor %}
{### end render service-schemas #}

{%- set mine_nodes = salt['mine.get']('*', 'grains.items') %}
{%- if mine_nodes is mapping %}

{%- for node_name, node_grains in mine_nodes.iteritems() %}

/srv/static/extern/salt-schema/source/nodes/{{ node_name }}.rst:
  file.managed:
  - source: salt://sphinx/files/schema/source/nodes/node.rst
  - template: jinja
  - mode: 644
  - require:
    - file: salt_schema_doc_dirs
  - defaults:
      node_name: {{ node_name }}
      node_grains: {{ node_grains|yaml }}

{%- endfor %}

{%- endif %}

generate_sphinx_doc_schema_{{ doc_name }}:
  cmd.run:
  - name: {{ sphinx_build_bin }} -b {{ doc.builder }} /srv/static/extern/salt-schema/source /srv/static/sites/{{ doc_name }}
  - require:
    - file: /srv/static/sites/{{ doc_name }}
