sphinx:
  server:
    enabled: true
    doc:
      board:
        builder: 'html'
        source:
          engine: git
          address: 'git@repo1.domain.com/repo.git'
          revision: master