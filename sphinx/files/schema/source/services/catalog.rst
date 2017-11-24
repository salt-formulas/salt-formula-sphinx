
==============================
Overview of Available Services
==============================

Simple oveview of all defined services and their description.

{%- set services = {} %}
{%- for node_name, node_grains in salt['mine.get']('*', 'grains.items')|dictsort %}
  {%- if node_grains.get('sphinx_doc', {}) != None %}
  {%- set _dummy = services.update(node_grains.get('sphinx', {}).get('doc', {})) %}
  {%- endif %}
{%- endfor %}

.. list-table::
   :widths: 20 80
   :header-rows: 1

   *  - **Service**
      - **Description**
{%- for service_name, service in services|dictsort %}
   *  - {{ service.name }}
      - {{ service.get('description', 'nodescr') }}
{%- endfor %}



.. toctree::
   :maxdepth: 10

{% set schema_list  = salt['modelschema.schema_list']() -%}
{%- for schema_name, schema_item in schema_list.iteritems() %}
{%- set schema  = salt['modelschema.schema_get'](schema_item.service, schema_item.role)[schema_item.service+'-'+schema_item.role] %}
   {{schema_item.service}}/{{schema_item.role}}.rst
{%- endfor %}


