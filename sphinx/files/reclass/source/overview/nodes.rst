
===============================
Infrastructure Nodes
===============================

Definition of all nodes within current infrastructure.

.. list-table::
   :header-rows: 1

   *  - **Node FQDN**
      - **IP Addresses**
      - **Assigned Services**
{%- for node_name, node_grains in salt['mine.get']('*', 'grains.items').iteritems() %}
   *  - {{ node_name }}
{%- if node_grains.sphinx_doc is defined %}
      - {{ node_grains.ipv4 }}
      - {% for service_name, service in node_grains.sphinx_doc.iteritems() %}{% for role_name, role in service.role.iteritems() %}{{ service_name }}-{{ role_name }} {% endfor %}{% endfor %}
{%- else %}
      - N/A
      - N/A
{%- endif %}
{%- endfor %}

.. toctree::
   :maxdepth: 2

   overview/endpoints
   overview/nodes
   overview/services
   {%- for node_name, node_grains in salt['mine.get']('*', 'grains.items').iteritems() %}
   {%- if node_grains.get('sphinx_doc', {}) != None %}
   nodes/{{ node_name }}
   {%- endif %}
   {%- endfor %}
