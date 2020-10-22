Truffle DB - Proposal
~~~~~~~~~~~~~~~~~~~~~

This document serves to aid in discussion towards the goal of improving
Truffle's record-keeping of smart contracts. More specifically, this document
presents a proposal for a new core component to manage a Truffle project's
persisted artifact files and to enable intuitive and robust querying thereof.

The primary goals for this component are:

0. Don't lose any relevant data about a project's smart contracts or their
   deployed instances.

1. Provide a flexible interface for reading and writing persisted information
   about smart contracts.

2. Maintain backwards compatibility with Truffle's existing record-keeping.

At its core, **Truffle DB** seeks to provide a `GraphQL <https://graphql.org>`_
interface for accessing project smart contract information.

.. toctree::
   :maxdepth: 2
   :caption: Contents:

   background
   glossary
   use-cases
   data-model
   design


Indices and tables
~~~~~~~~~~~~~~~~~~

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`
