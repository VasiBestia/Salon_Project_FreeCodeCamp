# ✂️ Salon Appointment Scheduler

![Bash](https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)

A command-line interface (CLI) application developed to manage customers and appointments for a salon. This project utilizes advanced **Bash scripting** to interact with a **PostgreSQL** database, simulating a real-world scheduling system.

## 📋 Project Overview

This project is part of the **freeCodeCamp Relational Database Certification**. The goal was to create an interactive Bash script that allows users to book appointments for various salon services. The system handles existing customer lookups, registers new customers on the fly, and ensures data integrity across relational tables.

### Key Features
* **Interactive Menu:** Dynamically retrieves and displays available services from the database.
* **Customer Management:**
    * Checks if a customer exists based on their phone number.
    * Automatically prompts for a name and registers new customers if the number is not found.
* **Appointment Scheduling:** Links customers to specific services and times using Foreign Keys.
* **Input Handling:** Reads user input and executes SQL queries via the `psql` utility.

## 🗄️ Database Schema

The database consists of three normalized tables designed with a **One-to-Many** relationship structure.

### 1. `customers` Table
Stores client information.
| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `customer_id` | SERIAL | PRIMARY KEY | Unique identifier for the customer |
| `phone` | VARCHAR | UNIQUE | Customer's phone number |
| `name` | VARCHAR | NOT NULL | Customer's name |

### 2. `services` Table
Stores the list of offered services (e.g., cut, color).
| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `service_id` | SERIAL | PRIMARY KEY | Unique identifier for the service |
| `name` | VARCHAR | NOT NULL | Name of the service |

### 3. `appointments` Table
Links customers to services and times.
| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `appointment_id` | SERIAL | PRIMARY KEY | Unique ID for the appointment |
| `customer_id` | INT | FOREIGN KEY | References `customers(customer_id)` |
| `service_id` | INT | FOREIGN KEY | References `services(service_id)` |
| `time` | VARCHAR | NOT NULL | The scheduled time (e.g., "10:30am") |

## 📂 File Structure

* **`salon.sh`**: The main executable script containing the business logic.
* **`salon.sql`**: The PostgreSQL dump file containing the table structure and initial data.
* **`restore_db.sh`**: (Optional) Helper script to rebuild the database from the SQL dump.

## 🚀 How to Run

1.  **Prerequisites:** Ensure you have PostgreSQL and a Bash terminal installed.
2.  **Database Setup:**
    Create the database and restore the schema (if using the SQL dump):
    ```bash
    psql -U postgres -c "CREATE DATABASE salon;"
    psql -U postgres -d salon -f salon.sql
    ```
3.  **Permissions:**
    Make the script executable:
    ```bash
    chmod +x salon.sh
    ```
4.  **Execute:**
    Run the application:
    ```bash
    ./salon.sh
    ```

## 🧠 What I Learned

* **Bash & SQL Integration:** How to capture variables in Bash and pass them into SQL queries safely.
* **Logic Flow:** implementing `if/else` statements to handle different user scenarios (New User vs. Returning User).
* **Data Persistence:** Understanding how `INSERT` operations work with Primary and Foreign keys to maintain relational integrity.
* **Stream Processing:** Using `while read` loops and Internal Field Separators (`IFS`) to format raw database output into a user-friendly menu.

## [Author] Vasilescu Alexandru Gabriel Faculty Automation and Computer Science
---
*This project was built for the freeCodeCamp Relational Database Certification.*
