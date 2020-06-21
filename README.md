# simpleholmuskchat

Holmusk Submission

## Spec

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

## Backend Readiness
- [x] Host: com.simple.chat, scheme: https, port: 433
- [x] Document-type: json
- [x] 200 -> response success and return corresponding data
- [x] 400 -> bad request parameters (shame on you).
- [x] 401 -> sessions expired (user must re login to use the app)
- [x] 404 -> endpoints not found (are you lost?)
- [x] 500 -> Internal server errors (it's just a glitch)

## Objectives
- [x] You are expected to design a skeleton app in a well structured, robust, modular and testable way.
- [x] This is a mock app, the UIs only need to be functional. It can be as ugly as you want.
- [ ] You are expected to test / mock all the api communication to server, so app can seamlessly integrated with live server when it's ready.