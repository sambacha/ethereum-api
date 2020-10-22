.. include:: ../_include.rst

Adding Data
------------


.. uml::

  left to right direction

  :Artifactor:

  rectangle Add {
    (Add sources) as (SourcesAdd)
    (Add bytecodes) as (BytecodesAdd)
    (Add networks) as (NetworksAdd)
    (Add contract types) as (ContractTypesAdd)
    (Add contract instances) as (ContractInstancesAdd)
    (Add compilations) as (CompilationsAdd)

    (Map bytecode to sources) as (BytecodesMap)
  }


  Artifactor -- SourcesAdd
  Artifactor -- BytecodesAdd
  Artifactor -- NetworksAdd
  Artifactor -- ContractTypesAdd
  Artifactor -- ContractInstancesAdd
  Artifactor -- CompilationsAdd
