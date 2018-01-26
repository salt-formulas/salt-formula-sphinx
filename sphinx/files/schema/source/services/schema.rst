
==============================
Metadata Schema Specifications
==============================

Service {{ schema_item.service }} {{ schema_item.role }}
========================================================

Core Properties
---------------

{# Macro, process only one schema object #}
{%- macro chunk_object(o_name,obj) %}
{% set vars = {'is_ref': False, 'descr' : obj.get('description', 'description_notset'), 'type' : obj.get('type', 'ERROR') } %}
{%- if "properties" in obj %}
  {%- if vars.update({'is_ref': obj.get("properties",{}).get('$ref', {}) }) %} {% endif %}
{%- elif 'patternProperties' in obj and obj.patternProperties.get('$ref', False) %}
  {%- if vars.update({'is_ref': obj.patternProperties.get('$ref', False)}) %} {% endif %}
{%- elif 'patternProperties' in obj and not obj.patternProperties.get('$ref', {}) %}
  {%- for key, value in obj.patternProperties.iteritems() %}
    {%- if '$ref' in value %}
      {%- if vars.update({'is_ref': value.get('$ref',False) })  %} {% endif %}
    {%- endif %}
  {% endfor %}
{%- elif '$ref' in obj %}
  {%- if vars.update({'is_ref': obj.get('$ref', False) }) %} {% endif %}
{%- endif %}
  {%- if vars.is_ref %}
   *  - {{ o_name }}
      - {{ vars.type }}
      - {{ vars.descr }}
        {{ 'For details, see: :ref:`' + vars.is_ref|replace('#/definitions/','') + '`'}}
  {%- elif not vars.is_ref and "properties" in obj %}
    {%- for prop_name, prop in obj.properties.items() %}
       {{ chunk_object(prop_name, prop) }}
    {%- endfor %}
  {%- else %}
   *  - {{ o_name }}
      - {{ vars.type }}
      - {{ vars.descr }}
  {%- endif %}
{%- endmacro %}

{# Macro, process only one schema array #}
{%- macro chunk_array(i_name,item) %}
{%- set is_ref = False %}
{%- set _descr = item.get('description', 'description_notset') %}
{%- set _type = item.get('type', 'ERROR') %}
{%- if '$ref' in item.get("items",[])%}
  {%- set is_ref = item.get("items",[]).get('$ref', False) %}
{%- endif %}
   *  - {{ i_name }}
      - {{ _type }}
  {%- if is_ref %}
      - {{ _descr }}
        {{ 'For details, see: :ref:`' + is_ref|replace('#/definitions/','') + '`'}}
  {%- else %}
      - {{ '**NO REF** ' +_descr }}
  {%- endif %}
{%- endmacro %}
{###############}

.. list-table::
   :header-rows: 1
   :widths: 1 1 4

   *  - **Name**
      - **Type**
      - **Description**
{%- for param_name, param in schema.properties.items() %}
{%- set _descr = param.get('description', 'description_notset') %}
{%- set _type = param.get('type', 'ERROR') %}
     {%- if _type == 'object' -%}
       {{ chunk_object(param_name, param) }}
     {%- elif _type == 'array' -%}
       {{ chunk_array(param_name, param) }}
     {%- else %}
   *  - {{ param_name }}
      - {{ _type }}
      - {{ _descr }}
     {%- endif %}
{%- endfor %}


{%- if schema.get('definitions', None) != None %} {#2#}

{%- for def_name, param in schema.definitions.items() %} {#3#}

{{ '.. _' + def_name|lower + ':' }}

{{ def_name }} definition
------------------------------------------

.. list-table::
   :header-rows: 1
   :widths: 1 1 4

   *  - **Name**
      - **Type**
      - **Description**
{%- set _descr = param.get('description', 'description_notset') %}
{%- set _type = param.get('type', 'ERROR') %}
     {%- if _type == 'object' -%}
       {{ chunk_object(def_name, param) }}
     {%- elif _type == 'array' -%}
       {{ chunk_array(def_name, param) }}
     {%- else %}
   *  - {{ def_name }}
      - {{ _type }}
      - {{ _descr }}
     {%- endif %}
{% endfor %} {#3#}

{% endif %} {#2#}
