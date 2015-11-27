============================
Reclass-driven Documentation
============================

Model-driven infrastructure documentation of salt-based system deployment.

.. toctree::
   :maxdepth: 2

   overview/endpoints
   overview/nodes
   overview/services
   {%- for node_name, node_grains in salt['mine.get']('*', 'grains.items').iteritems() %}
   nodes/{{ node_name }}
   {%- endfor %}

