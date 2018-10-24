# Questions

### Group of questions number 1. General architecture.

- What if component `HiddenFare` can publish `BetterPrice` message only after it receives two different messages, from two different components? Because it needs to calculate something based on those messages payload?

- How to horizontaly scale such services?

- What if I cannot get enough information from message payload and I have to read this information from (from what place?)? From database? From in memory storage? Or it is forbidden?

- What actually event-store gives, that Postgresql cannot. I guess it just works a bit faster for heavy load and takes care for exactly-once processing guaranty?

- I think that Eventide exposes too many weird approaches to client of code? Or not? Can I just use dry-stack and do not care about what is eventide internals look like?

- I have a legacy MongoDB-based snapshots with (kinda event-sourced) data (booking!), how can I build my system, so it will support this legacy approach to get read data?

- Where is the read and the write models in Eventide. Or they abstracted away with different approaches?

- Where to store and how to organize structures (entities)? Like how should we organize booking?
It might be a bunch of separate components. What about aggregates. Should we tailor our aggregates
for specific views? Aggregate for client response? Aggregate for invoice?

- How to debug such code? How to trace and log the execution? (Logging is solved problem, because we can log events, and if we dislike the way our information is logged we can transform it with events)

- What if we separate services which has to send data to external services from services wich make computations. All GDS do external requests, what to do?

- How to coordinate consistently coordinate two services? (Relates to first question). Like I need invoice confirmation and sms-gateway confirmation. If we get invoice, but failed to get sms confirmation - it's fine. If we failed to get invoice, we should stop trying to issue sms sending or if we already did it, we should spawn an event with cancellation.

- What if we want to add new service and replay old messages after that. But we modified another service, so now it is __obligatory__ for it to get message from this new service to proceed (it's a coupling, but how to do this without coupling?), what to do? If I remove service it looks like I don't need to worry about it, because we can just ignore messages.

- Race condition with the same event? How to solve conflict?

### Group of questions number 2. Questions dedicated to legacy support.

- Integration with current transactions?

- Integration with MongoDB snapshots?

- How to run flow-spec which tests whole flow. I think we might get rid of VCR. It's just a library.

- If current application is based on a state machine, how to mark those steps in state machine.


Notes. Basecamp version of developing application is just write it from scratch. Really straightforward, but then we have to migrate legacy code base. This is a bit complicated. We can just write adapter for MongoDB and tell him where to take the last data snapshots and also imagine that events history is broken for previous orders, which is perfectly fine in my opinion. 


### Performance and scaling
- What if we generate a few millions of events per day, how to scale Postgresql as a storage commponent?

- How to reach high performance, while building materialized views from events (when we are rendering JSON web-response to client for example)

- Event-sourcing and websockets or HTTP/2 push. How to do this? (I guess it should be straightforward because websockets and HTTP/2 are just transports and do not have any relation to materialized vies part or buisness logic part of an application)

### Flows

1. 

I'm searching fare. And saving XML I've got from service in a message. So I've created a message like this

```ruby
class SearchedFare
  attr :raw_xml
end
```

Then, when I'm calling my system later (in reply mode) with a changed parser code (it parses much more out of :raw_xml)
I get another message going to analytics. Like this.

Before:

{ price: 100 }

After:

{ price: 100, tax: 5 }

How does this affect my system in general and should I really care about it or not?

2. 

I have fare-calculation component. Markup values change every 5 minutes. But gds response saved in event will be here forever. When I replay events I recalculate markups and they mismatch with gds response price of ticket. (Actually our markup does not depend on gds price, they are separate, but I think we have flow like that one).

3. 

How to separate all actions between different types of passengers (adt, chd, inf)?

4. 

What if gds specific events happens on an unexpected logical step? How components should react on this?

Solution: We might publish GDS specific Events for GDS stream, after that some GDS flow coordinator component will read this stream and think.
Aha! This ticket is booked, but I need one more ticket to be booked to proceed, so OK, I will wait for now.

5. 

Order is completed. Notification system sees, that order is here and trying to send confirmation,
but in confirmation email we have to attache airline ticket, which we might like to generate with airline-ticket-component. How to wire together this kind of user story?

`order placed -> ticket issued -> email sent`

`order placed -> certificate issued -> email sent -> airline informs about ticket ready -> ticket downloaded and saved on s3 -> email sent`

- What if this is split?
- Should we have coordinator process?

6. 
Monitors
monitoring_stats/
nds/


7. 

I want to change my system.

before: `pay for order -> card checked and valid -> run payment`

If system is already operational and running, how to inject this new flow into it?

now: `pay for order -> card checked and valid -> antifraud not detected -> run payment`

8. 
So we are doing flight reservation.

We can do it this way:

```
get super large payload ->
create multiple events (passengers, baggage, price) ->
publish events ->
dedicated services read dedicated events ->
dedicated services perform actions and publish events
```

What is the impact of this approach?
What if we add or remove some service (baggage)?
What if we change event payload during program evolution?

9. 
How to work with PHI. (credit card data)

# Alternatives or concepts we can still some ideas from

Karafka - framework for Kafka based applications.
Too basic. Kafka as a store + transport - questionable.

Arkency DDD and ES stuff.
Too Rails-oriented (in my opinion)

Sequence
Not that bad, but not as embracing as Eventide

Hand-made solution based on top of dry-rb (I like this one, but it's a lot of work!)

I don't care about implementation now. I care about logical and conceptual structure of an application.
