Glossary
========

.. include:: _include.rst

.. glossary::

   ABI
      A JSON description of the external interface for a |ContractInstance|,
      or for the description of common interface of all instances of a
      |ContractType|

   Address
      0x-prefixed hexadecimal string representing an account's public
      identifier

   Artifact
      A JSON file describing a single :term:`Contract`.

   AST
      Abstract syntax tree. A representation of a particular |Source| as a
      deeply-nested JSON object.

   Bytecode
      0x-prefixed hexadecimal string representing EVM-compatible operation
      instruction data.

      May contain unresolved |LinkReferences|.

   Compiler
      A description of the compiler name, version, and any and all settings,
      to compile high-level |Source| code to EVM |Bytecode|.

   Contract
      An abstract entity, representing a single |ContractType| or
      |ContractInstance|.

   Contract Instance
      A contract account with its own address, storage, and balance,
      representing a single deployment of a particular |ContractType|.

   Contract Type
      Refers to a specific contract or library, able to deployed to a particular
      |Network|

   Contracts Directory
      By default this is ``build/contracts/`` in the |Project| directory

      Contains |Artifacts| for all of the project's known |ContractTypes|.

   Library
      A |ContractInstance| with composable behavior, for use by other contract
      instances via the EVM's ``DELEGATECALL`` mechanism.

   Link Reference
      A placeholder representing a runtime or |Network|-specific value, at
      a particular byte offset or offsets. Identified by name.

      Filled in by corresponding |LinkValue| by Truffle.

   Link Value
      The value used to replace |LinkReference| placeholders.

   Network
      A particular Ethereum or Ethereum-flavored blockchain network, supporting
      the EVM. Examples include: ``mainnet``, ``rinkeby``, and local
      Ganache [#]_ instances.

   Network Directory
      A directory containing |Artifacts| for a particular |Network|.

      ``build/networks/<network-name>/`` by default in the |Project| directory.

   Snapshot
      An immutable collection of data representing the result of a single
      compilation and/or a single deployment.

   Source
      High-level language code text, usually for a particular file on disk.

   Source Map
      Data describing how to translate |Bytecode| instructions into sections
      of |Source| files.

   Project
      A Truffle project.

Notes
-----

.. [#] `Ganache <http://truffleframework.com/ganache/>`_ is a personal blockchain for Ethereum development
