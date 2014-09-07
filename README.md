
# Sphinx

Sphinx is a tool that makes it easy to create intelligent and beautiful documentation, written by Georg Brandl and licensed under the BSD license.

It was originally created for the new Python documentation, and it has excellent facilities for the documentation of Python projects, but C/C++ is already supported as well, and it is planned to add special support for other languages as well.

## Sample pillars

Simple documentation with local source

    sphinx:
      server:
        enabled: true
        doc:
          board:
            builder: 'html'
            source: 
              engine: local
              path: '/path/to/sphinx/documentation'

Simple documentation with Git source

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

## Read more

* http://sphinx-doc.org/tutorial.html