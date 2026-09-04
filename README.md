# RaceDay
# RaceDayDB - Event Management System

## Project Overview

This is a RESTful API I developed for managing athletic events. The system allows Organisers to create and manage events, while Participants can register, enrol in events, and view their race results.

## User Roles

Role - What They Can Do

 **Organiser** - Can Create, update, delete events; add categories; capture race results; view participants .
 **Participant** - Can Register, login, enrol in events; view personal results .

## Database Tables

I created 6 tables for this system:

 Table: What It Stores.

User - User information (name, email, password, role) 
Event - Event details (name, description, date, location)
Category - Age/distance categories for events 
Route - Route information for events 
Enrolment - Links participants to events with finish times and positions
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

For this project, I used the following technologies:

| Technology | Purpose |
|------------|---------|
| **SQL Server** | Database management system |
| **SQL** | Writing queries and creating tables |
| **REST API** | Backend service architecture |
| **GitHub** | Version control and repository hosting |
| **GitHub Actions** | CI/CD automation for validation |







