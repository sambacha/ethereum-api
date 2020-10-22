.. include:: ../_include.rst

Saving new artifacts and updating existing
------------------------------------------

Users and tooling must be able to save new and update existing |Artifact|
files.

As a core behavior, tooling must facilitate the internal record-keeping of all
known |ContractTypes| and |ContractInstances|, updating them appropriately
when they change.

Beyond that, developers may also need to manually generate new artifacts for
previously unknown contracts.

Since a smart contract blockchain network is effectively a distributed global
database, developers may write their applications for the express or implicit
purpose of accessing other contract instances on that network.

Developers should be able to leverage tooling to interface with these external
contracts, including public libraries and contract instances for other
applications. Tooling should integrate well with code written outside a given
project.

Additionally, some applications may not use tooling's built-in deployment
systems, and some |ContractInstances| may deploy others. Tooling should be
able to account for the record-keeping in all these cases.

.. uml::

  left to right direction

  :Smart Contract Developer: as :SmartContractDev:

  rectangle Saving {
    (Save contract type) as (SaveType)
    (Save contract instance) as (SaveInstance)
    (Save library instance) as (SaveLibrary)
    (Save interface instance) as (SaveInterface)
  }

  SmartContractDev -- SaveType
  SmartContractDev -- SaveInstance
  SmartContractDev -- SaveLibrary
  SmartContractDev -- SaveInterface

Save contract type
``````````````````

Users must be able to save a new |ContractType|, whether or not it has any
corresponding |ContractInstances|.

Save contract instance
``````````````````````

Users must be able to save new |ContractInstances| on a given network,
identifying them as a known |ContractType|.

Save library instance
`````````````````````
Similarly, users must be able to save records of externally-deployed
|Libraries|. This is particularly useful, as many commonly-used libraries are
already deployed on a majority of |Networks|, and users should not have to pay
the extra gas just to accommodate tooling.

Save interface instance
```````````````````````

In cases where source is not known for an external contract, users may need to
reference that |ContractInstance| by its interface (i.e. via Solidity's
``interface`` mechanism).


Compiling smart contracts
-------------------------

At the core of smart contract development and deployment is the compilation
of high-level languages to the underlying EVM |Bytecode|.

Smart contract developers compile/recompile |Sources| many times throughout
the lifecycle of development.

.. uml::

  scale 0.80
  left to right direction

  :Smart Contract Developer: as :Developer:

  rectangle Saving << external >> {
    (Save contract type) as (SaveType)
  }

  rectangle Compilation {
    (Compile all project sources) as (CompileAll)

    (Determine modified sources) as (DetermineModified)
    (Compile modified project sources) as (CompileModified)
    CompileModified -> DetermineModified

    (Compile source file) as (Compile)
    Compile -> SaveType

    (Compile primary and related source files) as (CompileMultiple)
    CompileMultiple .|> Compile

    CompileAll --> Compile
    CompileModified --> Compile
  }

  Developer -- CompileAll
  Developer -- CompileModified

Compile all project sources
```````````````````````````

Either as part of the first development iteration, or to reset, developers must
be able to compile all |Source| files in a |Project| and obtain saved
|Artifacts|.

Compile modified project sources
````````````````````````````````

For most of development, it's more commonly useful to compile only |Source|
files that have changed. Users should be able to perform this minimal
compilation.

Determine modified sources
``````````````````````````

To support compilation of changed |Sources|, tooling should provide a means to
identify which files have changed since their last compilation.

Compile source file
```````````````````

Tooling must provide a means to compile a single, standalone |Source| file
(no imports), saving a corresponding |Artifact| for the |ContractType|.

Compile primary and related source files
````````````````````````````````````````

Tooling must provide a means to compile a single |Source| file and all sources
it imports, recursively.


Reading contract metadata
-------------------------

Developers, auditors, business stakeholders, et al., all often need to access
metadata information about both |ContractTypes| and |ContractInstances|.

For example, stakeholders often need to view the JSON ABI, auditors need source
and compiler information, developers need to maintain records of source file
relations and deployment statuses, etc.

Beyond direct access of contract metadata, many other use cases rely on this
metadata heavily.

Metadata should be accessible both for current versions and for all historical
versions that may be in use.

.. uml::

  scale 0.60
  left to right direction

  :Smart Contract Developer: as :SmartContractDev:

  rectangle Metadata {
    (Read contract instance info) as (ReadContractInstance)
    (Read contract type info) as (ReadContractType)
    (Read historical contract instance type info) as (ReadHistoricalInstanceType)

    (Read instance) as (ReadInstanceData)
    (Read type) as (ReadTypeData)

    ReadInstanceData <|.up. ReadContractInstance
    ReadTypeData <|.up.. ReadContractType
    ReadTypeData <|.up.. ReadHistoricalInstanceType

    ' both
    (Read name) as (ReadName)
    (Read ABI) as (ReadABI)
    (Read bytecodes) as (ReadBytecodes)
    (Read source mappings) as (ReadSourceMaps)
    (Read link values) as (ReadLinkVals)
    (Read sources) as (ReadSources)
    (Read ASTs) as (ReadASTs)

    ' instance
    (Read link references) as (ReadLinkRefs)
    (Read address) as (ReadAddress)

    ReadTypeData --> ReadName
    ReadTypeData --> ReadABI
    ReadTypeData --> ReadBytecodes
    ReadTypeData --> ReadSourceMaps
    ReadTypeData --> ReadLinkRefs
    ReadTypeData --> ReadSources
    ReadTypeData --> ReadASTs

    ReadInstanceData --> ReadTypeData
    ReadInstanceData --> ReadLinkVals
    ReadInstanceData --> ReadAddress
  }

  SmartContractDev -- ReadContractInstance
  SmartContractDev -- ReadContractType
  SmartContractDev -- ReadHistoricalInstanceType

Read contract instance information
``````````````````````````````````

Users must be able to read |ContractInstance| metadata, including ABI, any
link values, and all type-level metadata for that instance.

Read contract type info
```````````````````````

Users must be able to read metadata about a |ContractType| that has not been
deployed, as well as type-level metadata for a given |ContractInstance|.

Read contract instance historical type info
````````````````````````````````````````````

If the |ContractInstance| has a type that is no longer the current version
in source, users should still be able to read that |ContractType| information,
for the type at deploy-time. This may differ from the current type version
arbitrarily: different source, different ABI, etc.


Querying for specific contracts
-------------------------------

Developers must be able to view all known |ContractInstances| on a given
network, or a list of networks with known instances of a given |ContractType|.


.. uml::

  left to right direction
  :Smart Contract Developer: as :Developer:

  rectangle Querying {
    (Query known instances on a given network) as (QueryNetwork)
    (Query all networks for a given type) as (QueryType)
    (Query all networks for instances with a given role) as (QueryInstance)
    (Query for instance by network and address) as (QueryAddress)
    (Query all contracts with a given bytecode) as (QueryBytecode)
    (Query for bytecode ignoring link references) as (QueryBytecodeUnlinked)

    QueryInstance .|> QueryType
    QueryBytecodeUnlinked .|> QueryBytecode
  }

  Developer -- QueryNetwork
  Developer -- QueryType
  Developer -- QueryInstance
  Developer -- QueryAddress
  Developer -- QueryBytecode


Query for instance by network and address
`````````````````````````````````````````

Users must be able to look up known |ContractInstances| given a |Network|
and an |Address|.

Query all contracts with a given bytecode
`````````````````````````````````````````

Because it is immutable, contract |Bytecode| serves as a reliable secondary
index for both |ContractInstances| and |ContractTypes|. Users should be able to
find all known |Contracts| based on the raw hexadecimal representation of
EVM machine code.

Query for bytecode ignoring link references
```````````````````````````````````````````

Two sets of contract |Bytecode| can differ only by |LinkValues|. Users should
be able to query for all |ContractTypes| and |ContractInstances| matching
a given bytecode, whether or not the |LinkReferences| have values or match.

Query known instances on a given network
````````````````````````````````````````

Users should be able to see, at a glance, all |ContractInstances| on a given
|Network|. This can be useful for validating migration state, or for easy
listing of address / ABI information, to present/share externally.

Query all networks for a given type
```````````````````````````````````

Developers often write applications so that each |ContractType| has a singleton
deployed |ContractInstance|. Tooling should enable this first-class nature of
contract types, and users should be able to track the various instances across
all known |Networks|.

This is particularly useful when creating front-end applications, referencing
instances across networks with a single type description.

Query all networks for instances with a given role
``````````````````````````````````````````````````

In cases where a particular |ContractType| is not deployed as a singleton,
tooling should provide a mechanism by which users can deploy multiple
|ContractInstances|, identified in some way distinct from type (i.e., *role*)

As a result, users should be able to use this distinct identifier to query
for analogous instances across |Networks|, instead of relying solely on the
type.

Interacting with deployed instances
-----------------------------------

Besides metadata information, users must be able to retrieve runtime state
information about |ContractInstances| and to be able to write to those
instances over the network.


.. uml::

  left to right direction

  :User: as :User:

  rectangle Metadata << external >> {
    (Read ABI) as (ReadABI)
    (Read instance) as (ReadInstance)
    (ReadInstance) -> ReadABI
  }

  rectangle Interaction {
    (Call read-only method) as (Call)
    (Invoke method via a transaction) as (SendTransaction)
    (Send ETH to a contract instance) as (Send)

    Call --> ReadInstance
    SendTransaction --> ReadInstance
  }

  User -- Call
  User -- SendTransaction
  User -- Send

Call read-only method
`````````````````````

Almost every smart contract provides mechanisms for viewing information
about a |ContractInstance|'s current state, including public storage variables
and computed data views. These interfaces are specified for each instance's
|ContractType|, and described in its |ABI|.

Users must be able to call these read-only methods and obtain their results.

Invoke method via a transaction
```````````````````````````````

Similarly to calls, most contracts provide interface methods for modifying
|ContractInstance| state. Users must be able to execute the allowable
"write" operations for a contract instance.

Send ETH to a contract instance
```````````````````````````````

Many smart contracts expose methods for receiving payment in the form of ether
or other tokens.

Developers must be able to test the receipt of ether; business stakeholders may
have to provide initial funds for applications that require it.


Linking contracts to libraries
------------------------------

Smart contract development best practices encourage the separation of code
into multiple discrete components. As such, developers may write contracts that
leverage the use of |Libraries| to provide composed behavior.

|Contracts| using libraries are compiled with unresolved |LinkReferences|.
Libraries are deployed as their own instances and later filled in for the
|ContractType| as a corresponding |LinkValue|.

.. uml::

  left to right direction

  :Smart Contract Developer: as :Developer:

  rectangle Saving << external >> {
    (Save contract type) as (SaveType)
    (Save contract instance) as (SaveInstance)
  }

  rectangle Linking {
    (Link contract type to library) as (LinkType)
    (Link contract instance to library) as (LinkInstance)
    LinkInstance .left.|> LinkType

    LinkType --> SaveType
    LinkInstance --> SaveInstance
  }

  Developer -- LinkType
  Developer -- LinkInstance

Link contract type to library instance
``````````````````````````````````````

Developers must be able to link |ContractTypes| to corresponding |Libraries|
on a particular |Network| or for all networks, so that deployments of that
type are pre-linked.

Link contract instance to library instance
``````````````````````````````````````````

In cases where a |ContractInstance| is already deployed, but the
|LinkReference| for any |Library| is not known, developers should be able to
save the |LinkValue|.


Deploying new instances
-----------------------

During and after the process of creating smart contracts, smart contract
developers need to deploy |ContractTypes| on one or more |Networks|, creating
one or more |ContractInstances|.

.. uml::

  left to right direction

  :Smart Contract Developer: as :Developer:

  rectangle Saving << external >> {
    (Save contract instance) as (SaveInstance)
  }

  rectangle Deployment {
    (Deploy instance of a type) as (DeployInstance)
    (Deploy multiple instances) as (MultipleInstances)
    MultipleInstances .|> DeployInstance
    DeployInstance --> SaveInstance
  }

  Developer -- DeployInstance
  Developer -- MultipleInstances

Deploy instance of a type
`````````````````````````

The base case for deployment: given a |ContractType|, users must be able to
deploy a new |ContractInstance| on a particular |Network|.

Deploy multiple instances
`````````````````````````

For applications that require multiple |ContractInstances| per |ContractType|,
users should be able to deploy instances by role or other identifier.


Migrations
----------

Smart contract developers should be able to track the states of
different |Networks| separately. |ContractInstances| on different
networks can be of different versions of the same |ContractType|. This
difference should be understood by the underlying tooling, and easy to
reason about for the user of the tool.

.. uml::

  scale 0.55
  left to right direction

  :Smart Contract Developer: as :Developer:

  rectangle Querying << external >> {
    (Query for a given type) as (QueryType)
  }

  rectangle Interacting << external >> {
    (Call read-only method) as (Call)
  }

  rectangle Linking << external >> {
    (Link contract type to library) as (LinkType)
  }

  rectangle Deployment << external >> {
    (Deploy instance of a type) as (DeployInstance)
  }

  rectangle Migrations {
    (Run all migrations) as (RunMigrations)
    (Run specific migration) as (RunSpecific)
    (Run as historical) as (RunHistorical)
    (Determine last completed migration) as (DetermineLastCompleted)


    RunHistorical ..|> RunMigrations

    RunMigrations -right-> RunSpecific
    RunMigrations -left-> DetermineLastCompleted

    DetermineLastCompleted -down-> QueryType : find deployed Migrations
    DetermineLastCompleted -down-> Call : read instance state
    RunSpecific -down-> DeployInstance
    RunSpecific -down-> LinkType


  }

  Developer -- RunMigrations
  Developer -- RunSpecific
  Developer -- RunHistorical
  Developer -- DetermineLastCompleted


Determine last completed migration
``````````````````````````````````

Querying and reading the on-chain |ContractInstance| for the ``Migrations``
contract, users should be able to determine the most recently completed
migration on that |Network|.

Run all migrations
``````````````````

Either starting at the last completed migration, or resetting from the
beginning, users should be able to run all migrations for a |Project| on
a particular |Network|.


Run specific migration
``````````````````````

As part of the larger use case of running all migrations, or as a standalone
operation. Users and tooling must support running a single migration.


Run with historical types
``````````````````````````

Specifying parent network, users should be able to mimic the state of a given
network, determining |ContractTypes| for all known |ContractInstances|, and
deploy new instances matching those types instead of current.


Testing smart contracts
-----------------------

Being able to validate that smart contracts behave as expected is of paramount
importance.

Development workflow best practices involve writing/running automated tests
early and often in the process. Developers should be able to test their
contracts locally before deployment, and once deployed, be able to test their
contract instances locally, matching expected behavior on the network itself.

.. uml::

  scale 0.65
  left to right direction

  :Smart Contract Developer: as :Developer:


  rectangle Compilation << external >> {
    (Compile all project sources) as (CompileAll)
  }

  rectangle Migrations << external >> {
    (Run all migrations) as (RunMigrations)
    (Run as historical) as (RunHistorical)
    RunHistorical .|> RunMigrations
  }

  rectangle Testing {
    (Run automated tests for contract type) as (TestType)
    (Run automated tests for contract instance) as (TestInstance)
    (Run automated tests for library type) as (TestLibrary)
    (Run automated tests for library instance) as (TestLibraryInstance)

    TestInstance --> RunHistorical
    TestLibraryInstance --> RunHistorical

    (Run test written in Solidity) as (RunSolidity)
    RunSolidity --> CompileAll
    RunSolidity --> RunMigrations

    (Run test written in Javascript) as (RunJavascript)
    RunJavascript --> CompileAll
    RunJavascript --> RunMigrations

    TestType --> RunSolidity
    TestType --> RunJavascript

    TestInstance --> RunSolidity
    TestInstance --> RunJavascript

    TestLibrary --> RunSolidity
    TestLibraryInstance --> RunSolidity
  }

  Developer -- TestType
  Developer -- TestInstance
  Developer -- TestLibrary
  Developer -- TestLibraryInstance


Run automated tests for contract type
`````````````````````````````````````

Users must be able to run the full test suite for a given |ContractType|,
written in either Solidity or Javascript, starting fresh on a given |Network|
and running all compilation/migration steps in the process.

Run automated tests for contract instance
`````````````````````````````````````````

Some tests may be written for a specific |ContractInstance| to account for
historical differences between that instance and the current
|Source| for the corresponding |ContractType|.

Users should be able run tests on a fresh local |Network|, reflecting that
historical version.

Run automated tests for library type
````````````````````````````````````

In order to validate a particular |Library|, users should be able to run
tests in a fresh local |Network| environment, with given library deployed.

Run automated tests for library instance
````````````````````````````````````````

Much like running automated tests for a |ContractInstance|, users should be
able to validate behavior for outdated instances of a given |Library|.
