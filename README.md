# RaceDay

## Project Overview

This is my RESTful API plan that I developed for managing athletic events. The system allows Organisers to create and manage events, while Participants can register, enrol in events, and view their race results.

## User Roles

Role - What They Can Do

 **Organiser** - Can Create, update, delete events; add categories; capture race results; view participants .
 **Participant** - Can Register, login, enrol in events; view personal results .

## Database Tables

I created 6 tables for this system:

 Table: What It Stores.

User - User information (name, email, password, role).
Event - Event details (name, description, date, location).
Category - Age/distance categories for events.
Route - Route information for events. 
Enrolment - Links participants to events with finish times and positions.
Results - Shows which position the participant came out.

### ERD Diagram
<img width="492" height="852" alt="ERD PROOG RACEDAY drawio" src="https://github.com/user-attachments/assets/874a38a6-198b-4816-a72d-77f109bf038f" />


## API Endpoints

| Method | Route | What It Does |
|--------|-------|--------------|
| POST | /api/auth/register | Register a new user |
| POST | /api/auth/login | Login and get token |
| GET | /api/events | View all events |
| POST | /api/events | Create an event |
| PUT | /api/events/{id} | Update an event |
| DELETE | /api/events/{id} | Delete an event |
| POST | /api/events/{id}/enrolments | Enrol in an event |
| GET | /api/users/results | View personal results |


## Technologies Used

For my API project, I used the following technologies:

| Technology | Purpose |
|------------|---------|
| **SQL Server** | Database management system |
| **SQL** | Writing queries and creating tables |
| **GitHub** | Version control and repository hosting |
| **GitHub Actions** | CI/CD automation for validation |

# SQL DATABASE EXPLANATION

## My Database: RaceDayDB

I created a database called **RaceDayDB** for managing Race Day events. The database contains 6 tables that work together to store all the necessary information needed for the race day.


## The 6 Tables I Created

### 1. User Table
This table stores information about all users of the system.

**What it stores:**
- UserID - A unique number for each user (Primary Key)
- FirstName - User's first name
- LastName - User's last name
- Email - User's email address (it must be unique)
- Password - User's password
- Role - Whether the user is an Organiser or Participant

**Why I created it:** I need to know who is using the system and what their role is. Organisers will have different permissions than Participants.

---

### 2. Event Table
This table stores information about all events.

**What it stores:**
- EventID - A unique number for each event (Primary Key)
- OrganiserID - The ID of the user who created the event (Foreign Key to User table)
- Name - Event name
- Description - Event description
- Date - When the event takes place
- Location - Where the event is held

**Why I created it:** Organisers need to create events and Participants need to view and join them. Each event must be linked to its organiser.

---

### 3. Category Table
This table stores different categories for each event.

**What it stores:**
- CategoryID - A unique number for each category (Primary Key)
- EventID - The event this category belongs to (Foreign Key to Event table)
- Name - Category name (example Kids 5km, Adults 10km)
- Distance - The distance for this category
- EntryFee - How much it costs to enter

**Why I created it:** Events can have multiple categories with different distances and fees. This allows for different age groups or skill levels.

---

### 4. Route Table
This table stores route information for events.

**What it stores:**
- RouteID - A unique number for each route (Primary Key)
- EventID - The event this route belongs to (Foreign Key to Event table)
- Distance - The total distance of the route
- Description - Route description

**Why I created it:** Each event needs a route. Storing route information separately keeps the Event table clean.

---

### 5. Enrolment Table
This table links Participants to Events and Categories.

**What it stores:**
- EnrolmentID - A unique number for each enrolment (Primary Key)
- UserID - The participant (Foreign Key to User table)
- EventID - The event (Foreign Key to Event table)
- CategoryID - The category (Foreign Key to Category table)
- FinishTime - The participant's finish time
- Position - The participant's finishing position

**Why I created it:** This is the most important table because it shows who is participating in which event and category. It also stores results.


## Project Structure
--RaceDayDB/
-docs/
-ERD_Diagram.png # Entity Relationship Diagram
-Database_Script.sql # SQL script for database creation
-API_Endpoints.md # API endpoint documentation
-README.md # This file
-.github/
-workflows/

## MY INFORMATION 
-Names: Naledi Charity
-Surname: Mokoena
-St Number: ST10488132









