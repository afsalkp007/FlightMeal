# FlightMeal App

A simple app to take meal order for flight passenger by cabin crew:
* Presented items from a predefined menu, ensuring synchronization across devices.

* Managed device connections through the Bluetooth/Wifi (MultipeerConnectivity) framework.

* Captured meal orders from passengers and displayed a summary in a separate view.

* Stored captured information locally in a database to persist data, ensuring data availability even upon app relaunch.

* Implemented a countdown functionality with each order to keep everyone informed.

* Executed a seamless Master/Slave implementation over the MultipeerConnectivity framework.

* Enabled syncing and local persistence of the order list, even when other devices are in the background.

* Ensured syncing and persistence even during simultaneous order-taking by multiple peers.

* Revamped all screens with animated designs.

* Employed a clean MVVM-C architecture, accompanied by Unit/UI tests. 
 

# Installation

* Installation by cloning the repository
* Go to directory
* use command + B or Product -> Build to build the project
* Press run icon in Xcode or command + R to run the project on Simulator

## Running The Tests Manually 

Follow the steps to get test case reports:
* Enable coverage Data under test schema section:
* Select the Test Icon by pressing and holding Xcode Run Icon OR press `Command+Control+U`
* In the Project Navigator under Test Navigator tab, check test status and coverage 

# Architecture

 This project uses MVVM-C design pattern and project is fully developed in Swift.
 

