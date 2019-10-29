# ExpirySync

This is a repository containing submodules to keep track of API versions and working server and client versions that implement these API versions respectively.

The current API's docs can be found under [releases](https://github.com/lentschi/expiry_sync/releases).

Also this repository contains a docker-compose config to bring up a dev environment of server and client.

The license for the complete ExpirySync package is the [GPLv3](LICENSE.md).

## Folder structure

- __expiry_sync_server (git submodule):__ rails server application handling json requests by the mobile app
- __expiry_sync_client (git submodule):__ Ionic app
- __pm:__ project management folder containing docs and concepts for both server and client (such as __API docs__)

## Creating issues & contributing

Please only create issues that require changes on both the server __and__ the client (most likely a request for a new feature that requires the server to offer a new service __and__ the client to use this new service).

If that is not the case, please either create the issue on the [client's github page](https://github.com/lentschi/expiry_sync_client) (e.g. if it's a usability issue affecting the app only) or on the [server's github page](https://github.com/lentschi/expiry_sync_server) (e.g. if it's a database inconsistency bug).

If you want to __contribute__ to this free project, post a comment to the GitHub issue you want to contribute to. (Or if it's a new idea, create a new issue stating that you could implement the request.)

## Building app & server with docker

To easily build a working dev environment with server __and__ client using docker, follow those simple steps (__Take care:__ This has only been tested on Linux systems so far):

1. [Install docker-compose and its prerequisites](https://docs.docker.com/compose/install/)
1. Clone this repository and run `git submodule update --init` in the project dir.
1. Copy `env.default` to `.env` and adapt it to your needs.
1. Bring up all the docker containers with one single command: `docker-compose up -d`
1. Now __grab some :coffee: and wait patiently__. (Depending on your internet connection and processor, this might take quite a while!)

To check if everything is up and running you need a way to access the docker instance though your network. On how to do that, you may [google](https://www.google.com/#q=docker+resolve+container+ip), [read the docs](https://docs.docker.com/engine/userguide/networking/) or - much simpler - just download and use my [makeshift script](https://gist.github.com/lentschi/63d073467a7c59c1c0dac8c1951341f0) (Simply adds entries to your `/etc/hosts` file):

```bash
# Download the script (One-time setup):
cd /tmp
wget https://gist.github.com/lentschi/63d073467a7c59c1c0dac8c1951341f0/archive/e0386fe7abd5b804ad714cd4735d1bed3332ca3f.zip -O add_docker_host.zip
unzip -j add_docker_host.zip
sudo mv add_docker_host.py /usr/local/bin/add_docker_host
sudo chmod +x /usr/local/bin/add_docker_host

# Repeat everytime after launching the docker
# containers (IPs aren't static by default):
cd /path/to/expiry-sync
./setup/add_docker_hosts_to_etc_hosts.sh
# -> Enter root password when asked to allow modification of /etc/hosts

```

__Congrats__ - once the docker containers are done working, you should be able to access each part of the app's ecosystem:

- __API server and web interface__: [http://expiry-sync-web.local](http://expiry-sync-web.local)
- __API server's database__ (PostgreSQL): `psql -h expiry-sync-db.local -U expiry_sync`
- __MailHog__ (Will catch any mails sent by the server): [http://expiry-sync-mail.local](http://expiry-sync-mail.local:8025)
- __App__ (in the __web version__, which - for now - doesn't support all the features the mobile device version provides; only tested browser so far: __Google Chrome__): [http://expiry-sync-app.local](http://expiry-sync-app.local)

### Running in Android emulator

Run `docker-compose exec app build-and-run-in-android-emulator` to see the app within the android emulator and have it live reload when you change the FE code.

### Building the Android app

Here are the instructions to export APKs to `./expiry_sync_client/platforms/android/build/outputs/apk`. (On how to transfer them onto a device or emulator, please refer to [Google's docs on this topic](https://developer.android.com/studio/command-line/adb.html#move).)

These examples use wrapper scripts for [ionic commands](https://ionicframework.com/docs/cli/) - so, if you know what you're doing, you can of course use those commands directly instead.
Note that the scripts may modify `config.xml`, `package.json` and `package-lock.json` so be sure to commit any changes before running them!
For the production/release versions, the build process will look for `expiry_sync_client/src/environments/environment.prod.ts`, which is ingored by git. Copy it from `environment.ts` and adapt it to your needs (Especially the API server name: `defaultServerUrl`).

#### Developer's version

Non-minified debug version with console messages:

`docker-compose exec app build-android-dev`

#### Production version

Minified production version without console messages:

`docker-compose exec app build-android-prod`

#### Release version

Minified production version without console messages signed for uploading to Google Play.

```bash
cp your-android-keystore.keystore ./expiry_sync_client/deploy-keys/expiry-sync.keystore
docker-compose exec app build-android-release
```

### Web version

Minified production version:
`docker-compose exec app build-web-release`.

### iOS, Windows, electron

This hasn't been tried yet, but it's possible in theory as the platforms are supported by ionic. It *will* require some coding though.

## Building without docker

Please either see the submodules' READMEs or read the commands/scripts called by `docker-compose.yml` and adept them to your needs (Therefore you may need some knowledge of docker and [SaltStack](https://saltstack.com/), which is called by docker-compose).

## Testing

To run E2E tests run `docker-compose exec app run_e2e_tests`. (Note that a first run will take a while as a dummy API server needs to be installed) If you want to debug those tests, connect to `expiry-sync-app.local` on port `9200`. To run the tests in a real Chrome (non-headless), remove the `--headless` argument from `expiry_sync_client/e2e/protractor.conf.js`.

For unit testing, see the submodules' READMEs.
