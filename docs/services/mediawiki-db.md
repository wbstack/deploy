## DB Changes via platform-api

### Upgrading all sql dbs to a new version of the schema?

See the UpdateWikiDbJob and ScheduleUpdateWikiDbJobs in the api app.

```
./k8s/cmd/bash-api-queue.sh
```

Then update the alpha site:

```
# addshore-alpha is wiki id 38
php artisan job:handle UpdateWikiDbJob id,38,mw1.33-wbs4,mw1.33-wbs5 ,
```

Then check in phpmyadmin to see if the changes actually happened...

If they did then continue to do the change everywhere else..

```
# Do them all....
php artisan job:handle ScheduleUpdateWikiDbJobs version,mw1.33-wbs4,mw1.33-wbs4,mw1.33-wbs5 ,
```

Then validate that they are all done!

And lastly check wiki creation

```
# In order to make sure new wiki db creation is working
php artisan job:handle ProvisionWikiDbJob
```

And make sure it looks like it created correctly.

### Rolling out new mediawiki code

There is an alpha service for mediawiki that can be deployed to.

 - Update the alpha image version, set replicas to 1, and DEPLOY
 - Update platform-apps-ingress values.yml to point to the alpha service
 - Roll out the new mediawiki to the alpha service
 - Check everything is working
 - Roll out the new mediawiki to all services
 - Update platform-apps-ingress values.yml to point to the regular services
 - Set replicas to 0 for the alpha service, and DEPLOY

### Updating to a new version of mediawiki

- [ ] Update the git hashes in the Dockerfile for skins and extensions
- [ ] Update the base mediawiki image version being used
- [ ] Update the build-mediawiki.sh script to tag a new version
- [ ] Build the new image locally
- [ ] TODO generate the NEW sql
- [ ] TODO calculate the migration SQL
- [ ] TODO add new and migration SQL to api
- [ ] test migration?
- [ ] test new?
- [ ] etc...
