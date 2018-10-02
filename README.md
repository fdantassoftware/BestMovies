# BestMovies

1. To start the app open the project folder and open Best Movies Workplace. Xcode will open select a device on the simulator list
and press Run or play button.

2. The architecture i used was my own version of the MVVM project the reason i chose is the fact that the code becomes very clean
and easy to read. Every responsability is seperated which also allows for a good testing range. Apart from that it also reduces the amount
of code on the Controller avoiding the famous Massive View Controller problem ecountered on the Standard MCV architecture.

3. The Libraries used were Kingfisher, ReachabilitySwift and GSMessages installed via Cocoapods.
  a. Kingfisher is just a nice and clean library to download images async and cache it and the same time which reduces time and effort.
  b. ReachabilitySwift was used to handle network changes. It is ideal if you dont want to work with the complex inbuilt apis.
  c. GSMessages is a nice way to show messages to the user. In the app i used it to show network erros. Again it reduced time
  if i was to implement it myself.
  
  
  
4. For saving the data i decided to use CoreData the reason being that is fast and avoid complex code for saving data on files for example.
It also provides a clean way to code seeing that the entities have the same behavior as classes.
