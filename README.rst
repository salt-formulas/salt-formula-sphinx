
======
Sphinx
======

Sphinx is a tool that makes it easy to create intelligent and beautiful documentation, written by Georg Brandl and licensed under the BSD license. It was originally created for the new Python documentation, and it has excellent facilities for the documentation of Python projects, but C/C++ is already supported as well, and it is planned to add special support for other languages as well.

Sample pillars
==============

Simple documentation with local source

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

Simple documentation with Git source

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

Simple documentation with reclass source

.. code-block:: yaml

    sphinx:
      server:
        enabled: true
        doc:
          board:
            builder: 'html'
            source:
              engine: reclass


Read more
=========

* http://sphinx-doc.org/tutorial.html

Documentation and Bugs
======================

To learn how to install and update salt-formulas, consult the documentation
available online at:

    http://salt-formulas.readthedocs.io/

In the unfortunate event that bugs are discovered, they should be reported to
the appropriate issue tracker. Use Github issue tracker for specific salt
formula:

    https://github.com/salt-formulas/salt-formula-sphinx/issues

For feature requests, bug reports or blueprints affecting entire ecosystem,
use Launchpad salt-formulas project:

    https://launchpad.net/salt-formulas

You can also join salt-formulas-users team and subscribe to mailing list:

    https://launchpad.net/~salt-formulas-users

Developers wishing to work on the salt-formulas projects should always base
their work on master branch and submit pull request against specific formula.

    https://github.com/salt-formulas/salt-formula-sphinx

Any questions or feedback is always welcome so feel free to join our IRC
channel:

    #salt-formulas @ irc.freenode.net
