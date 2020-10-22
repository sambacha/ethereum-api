Data Model
==========

.. include:: _include.rst

This section serves to describe the relationships between the various
components in an |Artifact|. It seeks to present an explicit set of named
resource types and how they relate to one another.

This data model seeks to identify explicitly any implicit relationships and to
add semantic color to these. It is a work in progress and likely to be
incomplete and/or wrong.


Data Model Resources
--------------------

Bytecode
````````

.. uml::

   !define SHOW_BYTECODE
   !include uml/macros.iuml

Source
``````

.. uml::

  !define SHOW_SOURCE
  !include uml/macros.iuml


Contract
````````

.. uml::

  !define SHOW_CONTRACT
  !include uml/macros.iuml

Compilation
```````````

.. uml::

  !define SHOW_COMPILATION
  !include uml/macros.iuml

Source Map
``````````

.. uml::

  !define SHOW_SOURCE_MAP
  !include uml/macros.iuml

Contract Instance
`````````````````

.. uml::

  !define SHOW_INSTANCE
  !include uml/macros.iuml

Contract Interface
``````````````````

.. uml::

  !define SHOW_INTERFACE
  !include uml/macros.iuml

Contract Constructor
````````````````````

.. uml::

  !define SHOW_CONSTRUCTOR
  !include uml/macros.iuml

Network
```````

.. uml::

  !define SHOW_NETWORK
  !include uml/macros.iuml


A network resource comprises a friendly name, a network ID, a known historic
block, and possibly an originating fork.

Networks that specify a ``fork`` value must specify a ``historicBlock`` whose
``height`` is larger than the fork network's historic block height.

Combined Data Model
-------------------

.. uml::

   !define SHOW_NETWORK
   !define SHOW_BYTECODE
   !define SHOW_COMPILATION
   !define SHOW_SOURCE
   !define SHOW_CONTRACT
   !define SHOW_INSTANCE
   !define SHOW_TYPE
   !define SHOW_ABI

   !define SHOW_AST
   !define SHOW_INSTRUCTION
   !define SHOW_SOURCE_MAP
   !define SHOW_CONSTRUCTOR

   !include uml/macros.iuml
