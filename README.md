# Compass
Compass, a GPS navigation application designed for bikes 

## Introduction
Compass is a pair, a device and an application, working together over BLE to make bike fun and easy even on unknown roads.\n
This obviously is the application part :-). It is also a big WIP for now... \n
The application has 4 roles :
1. Be the UI for finding and setting a destination - a mapView with a search function *native map and search?*
2. Get the path to the destination - connection to a bike Routing API *specialized bike routing service?*
3. Manage the connection cycle with the BLE device - search, connection, disconnection *native BLE api?*
4. Provide the BLE device with the right data for the routing - direction and distance to waypoints *custom direction manager?*

## Technical part
This is a Swift 3 projet. Built it the standard way...

*1. Git clone the project
```bash
git clone git@github.com:Apemb/Compass.git
```
*2. Built the pod file
```bash
pod install
```
*3. Have fun ^^

The project has two notable built scripts:
* swiftlint - a nice linter to make sur the code is nice and tidy
* swiftgen - an awesome gem making your life easer dealing with images, strings and storybords  
