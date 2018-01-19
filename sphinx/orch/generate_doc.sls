
linux_system_doc_state:
  salt.state:
    - tgt: '*'
    - sls: linux.system.doc

salt_minion_grains:
  salt.state:
    - tgt: '*'
    - sls: salt.minion.grains
    - require:
      - salt: linux_system_doc_state

{# Mine flush/update works only when executed via salt-call #}
mine_update:
  salt.function:
    - name: cmd.shell
    - tgt: '*'
    - arg:
      - salt-call mine.flush; salt-call mine.update
    - require:
      - salt: salt_minion_grains

sphinx_state:
  salt.state:
    - tgt: 'I@sphinx:server'
    - tgt_type: compound
    - sls: sphinx
    - require:
      - salt: mine_update
