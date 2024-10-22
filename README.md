# XJTLU-School-Map

The project contains two parts. /project_p1 for the front-end part, and /springboot for the back-end part

This is an android map application for xjtlu students and staffs to use. It has funtion of:
  - view the big map of school, and the floor plain
  - search classroom position in floor plain
  - search facilities position and facilities information in floor plain
  - path navigating
  
 The application is written with framework flutter - https://flutter.dev/
 
 The application connect to a back-end program on server, which written with framework Spring Boot - https://spring.io/projects/spring-boot/
 
 This program process data and pass to the application by Http. The program also achieved A* path searching for the path navigating function.
 
 The Node class in the program is cited from - https://github.com/marcelo-s/A-Star-Java-Implementation 
