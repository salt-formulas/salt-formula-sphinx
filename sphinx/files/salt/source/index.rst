{%- set doc = salt['pillar.get']('sphinx:server:doc:'+doc_name) %}

=============================================================================================
{% if doc.title is defined %}{{ doc.title }}{% else %}Model-Driven Documentation{% endif %}
=============================================================================================

{%- if doc.description is defined %}
{{ doc.description }}
{%- else %}
Model-driven documentation of SaltStack infrastructure deployment.
{%- endif %}

.. toctree::
   :maxdepth: 2

   services/index
   nodes/index
