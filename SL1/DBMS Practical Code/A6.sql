# Python Connectivity with MySQL from DBMS Print out 6.pdf

# Step 1: Install MySQL Connector
# Run this in your terminal or command prompt:
# python -m pip install mysql-connector-python

# Step 2: Prepare MySQL Database (Run this in your MySQL client)
"""
CREATE DATABASE school;
USE school;
CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT
);
-- Note: The Python code seems to use 'roll_no' and 'course' columns
-- A more matching table might be:
CREATE TABLE students (
    roll_no INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    course VARCHAR(50)
);
"""

# Step 3: Python Program for MySQL Connectivity
import mysql.connector

try:
    # Connect to MySQL database
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="NewPassword",  # change this to your MySQL password
        database="student_db"     # PDF says "student db", but spaces are unlikely. Using "student_db"
                                # Make sure this matches your database name.
    )
    
    cursor = conn.cursor()

    def add_record():
        try:
            roll = int(input("Enter Roll No: "))
            name = input("Enter Name: ")
            age = int(input("Enter Age: "))
            course = input("Enter Course: ")
            
            query = "INSERT INTO students (roll_no, name, age, course) VALUES (%s, %s, %s, %s)"
            values = (roll, name, age, course)
            
            cursor.execute(query, values)
            conn.commit()
            print("Record added successfully!")
        except Exception as e:
            print(f"Error adding record: {e}")
            conn.rollback()

    def view_records():
        try:
            cursor.execute("SELECT * FROM students")
            records = cursor.fetchall()
            print("\n--- Student Records ---")
            if not records:
                print("No records found.")
            for r in records:
                print(f"Roll No: {r[0]}, Name: {r[1]}, Age: {r[2]}, Course: {r[3]}")
        except Exception as e:
            print(f"Error viewing records: {e}")

    def search_record():
        try:
            roll = int(input("Enter Roll No to Search: "))
            cursor.execute("SELECT * FROM students WHERE roll_no=%s", (roll,))
            record = cursor.fetchone()
            
            if record:
                print(f"Roll No: {record[0]}, Name: {record[1]}, Age: {record[2]}, Course: {record[3]}")
            else:
                print("Record not found.")
        except Exception as e:
            print(f"Error searching record: {e}")

    def edit_record():
        try:
            roll = int(input("Enter Roll No to Edit: "))
            new_age = int(input("Enter new Age: "))
            
            cursor.execute("UPDATE students SET age=%s WHERE roll_no=%s", (new_age, roll))
            conn.commit()
            
            if cursor.rowcount > 0:
                print("Record updated successfully!")
            else:
                print("Record not found to update.")
        except Exception as e:
            print(f"Error editing record: {e}")
            conn.rollback()

    def delete_record():
        try:
            roll = int(input("Enter Roll No to Delete: "))
            cursor.execute("DELETE FROM students WHERE roll_no=%s", (roll,))
            conn.commit()
            
            if cursor.rowcount > 0:
                print("Record deleted successfully!")
            else:
                print("Record not found to delete.")
        except Exception as e:
            print(f"Error deleting record: {e}")
            conn.rollback()

    # Menu-driven interface
    while True:
        print("\n===== Student Database Menu =====")
        print("1. Add Record")
        print("2. View All Records")
        print("3. Search Record")
        print("4. Edit Record")
        print("5. Delete Record")
        print("6. Exit")
        
        ch = input("Enter your choice: ")
        
        if ch == '1':
            add_record()
        elif ch == '2':
            view_records()
        elif ch == '3':
            search_record()
        elif ch == '4':
            edit_record()
        elif ch == '5':
            delete_record()
        elif ch == '6':
            print("Exiting...")
            break
        else:
            print("Invalid choice! Try again.")

    # Close the connection
    if conn.is_connected():
        cursor.close()
        conn.close()
        print("MySQL connection is closed.")

except mysql.connector.Error as err:
    print(f"Error connecting to MySQL: {err}")
except Exception as e:
    print(f"An unexpected error occurred: {e}")