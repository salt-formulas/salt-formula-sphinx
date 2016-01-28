linux_system_doc_state:
  salt.state:
    - tgt: '*'
    - sls: linux.system.doc

salt_minion_state:
  salt.state:
    - tgt: '*'
    - sls: salt.minion

mine_flush:
  salt.function:
    - name: cmd.run
    - tgt: '*'
    - arg:
      - salt-call mine.flush

mine_update:
  salt.function:
    - name: cmd.run
    - tgt: '*'
    - arg:
      - salt-call mine.update

sphinx_state:
  salt.state:
    - tgt: 'G@roles:sphinx.server'
    - tgt_type: compound
    - sls: sphinx

