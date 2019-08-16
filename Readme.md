MR SpaceAPI
===========

This implements the [SpaceAPI](http://hackerspaces.nl/spaceapi/) for the Maschinenraum in Weimar, TH, Germany.

Deployment on Heroku
--------------------

To deploy for free on Heroku, we need to create two apps. One app
will contain the API itself, while the other app is running a
background job that triggers the cache flush regularly. Both apps
are contained in this single repository.

Add remotes pointing official Heroku account:

    heroku git:remote --app mr-spaceapi --remote heroku
    heroku git:remote --app mr-spaceapi-scheduler --remote scheduler

Alternatively, you can create two new apps on your own.

To push changes to Heroku:

    git push heroku master
    git push scheduler master

Configure main app:

    heroku addons:add redistogo:nano --app mr-spaceapi

Configure scheduler app:

    heroku scale web=0 --app mr-spaceapi-scheduler
    heroku addons:add scheduler:standard --app mr-spaceapi-scheduler
    heroku addons:open scheduler --app mr-spaceapi-scheduler

Now go and add a task running every 10 minutes with the command

    rake update_status

For the last step you need to add Twitter API credentials to the
Heroku configuration (not in repository)

    heroku config:set --app mr-spaceapi TWITTER_CONSUMER_KEY='...'
    heroku config:set --app mr-spaceapi TWITTER_CONSUMER_SECRET='...'
    heroku config:set --app mr-spaceapi TWITTER_ACCESS_TOKEN='...'
    heroku config:set --app mr-spaceapi TWITTER_ACCESS_SECRET='...'

Done.
