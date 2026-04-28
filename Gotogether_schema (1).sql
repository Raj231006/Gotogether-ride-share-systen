/* =====================================================
   TASK 3 : Database Schema, Constraints & Data Insertion
   ===================================================== */

CREATE DATABASE gotogether_db;
USE gotogether_db;

/* ---------------- USER ---------------- */
CREATE TABLE USER (
    user_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(100),

    -- Composite Address (single address only)
    house_no VARCHAR(20),
    street VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    pincode VARCHAR(10),

    overall_rating DECIMAL(2,1)
);

/* ---------------- USER_PHONE (multivalued) ---------------- */
CREATE TABLE USER_PHONE (
    user_id INT,
    phone VARCHAR(15),
    PRIMARY KEY (user_id, phone),
    FOREIGN KEY (user_id) REFERENCES USER(user_id)
);

/* ---------------- PASSENGER ---------------- */
CREATE TABLE PASSENGER (
    passenger_id INT PRIMARY KEY,
    passenger_rating DECIMAL(2,1),
    FOREIGN KEY (passenger_id) REFERENCES USER(user_id)
);

/* ---------------- DRIVER ---------------- */
CREATE TABLE DRIVER (
    driver_id INT PRIMARY KEY,
    license_number VARCHAR(50) UNIQUE,
    driver_rating DECIMAL(2,1),
    FOREIGN KEY (driver_id) REFERENCES USER(user_id)
);

/* ---------------- ADMIN ---------------- */
CREATE TABLE ADMIN (
    admin_id INT PRIMARY KEY,
    admin_name VARCHAR(100),
    admin_email VARCHAR(100) UNIQUE
);

/* ---------------- ADMIN MANAGES USER ---------------- */
CREATE TABLE ADMIN_MANAGES_USER (
    admin_id INT,
    user_id INT,
    PRIMARY KEY (user_id),
    FOREIGN KEY (admin_id) REFERENCES ADMIN(admin_id),
    FOREIGN KEY (user_id) REFERENCES USER(user_id)
);

/* ---------------- VEHICLE ---------------- */
CREATE TABLE VEHICLE (
    vehicle_id INT PRIMARY KEY,
    driver_id INT,
    vehicle_number VARCHAR(20) UNIQUE,
    model VARCHAR(50),
    vehicle_type VARCHAR(10),
    seat_capacity INT,
    registration_details VARCHAR(100),
    FOREIGN KEY (driver_id) REFERENCES DRIVER(driver_id),
    CHECK (vehicle_type IN ('Car','Bike')),
    CHECK (
        (vehicle_type = 'Bike' AND seat_capacity = 1)
        OR
        (vehicle_type = 'Car' AND seat_capacity >= 1)
    )
);

/* ---------------- RIDE ---------------- */
CREATE TABLE RIDE (
    ride_id INT PRIMARY KEY,
    driver_id INT,
    source_city VARCHAR(50),
    source_area VARCHAR(50),
    destination_city VARCHAR(50),
    destination_area VARCHAR(50),
    ride_date DATE,
    ride_time TIME,
    price_per_seats DECIMAL(6,2),
    available_seats INT,
    ride_status VARCHAR(20),
    FOREIGN KEY (driver_id) REFERENCES DRIVER(driver_id)
);

/* ---------------- BOOKING (weak entity) ---------------- */
CREATE TABLE BOOKING (
    booking_id INT,
    passenger_id INT,
    ride_id INT,
    seat_booked INT,
    booking_date DATE,
    booking_status VARCHAR(20),
    total_amount DECIMAL(8,2),
    PRIMARY KEY (booking_id, passenger_id, ride_id),
    UNIQUE (passenger_id, ride_id),
    FOREIGN KEY (passenger_id) REFERENCES PASSENGER(passenger_id),
    FOREIGN KEY (ride_id) REFERENCES RIDE(ride_id),
    CHECK (seat_booked > 0)
);

/* ---------------- PAYMENT ---------------- */
CREATE TABLE PAYMENT (
    payment_id INT PRIMARY KEY,
    booking_id INT,
    passenger_id INT,
    ride_id INT,
    payment_date DATE,
    payment_mode VARCHAR(20),
    payment_status VARCHAR(20),
    FOREIGN KEY (booking_id, passenger_id, ride_id)
        REFERENCES BOOKING(booking_id, passenger_id, ride_id)
);

/* ---------------- RATING ---------------- */
CREATE TABLE RATING (
    rating_id INT PRIMARY KEY,
    reviewer_id INT,
    review_for INT,
    ride_id INT,
    rating_value INT,
    comment VARCHAR(200),
    UNIQUE (reviewer_id, ride_id),
    FOREIGN KEY (reviewer_id) REFERENCES USER(user_id),
    FOREIGN KEY (review_for) REFERENCES USER(user_id),
    FOREIGN KEY (ride_id) REFERENCES RIDE(ride_id),
    CHECK (rating_value BETWEEN 1 AND 5)
);

/* ---------------- INDEXES ---------------- */
CREATE INDEX idx_user_email ON USER(email);
CREATE INDEX idx_booking_passenger ON BOOKING(passenger_id);
CREATE INDEX idx_booking_ride ON BOOKING(ride_id);
CREATE INDEX idx_rating_reviewer ON RATING(reviewer_id);

/* =====================================================
   DATA INSERTION
   ===================================================== */

/* ---------------- USER (with composite address) ---------------- */
INSERT INTO USER VALUES
(1,'Amit','Sharma','amit@gmail.com','pass','12A','MG Road','Delhi','Delhi','110001',4.5),
(2,'Rohit','Verma','rohit@gmail.com','pass','22','Sector 18','Noida','UP','201301',4.2),
(3,'Neha','Singh','neha@gmail.com','pass','9C','Lajpat Nagar','Delhi','Delhi','110024',4.8),
(4,'Karan','Mehta','karan@gmail.com','pass','77','Karol Bagh','Delhi','Delhi','110005',4.1),
(5,'Pooja','Kumar','pooja@gmail.com','pass','18','Civil Lines','Jaipur','Rajasthan','302006',4.6),
(6,'Rahul','Jain','rahul@gmail.com','pass','55','Sector 15','Gurgaon','Haryana','122001',4.3),
(7,'Simran','Kaur','simran@gmail.com','pass','33','Model Town','Ludhiana','Punjab','141002',4.7),
(8,'Ankit','Gupta','ankit@gmail.com','pass','91','Navrangpura','Ahmedabad','Gujarat','380009',4.0),
(9,'Nisha','Yadav','nisha@gmail.com','pass','66','Alkapuri','Vadodara','Gujarat','390007',4.4),
(10,'Vikas','Patel','vikas@gmail.com','pass','44','Vashi','Mumbai','Maharashtra','400703',4.2);

/* ---------------- USER_PHONE ---------------- */
INSERT INTO USER_PHONE VALUES
(1,'9876543210'),
(1,'9123456780'),
(2,'9811111111'),
(3,'9822222222'),
(3,'9000000001'),
(4,'9833333333'),
(5,'9844444444'),
(5,'9111111111'),
(6,'9855555555'),
(7,'9866666666'),
(7,'9222222222'),
(8,'9877777777'),
(9,'9888888888'),
(10,'9899999999'),
(10,'9333333333');

/* ---------------- PASSENGER ---------------- */
INSERT INTO PASSENGER VALUES
(3,4.8),(4,4.1),(5,4.6),(7,4.7),(8,4.0),(9,4.4);

/* ---------------- DRIVER ---------------- */
INSERT INTO DRIVER VALUES
(1,'DL11111',4.5),
(2,'DL22222',4.2),
(6,'DL33333',4.3),
(10,'DL44444',4.2);

/* ---------------- ADMIN ---------------- */
INSERT INTO ADMIN VALUES
(101,'System Admin','admin@gotogether.com');

/* ---------------- ADMIN MANAGES USER ---------------- */
INSERT INTO ADMIN_MANAGES_USER VALUES
(101,1),(101,2),(101,3),(101,4),(101,5),
(101,6),(101,7),(101,8),(101,9),(101,10);

/* ---------------- VEHICLE ---------------- */
INSERT INTO VEHICLE VALUES
(201,1,'DL01AB1111','Swift','Car',4,'RC111'),
(202,2,'DL02CD2222','City','Car',4,'RC222'),
(203,6,'DL03EF3333','Activa','Bike',1,'RC333'),
(204,10,'DL04GH4444','Baleno','Car',4,'RC444');

/* ---------------- RIDE ---------------- */
INSERT INTO RIDE VALUES
(301,1,'Delhi','CP','Noida','Sector 18','2024-02-10','09:00',200,4,'Scheduled'),
(302,2,'Delhi','Dwarka','Gurgaon','Cyber City','2024-02-11','10:00',250,4,'Scheduled'),
(303,6,'Noida','Sector 62','Delhi','AIIMS','2024-02-12','08:30',120,1,'Scheduled'),
(304,10,'Delhi','Rohini','Faridabad','Sector 15','2024-02-13','07:45',180,4,'Scheduled');

/* ---------------- BOOKING ---------------- */
INSERT INTO BOOKING VALUES
(401,3,301,1,'2024-02-09','Confirmed',200),
(402,4,301,2,'2024-02-09','Confirmed',400),
(403,5,302,1,'2024-02-10','Confirmed',250),
(404,7,303,1,'2024-02-11','Confirmed',120),
(405,8,304,2,'2024-02-12','Confirmed',360);

/* ---------------- PAYMENT ---------------- */
INSERT INTO PAYMENT VALUES
(501,401,3,301,'2024-02-09','UPI','Success'),
(502,402,4,301,'2024-02-09','Card','Success'),
(503,403,5,302,'2024-02-10','UPI','Success'),
(504,404,7,303,'2024-02-11','Cash','Success'),
(505,405,8,304,'2024-02-12','UPI','Success');

/* ---------------- RATING ---------------- */
INSERT INTO RATING VALUES
(601,3,1,301,5,'Great ride'),
(602,4,1,301,4,'Good experience'),
(603,5,2,302,5,'Smooth ride'),
(604,7,6,303,5,'Safe bike ride'),
(605,8,10,304,4,'Nice driving');
