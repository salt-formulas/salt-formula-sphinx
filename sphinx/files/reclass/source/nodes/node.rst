
===============================================
Node {{ node_name }}
===============================================

{%- if node_grains.get('sphinx_doc', {}) is not none %}

{%- for service_name, service in node_grains.get('sphinx', {}).get('doc', {}).iteritems() %}

Service {{ service_name }}
===============================================

.. list-table::
   :header-rows: 1

   *  - **Service Role**
      - **Parameter**
      - **Value**
{%- for role_name, role in service.role.iteritems() %}
{%- for param_name, param in role.get('param', {}).iteritems() %}
   *  - {{ service_name }}-{{ role_name }}
      - {{ param_name }}
      - {{ param.value }}
{%- endfor %}
{%- endfor %}

{%- endfor %}

{%- else %}

This node has no documentation configured.

{%- endif %}
