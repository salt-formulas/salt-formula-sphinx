{%- set mine_nodes = salt['mine.get']('*', 'grains.items') %}
{%- if mine_nodes is mapping %}

====================
Infrastructure Nodes
====================

Definition of all nodes within current infrastructure.

.. list-table::
   :widths: 30 15 55
   :header-rows: 1

   *  - **Node FQDN**
      - **IP Addresses**
      - **Assigned Services**
{%- for node_name, node_grains in mine_nodes.iteritems() %}
   *  - :ref:`{{ node_name }}`
{%- if node_grains.sphinx is defined %}
      - {% for ip in node_grains.ipv4 %}
        {%- if ip != "127.0.0.1" %}
        * {{ ip }}
        {%- endif %}
        {%- endfor %}
      - {% for service_name, service in node_grains.get('sphinx', {}).get('doc', {}).iteritems() %}{% if service.role is mapping %}{% for role_name, role in service.role.iteritems() %}{{ service_name }}-{{ role_name }} {% endfor %}{% endif %}{% endfor %}
{%- else %}
      - N/A
      - N/A
{%- endif %}
{%- endfor %}

.. toctree::
   :maxdepth: 2

{% for node_name, node_grains in mine_nodes.iteritems() %}
{%- if node_grains.get('sphinx_doc', {}) != None %}
   {{ node_name }}
{%- endif %}
{% endfor %}

{%- endif %}
