
linux_system_doc_state:
  salt.state:
    - tgt: '*'
    - sls: linux.system.doc

salt_minion_grains:
  salt.state:
    - tgt: '*'
    - sls: salt.minion.grains

mine_flush:
  salt.function:
    - name: mine.flush
    - tgt: '*'

mine_update:
  salt.function:
    - name: mine.update
    - tgt: '*'

sphinx_state:
  salt.state:
    - tgt: 'G@roles:sphinx.server'
    - tgt_type: compound
    - sls: sphinx
