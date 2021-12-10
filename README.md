# TMDB

Coding Test for The Movie Database API\
the app is written in VIP pattern\
the app has both online and offline features\
user can toggle the favorite flag. It will save the favorite data in local\
\
how it works -\
\
-the app will first try to fetch some data from the api\
\
-if the data is successfully received, the data will be saved to local\
-the app will build a viewmodel from the received data from api\
-the app will update the UI with the viewmodel\
\
-if the data is not successfully received, the data will be pulled from the local database\
-the app will build a viewmodel from the received data from local\
-the app will update the UI with the viewmodel\
\
-after toggling the favorite flag in detail view, when go back to home view, press the refresh button to see the effect. auto refresh after going back to home view was not yet implemented\
\
I did not implement RX Swift into the app because I'm not familiar with RX Swift yet as non of the companies I worked for during my career use RX Swift and I have not enough time to study RX Swift during code test period
