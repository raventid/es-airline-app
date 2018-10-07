# E-commerce component


Should e-commerce component know about every-possible recalculation. Maybe this is library?

Strict separation between library, service and app.

--------------------------------------------------------------------------------------------------------------------------------------------

1) Library - collection of functions which do some stuff?

2) Service - autonomous component, without GET interface. It is some kind of pure function, which accepts an event and after spawns an event.
So `service` is just a library, which has a knowledge about how to get something from event-queue and put something into this queue.

3) App - application, with strictly defined interface, which depends on some external state (database, key), maybe it's just NOT pure function?

--------------------------------------------------------------------------------------------------------------------------------------------
