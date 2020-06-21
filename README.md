# simpleholmuskchat

Holmusk Submission

## Spec:
Scenario:
- [x] User can Login or Create account to use app features.
- [x] User can view and edit their profile.
- [x] User can refresh their profile.
- [x] User can see and refresh list of their friends.
- [x] User can see and refresh message from their friend inside a chat room.
- [x] User can send text and image (camera and photo library).
- [x] User can access menu from top left button.
- [x] User can toggle app to dark / light mode.
- [x] User can logout and clear all data.

## Backend Readiness:
- [x] Host: com.simple.chat, scheme: https, port: 433
- [x] Document-type: json
- [x] 200 -> response success and return corresponding data
- [x] 400 -> bad request parameters (shame on you).
- [x] 401 -> sessions expired (user must re login to use the app)
- [x] 404 -> endpoints not found (are you lost?)
- [x] 500 -> Internal server errors (it's just a glitch)

## Objectives:
- [x] You are expected to design a skeleton app in a well structured, robust, modular and testable way.
- [x] This is a mock app, the UIs only need to be functional. It can be as ugly as you want.
- [ ] You are expected to test/mock all the api communication to server, so app can seamlessly integrated with live server when it's ready.

## Bonus Points:
- [x] Mock a Deep link from push-notification delegate/callback feature. (payload: friendId, deep link to chatroom page)

Can be easily done using something like this: https://morioh.com/p/ce8d84667194 but this uses the local_notification package.
This approach is not supported together FCM / Twilio Pushy, thus real world implementation may differ completely.

- [x] Logging mechanism at development or production level.

We have a logger.dart with
```dart
debugLog({@required String message, @required String name}) {
  log(
    message,
    name: name,
    stackTrace: StackTrace.current,
  );
}
```
log function from dart:developer is the right way to log in debug mode. Using `print` function
does not work well with iOS debugger.

Something like sentry.io can be used for logging in production, that requires integration with actual server
so left for actual case.

- [x] Dynamic app theme.

We are using a callback provider to toggle appBrightness. A theme provider can easily be put over materialApp to
control app theme, but that will need multiple theme specifications etc

- [x] Dynamic app environment (local, staging, production)

op_environment.dart
an enum global variable handles it for the timebeing.
Environment variables and configurations are taken from `env/env.json`
as an added bonus, debug, profile and release modes are also configured within the .idea files for android studio.

as this issue: "https://github.com/flutter/flutter/issues/59527" gets resolved, we will figure out getting environments in better ways. 



- [x] Live connection in chat room.
Since backend developer ha provided us with restful endpoint, setting up a websocket will 
not be possible.
The best we could do here was polling the server using an internal timer.

Further, async* functions can be used with periodic timers driving them so that set and clear between multiple friends becomes convenient.
