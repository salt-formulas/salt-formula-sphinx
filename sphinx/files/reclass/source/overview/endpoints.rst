
===============================
Service Endpoints
===============================

Services exposed within configured infrastructure.

.. list-table::
   :header-rows: 1

   *  - **Type**
      - **Address**
      - **Protocol**
      - **Service**
{%- for node_name, node_grains in salt['mine.get']('*', 'grains.items').iteritems() %}
{%- for service_name, service in node_grains.get('sphinx_doc', {}).iteritems() %}
{%- for role_name, role in service.role.iteritems() %}
{%- for endpoint_name, endpoint in role.get('endpoint', {}).iteritems() %}
   *  - {{ endpoint.type }}
      - {{ endpoint.address }}
      - {{ endpoint.protocol }}
      - {{ service_name }}
{%- endfor %}
{%- endfor %}
{%- endfor %}
{%- endfor %}

