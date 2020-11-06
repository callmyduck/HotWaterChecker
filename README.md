# KupiBilet-HotWaterChecker

Application tries to fetch data every launch.
Before that, App checks for internet connection.

If there is an internet connection, it tries to do all the hard work.

If there is no internet connection, it tries to find needed resources in the local storage.
(try "Flight Mode" at first launch and at launches after first successful fetching)

Even if fetching is successfull, App checks if resources are already downloaded and do not rewrites it if they are similar to new ones.
