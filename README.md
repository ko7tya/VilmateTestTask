# VilmateTestTask
Test task from Vilmate, made by Kostyantin Ischenko

# Start using 
Just clone and run a project 

# Architecture 
MVVM + Coordinators 

# Services 
I decided to user SOA(service oriented architecture) for resolve business logic tasks 
LocalNotificationService = Handling local notifications
CalendarService = Handling all tasks related to the calendar 
BackroundService = Handling background fetch procees 
# DI 
Dependency container creates and inject different dependencies 
# Flows 
CalendarEventLists - fetching and showing calendar events 
EventDetail - fetch and show single event 

# Time 
Task was done ~4 hours 

# Possible improve  
1. Adding pagination for fetching events 
2. Add caching 
3. Add ui/unit tests 
