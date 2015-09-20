## Leaderboard (real name TBD)
For your favorite leisure sports, track who won, see leaderboards at places you
play, and find people to challenge to a game.

### Outline of user flows
- Welcome screen brings user to "see who plays here".
  - User allows GPS location permission
  - Use Foursquare API to find nearby places.
- Show *Places people play nearby*
  - Show view of nearby places, who's the champ, and games played there.
  - Sort by distance (or some calc of distance and games played there)
- *Place detail view*
  - Shows name, map, and leaderboard.
  - Leaderboard is similar to Strava, where you see the top people, ..., people around you on the leaderboard.
- *Sign up flow*, or "See who's best among your friends" (not sure how to transition to this)
  - Ask user to OAuth Facebook
  - Save their image, email, and Facebook user id.
  - "We will let you know when your friends challenge you or there is someone you should play nearby"
    - Enable push notification permission
- [Future?] Friends leaderboard
  - Shows the leaderboard view, but for just your Facebook friends.
  - [Future] User can click on a person to go to a _match history_ view against them.
- Record results
  - [Future] Select game type: Ping pong, shuffleboard, billiards, ...
  - Select opponent from:
    - Facebook
      - Show list of Facebook friends
      - All to search by name
    - [Future] Nearby
      - Show list of people who have the app and are near this user.
    - [Future] Invite
      - Send SMS link to install the app?
  - Score
    - Allows you to enter score for each player next to a pic of each of their faces and names.
  - User clicks Save
  - Tell user current stats:
    - "You've played Jane 12 times now and have won 75% of the time."
      - [Future] Link to _match history_ view against the other player.
    - "You're in 3rd place at Yahoo!"
      - Link to _place detail view_ so user can see leaderboard there.

[Wireframes](https://www.dropbox.com/s/tnf15ivq24zjc5y/2015-09-20%2012.30.13.jpg?dl=0)

### APIs
- [Elo rating system](https://en.wikipedia.org/wiki/Elo_rating_system) Algorithm for creating leaderboards
- [Parse](https://parse.com/docs/ios/guide) as data store
- [Foursquare](https://developer.foursquare.com/) API for locations
- [Facebook](https://developers.facebook.com/docs/facebook-login) Signup, login, name, profile photo, and social graph.

###  Features

#### Required

#### Optional

### Walkthrough
