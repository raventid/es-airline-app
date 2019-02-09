# Example Event Sourced airline reservation application.

Built on top of Eventide - event-sourcing Ruby toolkit.

This is a monorepo with multiple services. To simplify working flow, services in this monorepo are tightly coupled and refer each other by relative path on file-system. (I guess it does not work on Windows, sorry).


To run this application.


TODO: setup script.

Iterate over services. run install_gems.

+ MongoDB
+ Postgresql

TODO: start script 

Iterate over services. run start.


## General overview of application

### Overall basic schema of Search Fare
![alt text](https://github.com/raventid/es-airline-app/blob/master/uml/generated/basic_diagram.svg "general overview")

### Overall overview of highest level Order service
![alt text](https://github.com/raventid/es-airline-app/blob/master/uml/generated/order.svg "Order service")

### Overall overview of Fare service
![alt text](https://github.com/raventid/es-airline-app/blob/master/uml/generated/fares.svg "Fare Service")

### Overall overview of Payment service
![alt text](https://github.com/raventid/es-airline-app/blob/master/uml/generated/payment.svg "Payment service")

Issues:

1) Wolfgang rereads commands from stream and reissues events.
