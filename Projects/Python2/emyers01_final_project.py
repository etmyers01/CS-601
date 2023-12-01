"""
Edward Myers
Class: CS 521 - Summer 2
Date: 8/18/21
Final Project: Asset Manager Interface
Description of Program: This program provides the interface for an asset 
management program that uses the resources of Database.py.  Users initialize
a database object, call several functions to manipulate its contents, then 
saves it to a valid file from prompt.  
"""

import Database as DB

def main_menu(main_DB):
    """
    Input: Database object.
    Process: Print menu options.
    Return: None.
    """
    
    print ("\nWelcome to Asset Manager.  Please select from the following:")
    print ('-' * 60)
    print ("1:   Load database from file.")
    
    # Do not print save database option if no database loaded.
    if len(main_DB):
        print ("2:   Save database to file.")
        
    print ("3:   Display current database.")
    print ("4:   Search database by name.")
    print ("5:   Search database by ID.")
    print ("6:   Add item to database.")
    print ("7:   Remove item from database.")
    print ("8:   Add quantity to existing item.")
    print ("9:   Remove quantity from existing item.")
    print ("10:  Demo Mode.")    
    print ("11:  Quit.") 
    
def load_from_file(main_DB):
    """
    Input: Database object.
    Process: Prompt user for a valid file_name, using DB.load() to populate 
      asset manager.
    Return: Success message as string, filename as string.

    """    
    
    # Prompt user for valid database text file.
    print ("\nDefault database is 'Asset MGR.txt'.")
    in_str = input("Please enter a valid database filename: ")
    
    # Send it to database loader.  File loaded if valid, otherise empty 
    # database started.
    main_DB.load(in_str)
    
    # 
    if main_DB.load_test(in_str):
        return ("Database successfully loaded.", in_str)
    
    else:
        return ("Invalid filename. Empty database started in 'Asset MGR.txt'.",\
                "Asset MGR.txt")

def item_output(l_dict):
    """
    Input: Asset item as dictionary.
    Process: Create output string of item attributes for display.
    Return: Output as string.

    """
    
    # Initialize a header string, formatted for width with column names.
    element_str = '\n  {:5}|  {:20}|  {:15}|  {:5}\n'.format\
        ("ID", "Name", "Category", "Quantity")
    element_str += ('-' * 60) + '\n'
    
    # Add dictionary elements to formatted string, and return.
    
    element_str += "  {:5}|  {:20}|  {:15}|  {:5}\n".format\
        (l_dict['ID'], l_dict['Name'], l_dict['Category'], \
         l_dict['Quantity'])

    return element_str

def search_name(main_DB):
    """
    Input: Database object.
    Process: Prompt user for an item name. Search database for item if it exists.
    Return: Readout of item statistics as string.
    """
    
    # Prompt user for name input.  Errors are checked when passed to 
    # get_item_by_name().
    name_str = input("Please enter an item name to search: ")
    
    x = main_DB.get_item_by_name(name_str)
    
    if not x[0]:    # First part of method return is found success boolean.
        return ("Name not found in database.")
        
    else:           # If found, return second part of method, dictionary.
        return (item_output(x[1]))
    

def search_id(main_DB):    
    """
    Input: Database object.
    Process: Prompt user for an item ID. Search database for item if it exists.
    Return: Readout of item statistics as string.
    """
    
    # Prompt user for ID input.  Errors are checked when passed to 
    # get_item_by_id().
    id_str = input("Please enter an item ID to search: ")
    
    x = main_DB.get_item_by_id(id_str)
    
    if not x[0]:    # First part of method return is found success boolean.
        return ("ID not found in database.")
        
    else:           # If found, return second part of method, dictionary.
        return (item_output(x[1]))
    
def add_to_db(main_DB):
    """
    Input: Database object.
    Procss: Prompt user for new item name, category & quantity, then use
      database.add_item() to add new item.
    Return: Add success as string.
    """
    # Prompt user for an item name.
    name_str = input("Please enter the item name: ")
    
    # If name already exists in database.
    if main_DB.get_item_by_name(name_str)[0]:
        return ("Item already exists in list, not added.")
    
    else:
        # Next, prompt user for the category.
        cat_str = input ("Please enter the item category: ")
        
        # Next, prompt user for the quantity and check for valid int type.
        try:
            num_int = int(input("Please enter the item quantity: "))
            
        except ValueError:
            return ("Quantity entered is not valid, item not added.")
    
        # Good input.
        else:
            main_DB.add_item(name_str, cat_str, num_int)
            return ("Item added successfully.")
            
def remove_from_db(main_DB):
    """
    Input: Database object.
    Process: Prompt use for item name, finds it in database if it exists and
      removes it from database.
    Return: Remove success as string.
    """        
    
    # Prompt user for name input.  Errors are checked when passed to 
    # get_item_by_name().
    name_str = input("Please enter an item name to remove: ")

    if main_DB.delete_item(name_str):
        return ("Item deleted successfully.")
    
    else:
        return ("Item name not found, item not deleted.")
    
def add_quantity(main_DB):
    """
    Input: Database object.
    Process: Prompt the user for item ID and quantity to add.
    Return: Add quantity success as string.
    """    
    item_str = input\
    ("Please enter the item ID and quantity to add, separated by spaces: ")
    
    # Split input into a list, and use get_item_by_id() to check if exists.
    in_list = item_str.split()
    
    if not len(in_list):
        return ("No input entered, quantity not changed.")
    
    is_id_there = main_DB.get_item_by_id(in_list[0])[0]
        
    # If input is not exactly 2 strings.
    if len(in_list) != 2:
        return ("Not all fields were entered, quantity not changed.")
    
    # If ID does not exist in database.
    elif not is_id_there:
        return ("Item ID was not found, quantity not changed.")
    
    else:
        
        # Check to see if quantity parameter is a valid integer.
        try:
            in_list[1] = int(in_list[1])
            
        except ValueError:
            return ("Quantity entered is not valid, nothing changed.")
    
        # Good input.
        else:
            main_DB.increment(in_list[0], in_list[1])
            return ("Quantity updated successfully.")

def rem_quantity(main_DB):
    """
    Input: Database object.
    Process: Prompt the user for item ID and quantity to remove.
    Return: Remove quantity success as string.
    """    
    item_str = input\
    ("Please enter the item ID and quantity to remove, separated by spaces: ")
    
    # Split input into a list, and use get_item_by_id() to check if exists.
    in_list = item_str.split()
    
    if not len(in_list):
        return ("No input entered, quantity not changed.")
        
    is_id_there = main_DB.get_item_by_id(in_list[0])[0]
        
    # If input is not exactly 2 strings.
    if len(in_list) != 2:
        return ("Not all fields were entered, quantity not changed.")
    
    # If ID does not exist in database.
    elif not is_id_there:
        return ("Item ID was not found, quantity not changed.")
    
    else:
        
        # Check to see if quantity parameter is a valid integer.
        try:
            in_list[1] = int(in_list[1])
            
        except ValueError:
            return ("Quantity entered is not valid, nothing changed.")
    
        # Good input.
        else:
            # Input greater than existing quantity is handled by decrement().
            main_DB.decrement(in_list[0], in_list[1])
            return ("Quantity updated successfully.")
              
def demo_mode():
    """
    Input: None.
    Process: Run all of the database menu options for sample display.
    Return: None.
    """
    
    # These are all the functions and methods for a demonstration database,
    # run through one time to demonstrate full functionality.
    
    # Initialize a demo database, read from and write to a hard-coded file.
    demo_DB = DB.Database()
    
    print ("\nOptions Screen:")
    main_menu(demo_DB)
    
    print ("\n1: Loading a file from 'Asset MGR.txt'.")
    demo_DB.load('Asset MGR.txt')
    
    print ("\n2: Saving a file to 'Demo Save.txt'.")
    demo_DB.save('Demo Save.txt')
    
    print ("\n3: Printing the current database.\n")
    print (repr(demo_DB))
    
    # Demonstrate user-interactive functions: search by name, search by id,
    # add item, remove item, add quantity, remove quantity.
    print ("\n4: Search database by name.")
    print (search_name (demo_DB))
    
    print ("\n5: Search database by ID.")
    print (search_id (demo_DB))
    
    print ("\n6: Add item to database.\n")
    print (repr(demo_DB))
    print (add_to_db (demo_DB))
    
    print ("\n7: Remove item from database.\n")
    print (repr(demo_DB))
    print (remove_from_db (demo_DB))
    
    print ("\n8: Add quantity to existing item.\n")
    print (repr(demo_DB))
    print (add_quantity (demo_DB))
    
    print ("\n9: Remove quantity from item.\n")
    print (repr(demo_DB))
    print (rem_quantity (demo_DB))
    print (repr(demo_DB))
    
    # Bonus administrative function, merging a second database into the first.
    print ("\nDatabase Manipulation: Merge Databases.")
    
    print ("\nLoading first database: 'MergeDB1.txt'.\n")
    merge1 = DB.Database("MergeDB1.txt")
    print (repr(merge1))
    
    print ("\nLoading second database: 'MergeDB2.txt'.\n")
    merge2 = DB.Database("MergeDB2.txt")
    print (repr(merge2))
    
    # Import database as list of dictionaries, step through second list.
    merge2_list = merge2.get_db()
    
    for el in merge2_list:
        
        # If item already in first list, add the quantities.
        if merge1.search_by_name(el['Name'])[0]:
           
            temp_db = merge1.get_item_by_name(el['Name'])[1]
            merge1.increment(temp_db['ID'], int(el['Quantity']))
            
        # If item not found, insert at a new ID    
        else:    
            merge1.add_item(el['Name'], el['Category'], el['Quantity'])
    
    # First list is updated with new data.
    print ("Second database merged with first database.\n")
    print (repr(merge1))

    # Bonus analytics function, identifying unique categories in database.
    print ("\nAnalytics Function: Identify unique categories.\n")
    print ("Source database:")
    print (repr(merge1))
    
    # Receive database as list of dictionaries, loop through category keys.
    merge1_list = merge1.get_db()
    category_set = set()
    
    # Add category values to a set, which removes duplication.
    for el in merge1_list:
        category_set.add(el['Category'])
    
    # Print out formatted list of categories stripping off curly braces.
    print ("\nFrom our database, the unique categories are: {}\n".format\
           (str(category_set).strip('{}')))
    
    print ("I hope you enjoyed your program!  Thank you Prof. Zhang and Marc!")
           

# Initialize database.
asset_man1 = DB.Database()

# Initialize file string.
file_str = "Asset MGR.txt"

# Main program loop.


while True:

    # Call function that prints the main menu selections.
    main_menu(asset_man1)  
    
    # Test user input.  If not an integer, throw exception and re-prompt.
    option = 0
    
    try:
        option = input("Please enter an integer selection between 1 and 11: ")
        option = int(option)
        
    except ValueError:
        print ("Invalid input type, please try again.")
        continue
    
    # React to all numeric menu options.
    else:
        
        # If user input is numerically out of range.
        if option < 1 or option > 11:
            print ("Selection out of range, please try again.")
            
        # If load database selected, load from file and save filename.
        elif option == 1:
            out_str, file_str = load_from_file(asset_man1)
            print (out_str)
            
        # If save database selected and elements exist.                
        elif option == 2 and len(asset_man1):
            
            # True if save success, False if failure.
            if asset_man1.save(file_str):
                print ("Database successfully saved to '{}'.".format \
                       (file_str))
            else:
                print ("Filename error, database not saved.")
              
        # If display database selected.        
        elif option == 3:
            print (repr(asset_man1))
            
        # If search database by name selected.    
        elif option == 4:
            print (search_name(asset_man1))
            
        # If search database by ID selected.
        elif option == 5:
            print (search_id(asset_man1))
        
        # If add item to database selected.
        elif option == 6:
            print (add_to_db(asset_man1))
            print (repr(asset_man1))
            
        # If remove item from database selected.    
        elif option == 7:
            print (repr(asset_man1))
            print (remove_from_db(asset_man1))
            
        # If add quantity to existing item selected.
        elif option == 8:
            print (repr(asset_man1))
            print (add_quantity(asset_man1))
            
        # If delete quantity from existing item selected.
        elif option == 9:    
            print (repr(asset_man1))
            print (rem_quantity(asset_man1))
        
        # If demo mode is selected.
        elif option == 10:
            demo_mode()
            
        # If quit is selected. (program exit condition)    
        elif option == 11:
            print ("Exiting the program.")
            break
        
        # Handler for any other input.
        else:
            print ("Invalid selection, please try again.")
            