import sqlite3
import os

DB_FILE = 'ecommerce.db'
SCHEMA_FILE = 'schema.sql'

def initialize_database():
    """Reads schema.sql, initializes the database if it doesn't exist."""
    conn = sqlite3.connect(DB_FILE)
    cursor = conn.cursor()
    
    if os.path.exists(SCHEMA_FILE):
        with open(SCHEMA_FILE, 'r') as file:
            sql_script = file.read()
            cursor.executescript(sql_script)
            conn.commit()
            print("Database initialized with sample data.")
    else:
        print(f"Error: {SCHEMA_FILE} not found. Please ensure it is in the same directory.")
    
    conn.close()

def execute_query(query, params=()):
    """Helper function: Execute read queries."""
    conn = sqlite3.connect(DB_FILE)
    cursor = conn.cursor()
    cursor.execute(query, params)
    results = cursor.fetchall()
    conn.close()
    return results

def execute_insert(query, params=()):
    """Helper function: Execute insert/update queries."""
    conn = sqlite3.connect(DB_FILE)
    cursor = conn.cursor()
    cursor.execute(query, params)
    conn.commit()
    conn.close()

def view_products():
    print("\n--- Available Products ---")
    products = execute_query("SELECT ProductID, Name, Price, StockQuantity FROM Product")
    print(f"{'ID':<5} | {'Name':<25} | {'Price':<10} | {'Stock'}")
    print("-" * 55)
    for p in products:
        print(f"{p[0]:<5} | {p[1]:<25} | ${p[2]:<9} | {p[3]}")

def staff_add_product():
    print("\n--- Add New Product ---")
    name = input("Enter product name: ")
    price = float(input("Enter product price: "))
    stock = int(input("Enter initial stock quantity: "))
    
    execute_insert("INSERT INTO Product (Name, Price, StockQuantity) VALUES (?, ?, ?)", (name, price, stock))
    print(f"Success! '{name}' added to inventory.")

def customer_purchase():
    print("\n--- Make a Purchase ---")
    cust_id = input("Enter your Customer ID (e.g., 1 for Alice): ")
    view_products()
    prod_id = input("Enter Product ID to purchase: ")
    quantity = int(input("Enter quantity: "))
    
    # Check stock
    stock_data = execute_query("SELECT StockQuantity FROM Product WHERE ProductID = ?", (prod_id,))
    if not stock_data:
        print("Product not found.")
        return
    
    current_stock = stock_data[0][0]
    if current_stock < quantity:
        print(f"Insufficient stock. Only {current_stock} available.")
        return
    
    # Process purchase
    execute_insert("INSERT INTO Purchase (CustomerID, ProductID, Quantity) VALUES (?, ?, ?)", (cust_id, prod_id, quantity))
    # Update inventory
    execute_insert("UPDATE Product SET StockQuantity = StockQuantity - ? WHERE ProductID = ?", (quantity, prod_id))
    
    print("Purchase successful!")

def main_menu():
    while True:
        print("\n=== E-Commerce Database System ===")
        print("1. View All Products")
        print("2. Add New Product (Staff Role)")
        print("3. Make a Purchase (Customer Role)")
        print("4. Exit")
        
        choice = input("Select an option (1-4): ")
        
        if choice == '1':
            view_products()
        elif choice == '2':
            staff_add_product()
        elif choice == '3':
            customer_purchase()
        elif choice == '4':
            print("Exiting system. Goodbye!")
            break
        else:
            print("Invalid selection. Please try again.")

if __name__ == "__main__":
    # NOTE: Always initialize DB on startup for demonstration purposes
    initialize_database()
    main_menu()