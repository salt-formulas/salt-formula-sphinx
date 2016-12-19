{% macro render_list(param) %}
{{ param }} 
{% endmacro %}

.. _{{ node_name }}:

===============================================
{{ node_name }}
===============================================

{%- if node_grains.get('sphinx_doc', {}) is not none %}

{%- for service_name, service in node_grains.get('sphinx', {}).get('doc', {}).iteritems() %}

Service {{ service_name }}
===============================================

.. list-table::
   :widths: 15 15 70
   :header-rows: 1

   *  - **Service Role**
      - **Parameter**
      - **Value**
{%- if service.role is mapping %}
{%- for role_name, role in service.role.iteritems() %}
{%- if role.get('param', {}) %}
{%- for param_name, param in role.get('param', {}).iteritems() %}
   *  - {{ service_name }}-{{ role_name }}
      - {{ param.get('name', param_name) }}
      -
{{ render_list(param.value)|indent(8, True) }} 
{%- endfor %}
{%- endif %}
{%- endfor %}
{%- endif %}

{%- endfor %}

{%- else %}

This node has no documentation configured.

{%- endif %}
