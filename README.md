# Foddie App

A simple app to take food order for flight passenger by cabin crew:
* Show a list of foods
* Shows details when food items on the list are tapped. 
 

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

 This project uses MVVM design pattern and project is fully developed in Swift.
 
 
 ### Load Food from API
 
 #### Primary Course (Happy path):
 1. Call fetchFood API
 2. System fetches food data from API
 3. System prefill the food data on the UI
 
 #### Error Course (Sad path):
 1. System delivers error
 
 
 

