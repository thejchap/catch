# catch
Catch matches gym partners based on their weekly schedule and desired activities

`client/` contains the Ember.js front end code for the app

`server/` contains the Ruby on Rails backend, GraphQL API, matching logic, etc

The app treats user settings updates as events. For example, if a user updates their desired activities or schedule, an event is emitted that results in all or some of the generated match graph for a given location being rebuilt.

The match graph for a location is stored in Redis, and representations of various objects are cached in Memcached to improve performance and ensure repetitive queries/polling don't result in an unneccesary amount of database queries.

Matching is performed using augmented interval trees to find overlapping "availabilities" (or gym sessions) on a given day, then those matches are ranked based on amount of overlapping time using Jaccard indices.

For example:

1. User A is available from 7-9pm tuesday
2. User B is available from 7:30pm - 9:30pm tuesday
3. User C is available from 5pm-7:30pm tuesday

User A will be matched with B and C, with B being designated the best match, 
User B will be matched with User A, 
User C will be matched with User A
