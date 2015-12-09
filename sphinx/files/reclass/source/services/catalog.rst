
===============================
Service Catalog
===============================

All service definitions of configured infrastructure.

.. list-table::
   :widths: 20 80
   :header-rows: 1

   *  - **Service**
      - **Description**
{%- for node_name, node_grains in salt['mine.get']('*', 'grains.items').iteritems() %}
{%- if node_grains.get('sphinx_doc', {}) != None %}
{%- for service_name, service in node_grains.get('sphinx', {}).get('doc', {}).iteritems() %}
   *  - {{ service.name }}
      - {{ service.get('description', '') }}
{%- endfor %}
{%- endif %}
{%- endfor %}
