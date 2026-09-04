--Created the RaceDay database
CREATE DATABASE RaceDayDB;


-- Selected the RaceDay database
USE RaceDayDB;



-- Created the Users table
CREATE TABLE Users
(
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    Role VARCHAR(20) NOT NULL,

    CONSTRAINT CK_Users_Role
        CHECK (Role IN ('Organiser', 'Participant'))
);



-- Created the Event table
CREATE TABLE Event
(
    EventID INT IDENTITY(1,1) PRIMARY KEY,
    OrganiserID INT NOT NULL,
    EventName VARCHAR(100) NOT NULL,
    Event_Description VARCHAR(500) NOT NULL,
    Location VARCHAR(150) NOT NULL,
    Event_Date DATE NOT NULL,
    Weather_Info VARCHAR(100) NOT NULL
        CONSTRAINT DF_Event_Weather DEFAULT ('Information pending'),

    CONSTRAINT FK_Event_Organiser
        FOREIGN KEY (OrganiserID)
        REFERENCES Users(UserID)
);



-- Created the Route table
CREATE TABLE Route
(
    RouteID INT IDENTITY(1,1) PRIMARY KEY,
    EventID INT NOT NULL,
    Route_Name VARCHAR(100) NOT NULL,
    Distance DECIMAL(6,2) NOT NULL,
    Route_Description VARCHAR(500) NOT NULL,

    CONSTRAINT CK_Route_Distance
        CHECK (Distance > 0),

    CONSTRAINT FK_Route_Event
        FOREIGN KEY (EventID)
        REFERENCES Event(EventID)
        ON DELETE CASCADE
);



-- Created the Category table
CREATE TABLE Category
(
    Category_ID INT IDENTITY(1,1) PRIMARY KEY,
    EventID INT NOT NULL,
    Category_Name VARCHAR(100) NOT NULL,
    Distance DECIMAL(6,2) NOT NULL,
    Entry_Fee DECIMAL(10,2) NOT NULL
        CONSTRAINT DF_Category_EntryFee DEFAULT (0.00),

    CONSTRAINT CK_Category_Distance
        CHECK (Distance > 0),

    CONSTRAINT CK_Category_EntryFee
        CHECK (Entry_Fee >= 0),

    CONSTRAINT UQ_Category_Event_Name
        UNIQUE (EventID, Category_Name),

    CONSTRAINT FK_Category_Event
        FOREIGN KEY (EventID)
        REFERENCES Event(EventID)
        ON DELETE CASCADE
);



-- Created the Enrolment table
CREATE TABLE Enrolment
(
    EnrolmentID INT IDENTITY(1,1) PRIMARY KEY,
    ParticipantID INT NOT NULL,
    CategoryID INT NOT NULL,
    Entry_Date DATE NOT NULL
        CONSTRAINT DF_Enrolment_EntryDate
        DEFAULT (CAST(GETDATE() AS DATE)),
    Status VARCHAR(20) NOT NULL
        CONSTRAINT DF_Enrolment_Status
        DEFAULT ('Pending'),

    CONSTRAINT CK_Enrolment_Status
        CHECK (Status IN ('Pending', 'Confirmed', 'Completed', 'Cancelled')),

    CONSTRAINT UQ_Enrolment_Participant_Category
        UNIQUE (ParticipantID, CategoryID),

    CONSTRAINT FK_Enrolment_Participant
        FOREIGN KEY (ParticipantID)
        REFERENCES Users(UserID),

    CONSTRAINT FK_Enrolment_Category
        FOREIGN KEY (CategoryID)
        REFERENCES Category(Category_ID)
);



-- Created the Result table
CREATE TABLE Result
(
    ResultID INT IDENTITY(1,1) PRIMARY KEY,
    EnrolmentID INT NOT NULL UNIQUE,
    Finish_Time TIME NULL,
    Position INT NULL,

    CONSTRAINT CK_Result_Position
        CHECK (Position IS NULL OR Position > 0),

    CONSTRAINT FK_Result_Enrolment
        FOREIGN KEY (EnrolmentID)
        REFERENCES Enrolment(EnrolmentID)
        ON DELETE CASCADE
);


-- Inserted the organisers and participants
INSERT INTO Users
    (FirstName, LastName, Email, PasswordHash, Role)
VALUES
    ('Lerato', 'Mokoena', 'lerato.mokoena@raceday.co.za',
     'Mokoena@123', 'Organiser'),

    ('Thabo', 'Naidoo', 'thabo.naidoo@raceday.co.za',
     'Naidoo@67', 'Organiser'),

    ('Anele', 'Dlamini', 'anele.dlamini@gmail.com',
     'AneleDla@45', 'Participant'),

    ('Jason', 'Mthembu', 'jason.mthembu@gmail.com',
     'JayMthembu@1234', 'Participant');


-- Inserted three events
INSERT INTO Event
    (OrganiserID, EventName, Event_Description, Location, Event_Date, Weather_Info)
VALUES
    (1,
     'Cape Sunrise Run',
     'A scenic early morning road running event along the coast.',
     'Cape Town, Western Cape',
     '2026-10-18',
     'Cool morning expected'),

    (1,
     'Soweto Unity Walk',
     'A community walking event focused on health and unity.',
     'Soweto, Gauteng',
     '2026-11-07',
     'Mild conditions expected'),

    (2,
     'Durban Coastal Challenge',
     'A road running challenge along the Durban coastline.',
     'Durban, KwaZulu-Natal',
     '2026-12-05',
     'Warm coastal weather expected');



-- Inserted routes for each event
INSERT INTO Route
    (EventID, Route_Name, Distance, Route_Description)
VALUES
    (1,
     'Sunrise 5K Loop',
     5.00,
     'A short coastal loop suitable for beginner runners.'),

    (1,
     'Atlantic 10K',
     10.00,
     'A longer route following the Atlantic coastline.'),

    (2,
     'Unity Walk Route',
     8.00,
     'A community route passing important Soweto landmarks.'),

    (2,
     'Soweto Challenge Route',
     15.00,
     'A longer route for experienced participants.'),

    (3,
     'Golden Mile Run',
     10.00,
     'A coastal route designed for competitive runners.'),

    (3,
     'Durban Half Challenge',
     21.10,
     'A half marathon route along the Durban coastline.');



-- Inserted categories for the three events
INSERT INTO Category
    (EventID, Category_Name, Distance, Entry_Fee)
VALUES
    (1, '5 KM Fun Run', 5.00, 80.00),
    (1, '10 KM Open', 10.00, 140.00),

    (2, '8 KM Community Walk', 8.00, 60.00),
    (2, '15 KM Challenge', 15.00, 110.00),

    (3, '10 KM Coastal Run', 10.00, 150.00),
    (3, '21.1 KM Half Marathon', 21.10, 220.00);


-- Inserted  enrolments for the participants
INSERT INTO Enrolment
    (ParticipantID, CategoryID, Entry_Date, Status)
VALUES
    (3, 1, '2026-09-01', 'Confirmed'),
    (3, 5, '2026-09-02', 'Pending'),
    (4, 2, '2026-09-01', 'Confirmed'),
    (4, 6, '2026-09-03', 'Pending');


-- Inserted a sample result
INSERT INTO Result
    (EnrolmentID, Finish_Time, Position)
VALUES
    (1, '00:28:42', 12);


-- Selected all users to check the inserted data
SELECT * FROM Users;

-- Selected all events to check the inserted data
SELECT * FROM Event;

-- Selected all routes to check the inserted data
SELECT * FROM Route;

-- Selected all categories to check the inserted data
SELECT * FROM Category;

-- Selected all enrolments to check the inserted data
SELECT * FROM Enrolment;

-- Selected all results to check the inserted data
SELECT * FROM Result;


-- Joined the tables to check that the relationships are working
SELECT
    E.EventName,
    C.Category_Name,
    U.FirstName + ' ' + U.LastName AS Participant,
    EN.Entry_Date,
    EN.Status
FROM Enrolment EN
INNER JOIN Users U
    ON EN.ParticipantID = U.UserID
INNER JOIN Category C
    ON EN.CategoryID = C.Category_ID
INNER JOIN Event E
    ON C.EventID = E.EventID
ORDER BY E.Event_Date, EN.Entry_Date;