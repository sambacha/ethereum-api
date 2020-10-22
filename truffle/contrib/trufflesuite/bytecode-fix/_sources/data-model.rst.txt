Data Model
==========

.. include:: _include.rst

This section serves to describe the relationships between the various
components in an |Artifact|. It seeks to present an explicit set of named
resource types and how they relate to one another.

This data model seeks to identify explicitly any implicit relationships and to
add semantic color to these. It is a work in progress and likely to be
incomplete and/or wrong.

Name referenced resources
-------------------------

Certain resources are *named*, meaning that these entities may be referenced
by user-defined semantic identifiers. Since Truffle targets the full dev.
lifecycle, this means names refer to different things at different times.

|Contracts| and |Networks|, for example, both use names. These resources
represent entities that change over time. Contracts are written, rewritten,
and/or updated many times between a project's start and past its production
deployment. Development networks reset, and public networks fork.

To represent these entities across the entire project lifecycle, Truffle DB
models names as a linked list of references to immutable entities.

Each named resource contains the non-nullable string attribute ``name`` and the
nullable attribute ``role``, any serializable object. The pair
(``name``, ``role``) **together** represent the full semantic name.

.. uml::

  !include uml/macros.iuml

  interface(Named) {
    + name: String
    + role: Maybe<Object>
  }

**Name<T>** can be considered generically to represent a linked list of
current and past resource name references for a given resource type ``T``.
Each Name<T> has the same ``name`` and ``role`` attributes, plus the following:
  - ``type`` to represent the underlying named resource type
  - ``ref`` to point to the underlying entity
  - ``previous`` to point to the previous name
Further, Name<T> records are stored statically by ``current`` values.

.. uml::

  !include uml/macros.iuml

  class Name< T: Resource > << (R,orchid) Resource >> {
    + <u>current</u> (\n\ttype: String,\n\tname: String,\n\trole: Maybe<Object>\n):\n\tMaybe<Name<T>>
    --
    + type: String
    + name: String
    + role: Maybe<Object>
    + {method} ref: T
    + previous: Maybe<Name<T>>
    ..
    - refId: ID
  }

  interface(Named) {
    + name: String
    + role: Maybe<Object>
  }

  class T << (R,motivation) Resource >> {
    + name: String
    + role: Maybe<Object>
    ..
    - <&key> id: ID
  }

  Name o-- "1" T
  Name o-- "0..1" Name

  T .right.|> Named : << implements >>






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
