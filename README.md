# Listing

[here]: http://opendoorapp.herokuapp.com

Listing app can be found [here]

Listing app allows a user to search for housing with filtered entries.
The user can choose minimum/maximum bedrooms, minimum/maximum bathrooms,
minimum/maximum square feet, street address, and price range. The app was built
with Ruby on Rails and javascript AJAX. Mapbox API was integrated to allow the
user to see exactly where the houses are. Mapbox API uses the geoJSON
response sent back from the controller in order to pinpoint houses.
Basic bootstrap/SASS was added to allow better user experience.
The data inputted is from
https://s3.amazonaws.com/opendoor-problems/listings.csv
The data had 10000 entries and heroku doesn't allow importing files that
big so the data was imported in batches of 2000 entries. There are currently
9000 entries. Heroku only allows a maximum of 10000 entries in the database for
the basic plan so if a user inputs more than 1000 entries then
the database will being blocking insertion of entries. To import
more entries into the app click the import button in the top right. Batches
of more than 2000 or so may cause a set timeout to the webapp.


In the future, I would definitely try to include pagination, since 10000
search results definitely stretches the page. Anything past 4000 will also lag
the page. I may add more styling so that there is better user experience.
