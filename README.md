#### Overview  

Instead of displaying a user's blogs linearly by date, this app allows users to view all of their posts geographically on a map.The WanderMap also introduces the idea of 'trips', with which blogs and photos can be associated.

Users can also search blogs and photos by location, viewing all results from all users.

#### Production

The WanderMap can be found in production [here](http://wander-map.herokuapp.com). To view a user's map and associated resources, click [here](http://wander-map.herokuapp.com/users/testaccountald).

#### APIs

* Twitter  
  * Oauth: users log in via their twitter accounts
  * Posting: when a user posts a new blog, a tweet is automatically posted to their account with a link to the new blog
* Google Maps JavaScript API
  * Used to create the map and all images
* WorldWeatherOnline historical weather data API used to find weather for a blog based on its' location and date
* Unsplash API used to search photos based on weather returned, to update a blog background dynamically.

#### Testing
The test suite is written in RSpec, using Capybara for feature tests, and VCR to record API responses.
