Data Model
==========

.. include:: _include.rst

This section serves to describe the relationships between the various
components in an |Artifact|. It seeks to present an explicit set of named
resource types and how they relate to one another.

This data model seeks to identify explicitly any implicit relationships and to
add semantic color to these. It is a work in progress and likely to be
incomplete and/or wrong.


Data Model Breakdown
--------------------

What is a Smart Contract?
`````````````````````````

This data model distinguishes between |ContractTypes| and |ContractInstances|:

.. uml::

   !include uml/macros.iuml

   object(ContractInstance) {
    + address : Address
    + network : Network
    + transactionHash : TransactionHash
    + constructorArgs : Array<Value>
    + contractType : ContractType
    + callBytecode : Bytecode
    + linkValues : Set<LinkValue>
   }

   object(ContractType) {
    + name : String
    + abi : ABI
    + compilation : Compilation
    + createBytecode : Bytecode
   }

   object(Network) {
    + name : String
    + networkId : NetworkID
   }

   object(Compilation) {
    + compiler : Compiler
    + sources : Sources
    + contractTypes: ContractTypes
   }

   object(Bytecode) {
    + bytes: Array<Byte>
    + instructions: Array<Instruction>
    + sourceMap : SourceMap
    + linkReferences : Set<LinkReference>
   }

   object(LinkValue) {
    + linkReference : LinkReference
    + value : Bytes
   }

   ContractInstance o-- "1" ContractType
   ContractInstance *-- "1" Bytecode
   ContractInstance *-- "n" LinkValue
   ContractInstance o-right- "1" Network

   ContractType *-- "1" Bytecode
   ContractType o-- "0..1" Compilation

A contract instance:

* instantiates a single contract type (``contractType``).
* is located at a particular network address (``address``, ``network``).
* was deployed via a specific transaction (``transactionHash``).
* contains runtime bytecode (``callBytecode``).
* may contain known semantic information about compile-time and run-time
  parameters (``linkValues``, ``constructorArgs``).


A contract type:

* has a name (``name``)
* specifies a public external interface (``abi``)
* contains bytecode for deployment (``createBytecode``)
* may have known compilation information (``compilation``)

Contract Bytecode
`````````````````

Bytecode is represented by an object that contains:

* An unlinked bytes array (``bytes``)
* A list of any known link references (``linkReferences``)
* Possibly a mapping to known source ranges (``sourceMap``)
* An array of instruction objects containing information derived from the bytecode and sourcemap (``instructions``)

Each link reference is represented by an object that specifies:

* The length of the link in number of bytes (``length``)
* The starting byte offsets for all corresponding gaps in the bytecode
  (``offsets``)

.. uml::

   !include uml/macros.iuml

   object(Bytecode) {
    + bytes: Array<Byte>
    + sourceMap : SourceMap
    + instructions: Array<Instruction>
    + linkReferences : Set<LinkReference>
   }

   object(LinkReference) {
    + offsets : Array<ByteOffset>
    + length : Integer
   }

   object(SourceMap) {
    + ranges : Map<ByteOffset => SourceRange>
    + sources: Sources
   }

   object(Instruction) {
    + programCounter: String
    + opcode: Integer
    + pushData: String
    + sourceRanges: String
    + meta: Object
   }

  object(Meta) {
    + cost: Integer
    + pops: Integer
    + pushes: Integer
    + dynamic: Integer
   }   

   Bytecode *-- "n" Instruction
   Instruction *-- "1" Meta
   Bytecode *-- "n" LinkReference
   Bytecode *-- "0..1" SourceMap

Contract Sourcecode
```````````````````

Sources are compiled in ordered groupings of individual source files.

Compilation outputs one or more |ContractTypes| from a given list of sources.

.. uml::

   !include uml/macros.iuml

   object(Compilation) {
    + compiler : Compiler
    + sources : Sources
    + contractTypes: ContractTypes
   }

   collection(ContractTypes) {
    + contractTypes : Set<ContractType>
   }

   object(Compiler) {
    + name : String
    + version : String
    + settings : Object
   }

   object(Source) {
    + contents : String
    + sourcePath : String
    + ast : AST
   }

   collection(Sources) {
    + sources : Map<FileIndex => Source>
   }

   Compilation *-left- "n" ContractTypes

   Compilation *-down- "1" Compiler
   Compilation *-right- "1" Sources

   Sources *-- "n" Source

Each source:

* contains human-readable code (``contents``)
* may be found on disk somewhere (``sourcePath``)
* can be parsed as an abstract syntax tree (``ast``)

Source Mapping
``````````````

As part of compilation, bytecode can reference underlying source ranges by way
of |SourceMaps|.

.. uml::

   !include uml/macros.iuml

   object(Bytecode) {
    + bytes: Array<Byte>
    + sourceMap : SourceMap
    + instructions: Array<Instruction>
    + linkReferences : Set<LinkReference>
   }

   object(Instruction) {
    + programCounter: String
    + opcode: Integer
    + pushData: String
    + sourceRanges: String
    + meta: Object
   }

  object(Meta) {
    + cost: Integer
    + pops: Integer
    + pushes: Integer
    + dynamic: Integer
   }   

   object(Source) {
    + contents : String
    + sourcePath : String
    + ast : AST
   }

   collection(Sources) {
    + sources : Map<FileIndex => Source>
   }

   object(SourceMap) {
    + ranges : Map<ByteOffset => SourceRange>
    + sources: Sources
   }

   object(SourceRange) {
    + source : Source
    + start : ByteOffset
    + length : Length
    + meta : Object
   }

   Bytecode *-- "1" SourceMap
   Bytecode *-- "n" Instruction
   Instruction *-- "1" Meta
   SourceMap o-left- "1" Sources
   SourceMap *-- "n" SourceRange
   SourceRange o-left- "1" Source

   Sources *-- "n" Source


Linking
```````

Bytecode may contain gaps to be filled in. These gaps are identified via
|LinkReferences|. Corresponding |LinkValues| are contained within
|ContractInstances|.


.. uml::

   !include uml/macros.iuml

   object(ContractInstance) {
    + address : Address
    + network : Network
    + transactionHash : TransactionHash
    + constructorArgs : Array<Value>
    + contractType : ContractType
    + callBytecode : Bytecode
    + linkValues : Set<LinkValue>
   }

   object(Bytecode) {
    + bytes: Array<Byte>
    + sourceMap : SourceMap
    + instructions: Array<Instruction>
    + linkReferences : Set<LinkReference>
   }

   object(LinkValue) {
    + linkReference : LinkReference
    + value : Bytes
   }

   object(LinkReference) {
    + offsets : Array<ByteOffset>
    + length : Integer
   }


   ContractInstance *-- "1" Bytecode
   ContractInstance *-- "n" LinkValue

   LinkReference "n" --* Bytecode

   LinkValue ..> "1" LinkReference


Combined Data Model
-------------------

.. uml::

   !include uml/macros.iuml

   object(ContractInstance) {
    + address : Address
    + network : Network
    + transactionHash : TransactionHash
    + constructorArgs : Array<Value>
    + contractType : ContractType
    + callBytecode : Bytecode
    + linkValues : Set<LinkValue>
   }

   object(ContractType) {
    + name : String
    + abi : ABI
    + compilation : Compilation
    + createBytecode : Bytecode
   }

   collection(ContractTypes) {
    + contractTypes : Set<ContractType>
   }

   object(Source) {
    + contents : String
    + sourcePath : String
    + ast : AST
   }

   collection(Sources) {
    + sources : Map<FileIndex => Source>
   }

   object(Network) {
    + name : String
    + networkId : NetworkID
   }

   object(Compilation) {
    + compiler : Compiler
    + sources : Sources
    + contractTypes: ContractTypes
   }

   object(Compiler) {
    + name : String
    + version : String
    + settings : Object
   }

   object(Bytecode) {
    + bytes: Array<Byte>
    + sourceMap : SourceMap
    + instructions: Array<Instruction>
    + linkReferences : Set<LinkReference>
   }

   object(Instruction) {
    + programCounter: String
    + opcode: Integer
    + pushData: String
    + sourceRanges: String
    + meta: Object
   }

  object(Meta) {
    + cost: Integer
    + pops: Integer
    + pushes: Integer
    + dynamic: Integer
   }   

   object(SourceMap) {
    + sourceMap : Map<ByteOffset => SourceRange>
    + sources: Sources
   }

   object(SourceRange) {
    + source : Source
    + start : ByteOffset
    + length : Length
    + meta : Object
   }

   object(LinkValue) {
    + linkReference : LinkReference
    + value : Bytes
   }

   object(LinkReference) {
    + offsets : Array<ByteOffset>
    + length : Integer
   }


   ContractInstance o-- "1" ContractType
   ContractInstance *-- "1" Bytecode
   ContractInstance *-- "n" LinkValue
   ContractInstance o-right- "1" Network

   ContractType "n" --* ContractTypes
   ContractType *-- "1" Bytecode
   ContractType o-- "0..1" Compilation

   ContractTypes "n" --* Compilation

   Compilation *-down- "1" Compiler
   Compilation *-right- "1" Sources

   Sources *-- "n" Source

   Bytecode *-- "0..1" SourceMap
   Bytecode *-- "n" Instruction
   Instruction *-- "1" Meta
   
   SourceMap o-left- "1" Sources
   SourceMap *-- "n" SourceRange
   SourceRange o-left- "1" Source

   LinkReference "n" --* Bytecode

   LinkValue ..> "1" LinkReference

Legend for Section Diagrams
---------------------------

.. uml::

   !include uml/macros.iuml

   object(A) {
   }
   object(B) {
   }
   object(D) {
   }
   collection(C) {
   }

   A *-- "0..1" B

   B o-- "n" D

   A *-- "1" C

   C *-- "n" D

   A "1" <.. D

In this example: **A**, **B**, **C**, and **D** are named resource types in
the data model.

Resources of these types are related as follows.

   * Each *[resource of type]* **A** optionally owns a single *[resource of type]* **B**

   * Each **B** refers to any whole number of **D**\ s

   * Each **A** owns a single collection **C**

   * Each **C** owns a whole number of **D**\ s

   * Each **D** relates to a single **A**

Generally, a given resource can have only one owner (or zero). Resources can
refer to objects owned by another.


