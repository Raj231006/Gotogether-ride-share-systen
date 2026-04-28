GoTogether – Smart Ride Sharing System

GoTogether is a Java-based ride-sharing platform that allows users to offer, search, and book rides for both car and bike pooling. The system is designed with a strong focus on database design, integrity constraints, and real-world transaction handling.

PROJECT OVERVIEW

The platform connects drivers and passengers for efficient and cost-effective travel. Drivers can publish ride details, while passengers can search and book rides based on their preferences. The system supports both short-distance (bike) and long-distance (car) ride sharing.

FEATURES

User Roles:

Driver (Car/Bike Owner)
Publish and manage rides
View booking requests
Update ride status
View passenger details and ratings
Passenger
Search available rides
Book or cancel seats
View ride history
Provide ratings and feedback
Admin
Manage users and rides
Monitor system activity
Handle disputes and reports

CORE FUNCTIONALITIES

Ride search based on source, destination, date, and vehicle type
Real-time seat availability tracking
Ride scheduling and availability management
Fare calculation (per seat for car, per ride for bike)
Ride status updates (Scheduled, Ongoing, Completed, Cancelled)
Ratings and feedback system
Secure login and role-based access control

TECH STACK

Frontend / UI: Java (Swing/JavaFX)
Backend: Java
Database: MySQL
SQL: Complex queries (joins, aggregation, nested queries)
Concepts Used:
DBMS (Normalization, Constraints, Indexing)
Triggers
Transactions
OOP Principles

DATABASE FEATURES

Designed normalized relational schema
Implemented primary and foreign key constraints
Used indexing for performance optimization
Executed 15+ SQL queries for application features

Triggers Implemented:

Reduce seats after booking
Automatically decreases available seats after a booking is made
Check seats before booking
Prevents booking if requested seats exceed availability
Restore seats after cancellation
Restores seats when a booking is cancelled

TRANSACTION MANAGEMENT

Implemented transactions to handle concurrent bookings
Ensured ACID properties (Atomicity, Consistency, Isolation, Durability)
Prevented overbooking using trigger + transaction combination

ASSUMPTIONS

A driver can offer multiple rides, but each ride belongs to one driver
A ride can have multiple passengers (based on seat availability)
Bike rides allow only one passenger
Booking is allowed only if seats are available
Users must be registered and logged in to book rides
Fare is calculated per seat (car) and per ride (bike)

HOW TO RUN

Clone the repository
Set up MySQL database and import schema
Configure database connection in Java project
Run the main application file

FUTURE IMPROVEMENTS

Payment gateway integration
Live location tracking
Mobile application version
Advanced recommendation system
Notification system
