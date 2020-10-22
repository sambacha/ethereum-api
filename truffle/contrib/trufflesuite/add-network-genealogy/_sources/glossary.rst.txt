Glossary
========

.. include:: _include.rst

.. glossary::

   ABI
      A JSON description of the external interface for a |ContractInstance|,
      or for the description of a common interface of all instances of a
      |Contract|

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

   Compilation
      A description of the data generated when a contract is compiled. Includes |Compiler|
      information as well as any |Source|, |SourceMap| and |Contract| information used to generate an artifact for a contract.

   Compiler
      A description of the compiler name, version, and any and all settings,
      to compile high-level |Source| code to EVM |Bytecode|.

   Constructor
      Contains the bytecode needed to create the associated |ContractInstance|.

   Contract
      An abstract entity, representing a single
      |ContractInstance|.

   Contract Interface
      Refers to the collection of methods through which one may interact with a contract.

   Contract Instance
      A contract account with its own address, storage, and balance,
      representing a single deployment of a particular |Contract|.

   Contract Instance Creation
      Represents the data needed to recreate a contract instance, comprised of the :term:`TransactionHash` that points to the transaction that created the related |ContractInstance| as well as the `ConstructorArgs`, which are the parameters passed to the constructor, used for creating the Contract Instance.

   Contracts Directory
      By default this is ``build/contracts/`` in the |Project| directory

      Contains |Artifacts| for all of the project's known |Contracts|.

   Instruction
      Detailed information regarding how the Ethereum Virtual Machine should handle the associated |Bytecode|

   Library
      A |ContractInstance| with composable behavior, for use by other contract
      instances via the EVM's ``DELEGATECALL`` mechanism.

   Linked Bytecode
      |Bytecode|, with reference to any |LinkValues| referred to within that bytecode.

   Link Reference
      A placeholder representing a runtime or |Network|-specific value, at
      a particular byte offset or offsets. Identified by name.

      Filled in with corresponding |LinkValue| by Truffle.

   Link Value
      The value used to replace |LinkReference| placeholders.

   Name Record
      Represents a linked list of current and past resource name references for a given resource type. Each Name has ``name`` and ``role`` attributes, as well as a ``type`` to represent its underlying resource type, a ``reference`` to point to the entity it represents, and
      ``previous`` to point to the previous name.

   Network
      A particular Ethereum or Ethereum-flavored blockchain network, supporting
      the EVM. Examples include: ``mainnet``, ``rinkeby``, and local
      Ganache [#]_ instances.

   Network Directory
      A directory containing |Artifacts| for a particular |Network|.

      ``build/networks/<network-name>/`` by default in the |Project| directory.

   Project
      A resource that serves as the aggregation point for the heads of linked lists of |NameRecords|

   Processed Source
      Output from the compiler about a particular |Source|, including list
      of represented |Contracts| and optional |AST| information.

   Snapshot
      An immutable collection of data representing the result of a single
      compilation and/or a single deployment.

   Source
      High-level language code text, usually for a particular file on disk.

   Source Map
      Data describing how to translate |Bytecode| instructions into sections
      of |Source| files.

   Source Range
      Contains the instructions for accessing a source's |Bytecode|.

   Transaction Hash
      An identifier that uniquely identifies a blockchain transaction.

Notes
-----

.. [#] `Ganache <http://truffleframework.com/ganache/>`_ is a personal blockchain for Ethereum development
