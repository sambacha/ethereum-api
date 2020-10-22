Requirements
============


Use Cases Overview
------------------


The following use cases represent the kinds of interaction users may have with
Truffle and other tools. These use cases serve to help validate proposals for
changes to Truffle's artifact format.

These use cases are written primarily for Truffle, as the primary producer
and consumer of artifacts, but should apply generally for any and all
tooling for smart contract / decentralized application development.

Since the process to develop and deploy a decentralized applications can
include many participants, these use cases refer to several different user
profiles:

- Smart Contract Developer
- Frontend Developer
- Business Stakeholder
- Auditor

Not all of these users interact with development tooling directly, or in the
same ways. As such, these use cases should specify appropriately.

This list may not be exhaustive, but should cover the vast majority of required
behaviors.

Diagram Legend
``````````````

This document uses :abbr:`UML (Unified Modeling Language)` Use Case Diagrams
rendered with `PlantUML <http://plantuml.com>`_.

The following conventions are used throughout:

.. uml::

  left to right direction

  :User:

  (Use case) as (UseCase)
  (Base case) as (BaseCase)
  (Dependent use case) as (Dependent)

  User -- UseCase : << interaction >>
  UseCase ..|> BaseCase : << extends >>
  UseCase --> Dependent : << includes >>

Use cases may include others, in that in order to achieve one type of behavior,
another is required.

Use cases may extend others, indicating that one use case is a specific form
of another. Where it is not indicated, user interactions with base use cases
also imply user interaction with extensions.

Use Cases
---------

.. toctree::
   :maxdepth: 2
   :numbered:

   truffle

