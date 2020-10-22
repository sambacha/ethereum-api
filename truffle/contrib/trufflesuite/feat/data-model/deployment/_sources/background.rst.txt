Background
==========

What are "Artifacts"?
---------------------

Currently, Truffle artifacts are stored as JSON files in a project's
``build/contracts/`` directory.

Artifact files follow a formally-specified JSON-Schema [#jsonschema]_,
available in the `trufflesuite/truffle-contract-schema <https://github.com/trufflesuite/truffle-contract-schema>`_
repository. This schema's latest version is v3.0.1.


.. [#jsonschema] `JSON Schema <http://json-schema.org>`_ is a vocabulary that
   allows you to annotate and validate JSON documents.


Truffle's Architecture
----------------------

For background, there are a number of relevant existing components.

Truffle Artifactor
``````````````````

Provided by the **truffle-artifactor** package.

The artifactor saves contract abstractions to disk. Specifically, this writes
to the configured ``contracts_build_directory``.

.. uml::

   component Artifactor

   frame "interface" as ArtifactorInterface {
      () "save(abstraction)" as Save
      () "saveAll(abstractions)" as SaveAll
   }

   Artifactor -up- Save
   Artifactor -up- SaveAll


Truffle Resolver
````````````````

Provided by the **truffle-resolver** package.

The resolver queries the artifacts, either resolving a contract name
(or, deprecated: a source filename) to the corresponding artifact file, and/or
instantiating a contract abstraction from the artifact automatically.

.. uml::

   component Resolver

   frame "interface" as ResolverInterface {
      () "require(contractName, searchPath?)" as Require
      () "resolve(contractName, importedFrom?)" as Resolve
   }


   Resolver -up- Require
   Resolver -up- Resolve

Truffle Config
``````````````

Provided by the **truffle-config** package.

Within the context of Truffle, ``config`` objects are used as a singleton
object that serves all parts of Truffle with context about the user's project.

Currently, a Truffle ``config`` object contains a reference to an artifactor
and a resolver.

.. uml::

   skinparam nodesep 50

   component Config
   () Artifactor
   () Resolver

   ' positioning
   Artifactor -[hidden]right-> Resolver

   note as N1
      these refer to ""interface""s above
   end note

   Resolver .right. N1

   Config .down. Artifactor
   Config .down. Resolver

   component "Artifactor" as BaseArtifactor
   component "Resolver" as BaseResolver

   BaseArtifactor -up- Artifactor
   BaseResolver -up- Resolver
