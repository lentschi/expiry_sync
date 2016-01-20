# ExpirySync

project containing submodules to keep track of API versions and working server and client versions that implement these API versions respectively

## Folder structure:

- __expiry_sync_server (git submodule):__ rails server application handling json requests by the mobile app
- __expiry_sync_client (git submodule):__ Android app
- __pm:__ project management folder containing docs and concepts for both server and client (such as __API docs__)

## Creating issues:

Please only create issues that require changes on both the server __and__ the client (most likely a request for a new feature that requires the server to offer a new service __and__ the client to use this new service). 

If that is not the case, please either create the issue on the [client's github page](https://github.com/lentschi/expiry_sync_client) (e.g. if it's a usability issue affecting the app only) or on the [server's github page](https://github.com/lentschi/expiry_sync_server) (e.g. if it's a database inconsistency bug).
