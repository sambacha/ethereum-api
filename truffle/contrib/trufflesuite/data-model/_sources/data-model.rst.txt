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

Contracts, Constructors, and Instances
```````````````````````````````````````

.. uml::

  scale 0.75

  !define SHOW_CONTRACT
  !define SHOW_INSTANCE
  !define SHOW_CONSTRUCTOR
  !define SHOW_INTERFACE

  !define SHOW_COMPILATION
  !define EXTERN_COMPILATION

  !define SHOW_BYTECODE
  !define EXTERN_BYTECODE

  !define SHOW_NETWORK
  !define EXTERN_NETWORK

  !include uml/macros.iuml

Sources, Bytecodes, and Compilations
````````````````````````````````````

.. uml::

  scale 0.75

  !define SHOW_CONTRACT
  !define EXTERN_CONTRACT

  !define SHOW_BYTECODE
  !define SHOW_SOURCE
  !define SHOW_COMPILATION
  !define SHOW_COMPILER
  !define SHOW_SOURCE_MAP

  !include uml/macros.iuml


Contract Interfaces
```````````````````

.. uml::

  scale 0.75

  !define SHOW_INTERFACE
  !define SHOW_INTERFACE_INTERNAL

  !include uml/macros.iuml


Network
```````

.. uml::

  scale 0.75

  !define SHOW_NETWORK
  !define SHOW_NETWORK_INTERNAL

  !include uml/macros.iuml


A network resource comprises a friendly name, a network ID, a known historic
block, and possibly an originating fork.

Networks that specify a ``fork`` value must specify a ``historicBlock`` whose
``height`` is larger than the fork network's historic block height.

Combined Data Model
-------------------

.. uml::

   scale 0.75

   !define SHOW_NETWORK
   !define SHOW_NETWORK_INTERNAL

   !define SHOW_BYTECODE

   !define SHOW_COMPILATION
   !define SHOW_COMPILER

   !define SHOW_SOURCE

   !define SHOW_CONTRACT
   !define SHOW_INTERFACE
   !define SHOW_INSTANCE
   !define SHOW_ABI
   !define SHOW_AST
   !define SHOW_INSTRUCTION
   !define SHOW_SOURCE_MAP
   !define SHOW_CONSTRUCTOR

   !include uml/macros.iuml
