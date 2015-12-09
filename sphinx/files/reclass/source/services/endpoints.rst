
=================
Service Endpoints
=================

Services endpoints within configured infrastructure.

.. list-table::
   :header-rows: 1

   *  - **Type**
      - **Address**
      - **Protocol**
      - **Service**
      - **Server**
{%- for node_name, node_grains in salt['mine.get']('*', 'grains.items').iteritems() %}
{%- if node_grains.get('sphinx_doc', {}) != None %}
{%- for service_name, service in node_grains.get('sphinx', {}).get('doc', {}).iteritems() %}
{%- if service.get('role', {}) != None %}
{%- for role_name, role in service.get('role', {}).iteritems() %}
{%- if role.get('endpoint', {}) != None %}
{%- for endpoint_name, endpoint in role.get('endpoint', {}).iteritems() %}
   *  - {{ endpoint.type }}
      - {{ endpoint.address }}
      - {{ endpoint.protocol }}
      - {{ service_name }}
      - :ref:`{{ node_name }}`
{%- endfor %}
{%- endif %}
{%- endfor %}
{%- endif %}
{%- endfor %}
{%- endif %}
{%- endfor %}
