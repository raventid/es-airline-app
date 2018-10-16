# Infrastructure
PostgreSQL as MessageBus and EventStore
Eventide toolkit as infra code foundation
Ruby with PORO as domain level codebase

# Individual component
Description of different components in the system and their roles.

# General ideas implemented
- Command and event handlers
- Command idempotence
- Specialized transaction idempotence using the reservation pattern
- Expected version concurrency protection
- Event Sourcing
- Projections
- Stores
- Entity streams
- Category streams
- Command streams
- Replying to external services
- Client library for interaction with other services
- Consumers
- Component hosting
- Connection configuration
- Dependency substitution
- Testing
- Bundler-less runtime
- Coordination and workflows between multiple services
- Use of another service's client library
- Responding to replies from an external service
- Producing materialized views from services' events
- Specialized idempotence patterns for data aggregation
- Data command streams

# Vision
- Time becomes an explicit part of the domain model. 
- Reporting databases no longer depend on complex ETL processes. 
- Service boundaries are easier to discover.


- Services & Components
- Events
- Commands
- Handlers
- Projections
- Entities
- Idempotence
- Concurrency
- Robustness and resiliency
- Providing client libraries for services
- Workflows between multiple services
- Messaging patterns like Expected Version and Reservation
- Consumers & Subscriptions
- Snapshotting State
- Hosting & Operations
- Deployment
