
=====
Usage
=====

Sphinx is a tool that makes it easy to create intelligent and beautiful documentation,
written by Georg Brandl and licensed under the BSD license. It was originally created
for the new Python documentation, and it has excellent facilities for the documentation
of Python projects. The C/C++ projects are already supported as well, and it is planned
to add special support for other languages as well.

Sample pillars
==============

Sample documentation with local source:

.. code-block:: yaml

    sphinx:
      server:
        enabled: true
        doc:
          board:
            builder: 'html'
            source:
              engine: local
              path: '/path/to/sphinx/documentation'

Sample documentation with Git source:

.. code-block:: yaml

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

Sample documentation with Reclass source:

.. code-block:: yaml

    sphinx:
      server:
        enabled: true
        doc:
          board:
            builder: 'html'
            source:
              engine: reclass

Sample documentation with pillar-schema source:

.. code-block:: yaml

    sphinx:
      server:
        enabled: true
        doc:
          schemas_doc:
            author: Author
            year: Year
            version: Version
            builder: 'html'
            source:
              engine: pillar-schema

Read more
=========

* http://sphinx-doc.org/tutorial.html

Documentation and Bugs
======================

* http://salt-formulas.readthedocs.io/
   Learn how to install and update salt-formulas

* https://github.com/salt-formulas/salt-formula-sphinx/issues
   In the unfortunate event that bugs are discovered, report the issue to the
   appropriate issue tracker. Use the Github issue tracker for a specific salt
   formula

* https://launchpad.net/salt-formulas
   For feature requests, bug reports, or blueprints affecting the entire
   ecosystem, use the Launchpad salt-formulas project

* https://launchpad.net/~salt-formulas-users
   Join the salt-formulas-users team and subscribe to mailing list if required

* https://github.com/salt-formulas/salt-formula-sphinx
   Develop the salt-formulas projects in the master branch and then submit pull
   requests against a specific formula

* #salt-formulas @ irc.freenode.net
   Use this IRC channel in case of any questions or feedback which is always
   welcome

