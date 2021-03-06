{% macro render_list(param) %}
{%- if param %}
   {%- if param is mapping %}
      {%- for key, value in param.iteritems() %}
- {{ key }}: {{ value }}
      {%- endfor %}
   {%- elif param is string or param is number %}
{{ param }}
   {%- else %}
      {%- for p in param %}
- {{ p }}
      {%- endfor %}
   {%- endif %}
{%- else %}
None
{%- endif %}
{% endmacro %}

.. _{{ node_name }}:

===============================================
{{ node_name }}
===============================================

{%- if node_grains.get('sphinx_doc', {}) is not none %}

   {%- for service_name, service in node_grains.get('sphinx', {}).get('doc', {})|dictsort %}

Service {{ service_name }}
===============================================

.. list-table::
   :widths: 15 15 70
   :header-rows: 1

   *  - **Service Role**
      - **Parameter**
      - **Value**
   {%- if service.role is mapping %}
      {%- for role_name, role in service.role|dictsort %}
         {%- if role.get('param', {}) %}
            {%- for param_name, param in role.get('param', {})|dictsort %}
   *  - {{ service_name }}-{{ role_name }}
               {%- if param is mapping %}
      - {{ param.get('name', param_name) }}
      -
{{ render_list(param.value)|indent(8, True) }}
               {%- else %}
      - {{ param_name }}
      - {{ param }}
               {%- endif %}
            {%- endfor %}
         {%- endif %}
      {%- endfor %}
   {%- endif %}

   {%- endfor %}

{%- else %}

This node has no documentation configured.

{%- endif %}
{#-
   vim: syntax=jinja
#}
