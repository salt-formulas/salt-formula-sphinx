{%- set doc = salt['pillar.get']('sphinx:server:doc:'+doc_name) %}

=============================================================================================
{% if doc.title is defined %}{{ doc.title }}{% else %}SaltStack Deployment Documentation{% endif %}
=============================================================================================

{%- if doc.description is defined %}
{{ doc.description }}
{%- else %}
Documentation generated from SaltStack infrastructure model.
{%- endif %}

.. toctree::
   :maxdepth: 3

   services/index
   nodes/index
