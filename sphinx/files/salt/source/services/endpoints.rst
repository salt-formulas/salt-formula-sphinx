
=================
Service Endpoints
=================

Services endpoints within configured infrastructure.

.. list-table::
   :header-rows: 1

   *  - **Name**
      - **Type**
      - **Address**
      - **Protocol**
      - **Service**
      - **Server**
{%- for node_name, node_grains in salt['mine.get']('*', 'grains.items')|dictsort %}
{%- if node_grains.get('sphinx_doc', {}) != None %}
{%- for service_name, service in node_grains.get('sphinx', {}).get('doc', {})|dictsort %}
{%- if service.get('role', {}) != None %}
{%- for role_name, role in service.get('role', {})|dictsort %}
{%- if role.get('endpoint', {}) != None %}
{%- for endpoint_name, endpoint in role.get('endpoint', {})|dictsort %}
   *  - {{ endpoint.name|default('n/a') }}
      - {{ endpoint.type|default('n/a') }}
      - {{ endpoint.address|default('n/a') }}
      - {{ endpoint.protocol|default('n/a') }}
      - {{ service_name }}
      - :ref:`{{ node_name }}`
{%- endfor %}
{%- endif %}
{%- endfor %}
{%- endif %}
{%- endfor %}
{%- endif %}
{%- endfor %}
