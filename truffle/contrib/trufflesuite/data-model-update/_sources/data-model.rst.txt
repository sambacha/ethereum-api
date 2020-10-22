Data Model
==========

.. include:: _include.rst

This section serves to describe the relationships between the various
components in an |Artifact|. It seeks to present an explicit set of named
resource types and how they relate to one another.

This data model seeks to identify explicitly any implicit relationships and to
add semantic color to these. It is a work in progress and likely to be
incomplete and/or wrong.

Projects and Named Resources
----------------------------

Certain resources are *named*, meaning that these entities may be referenced
by user-defined semantic identifiers. Since Truffle targets the full development
lifecycle, this means names refer to different things at different times.

|Contracts| and |Networks|, for example, both use names. These resources
represent entities that change over time. Contracts are written, rewritten,
and/or updated many times between a project's start and past its production
deployment. Development networks reset, and public networks fork.

To represent these entities across the entire project lifecycle, Truffle DB
models names as a linked list of references to immutable entities.

Each Named resource contains the non-nullable string attribute ``name``, used
to index by type.

**NameRecord** can be considered generically to represent a linked list of
current and past resource name references for a given resource type ``T``.
Each NameRecord has the same ``name``, plus the following:
  - ``type`` to represent the underlying named resource type
  - ``resource`` to point to the underlying resource
  - ``previous`` to point to the previous name

In order to track the current NameRecords for a given type, the **Project**
resource serves as the aggregation point for the heads of these linked lists.

.. uml::

  !define SHOW_PROJECT
  !define SHOW_NAME_RECORD
  !define SHOW_NAME_RECORD_INTERNAL

  !include uml/macros.iuml


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
  !define SHOW_SOURCE_MAP

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
Contract Interfaces have not been implemented in the first version of Truffle DB, but will be added in a future iteration.

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

   !define SHOW_PROJECT
   !define SHOW_NAME_RECORD
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
   !define SHOW_SOURCE_RANGE
   !define SHOW_CONSTRUCTOR

   !include uml/macros.iuml
