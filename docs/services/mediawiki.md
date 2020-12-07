# MediaWiki

The MediaWiki application that will be served, extensions skins i18n and all.

This should make requests to the API to get config / get which wikis exist etc.
This requests for the prototype could just happen each time.. but it should really be cached? (and purged with an event)?

## Updating major version

OUTDATED!!!!!!!!! :D

For `mediawiki-code` image:

- Search for the over version with . and _ everywhere and replace with the new version.
- Run `updateDockerfile.sh` and review the resulting changes
- Tag and build an image

For `mediawiki-base` image:

- Look at the docker image used in mediawiki-docker and copy in changes (including php version)
- Tag and build and image

For `mediawiki` image:

- Use the new `mediawiki-code` and `mediawiki-base` images
- Run `updateOverrides.sh` and review the resulting changes
- Tag and build and image
