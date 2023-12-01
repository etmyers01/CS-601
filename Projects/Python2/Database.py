"""
Edward Myers
Class: CS 521 - Summer 2
Date: 8/11/21
Final Project: Database.py
Description of Program: Database.py defines a class that stores an asset 
database using a list of dictionaries and several methods to add, remove and
edit elements of the database.  

"""

import datetime

class Database():
    """
    A class that manipulates an inventory of assets.
    
    Built-ins:
        __init__() - Constructor.
        __len__() - Returns number of elements in database as integer.
        __str__() - Returns number of elements in database and last save date.
        __repr__() - Displays all dictionary elements of the database list.
    
    Methods: 
        load_test() - Tests for database file existence.
        is_empty() - Returns empty list status as boolean.
        __id_to_int() - Converts string ID to integer.
        load() - Populates database from a text file.
        save() - Saves database to a text file.
        search_by_id() - Searches for a matching item in database.
        search_by_name() - Searches for a matching name in database.
        add_item() - Adds new item to database.
        delete_item() - Deletes an existing item from the database.
        increment() - Adds to the quantity of an existing item.
        decrement() - Subtracts from the quantity of an existing item.
        get_db() - Returns a list for the current database.
        get_item_by_name() - Returns a specific item dictionary.
        get_item_by_id() - Returns a specific item dictionary.
        
    Attributes:
        __data_list - Private list of dictionaries to store asset items.
        date_str - Date of last save as string.
        current_id - ID marker tracking the last ID number used as string.
        
    """
    
    def __init__(self, in_str = ""):
        """
        Input: File name as string.
        Process: Initialize __data_list and call method load() to read in 
          database list.
        Return: None

        """
        
        # Initialize private database list for load function.
        self.__data_list = []
        self.date_str = "No Date"
        self.current_id = '0000'
        
        self.load(in_str)
        
    def __len__(self):
        """
        Input: None.
        Process: None.
        Return: Number of elements in __data_list as integer

        """
        
        return len(self.__data_list)
       
    def __repr__(self):
        """
        Input: None.
        Process: Construct a formatted string displaying all assets with
          details in the database.
        Return: String.

        """
        
        if (self.is_empty()):                   # If database is empty.
            return "Database has no items!"
        
        else:
        
            # Initialize a header string, formatted for width with column names.
            element_str = 'Database as of : {}\n'.format(self.date_str)
            element_str += '  {:5}|  {:20}|  {:15}|  {:5}\n'.format\
                ("ID", "Name", "Category", "Quantity")
            element_str += ('-' * 60) + '\n'
            
            # Iterate through data list, extracting dictionary elements and
            # adding to formatted output string.
            for x in self.__data_list:
                element_str += \
                "  {:5}|  {:20}|  {:15}|  {:5}\n"\
                .format(x['ID'], x['Name'], x['Category'], x['Quantity'])
                    
            return element_str                  # Return full string.
    
    def __str__(self):
        """
        Input: None.
        Process: Constuct a formatted string displaying database date and 
          number of items.
        Return: String.
        """
        
        # If not an empty list, initialize an output string, including loaded 
        # date and number of database list items.
        if (self.is_empty()):
            return "Database is empty!"
        
        else:                                   # If database is not empty.
            
            element_str = 'Database Date: {}\n'.format(self.date_str)
            element_str += 'Current unique items in database: {}'.format\
                (len(self))
            
            return element_str                  # Return full string.
    
    def load_test(self, input_str = ""):
        """
        Input: Test dictionary file name, empty string as default.
        Process: Attempt to open file, handling exceptions.
        Return: Boolean representing file name validity.

        """
        
        # Attempt to open a file within a try block.  Upon exception convert a
        # validity boolean to false.
        
        continue_test = True            # Initialize file condition as true.
        try:
            file = open(input_str, 'r')
            file.close()
        except IOError:
            continue_test = False       # If problem, set condition to false.
            
        return continue_test            # Return boolean.
    
    def is_empty(self):
        """
        Input: None.
        Process: None.
        Return: Boolean 'True' if list is empty, 'False' if not.
        """
        
        return (True if len(self) == 0 else False)
    
    def __id_to_int(self, id_str = ""):
        """
        Input: ID as string, empty if nothing passed.
        Process: Converts string ID to int, if it exists in list database.
        Return: Conversion success as boolean, ID as integer.

        """
        
        # Use search_by_ID() method to determine if ID already exists. Use the
        # first boolean return value of the tuple.
        if not self.search_by_id(id_str)[0]:
            
            return (False, 0)
        
        else:           # ID exists.
        
            return (True, int(id_str))
    
    def load(self, input_str = "Default_DB.txt"):
        """
        Input: File input string.
        Process: Load data from input_str into database list dictionary.
        Return: None.
        """
        self.__data_list.clear()         # Clear out old data.
        
        if self.load_test(input_str):    # If valid database file name.
            
            # Open file for reading, defaults to 'Default_DB.txt' if none given.
            infile = open(input_str, 'r')
            self.date_str = infile.readline()
            
            # Read each line in the file to extract list elements.
            for lines in infile:
                
                # Initialize a temporary dictionary element to load data.
                current_dict = {'ID': '', 'Name': '', 'Category': '', \
                                'Quantity': ''}
                # Load ID string with characters up until the first space.
                for char in lines:
                    if char != ' ':
                        current_dict['ID'] += char
                    
                    else:
                        # When space is encountered, chop that portion off of 
                        # the front of the line and continue to next parse.
                        lines = lines.lstrip(str(current_dict['ID'] + ' \"'))
                        break
                    
                # Update current_ID variable for tracking next available ID.    
                self.current_id = current_dict['ID']
    
                # Load Name string with characters between the two quotations.    
                for char2 in lines: 
                    if char2 != '\"':
                        current_dict['Name'] += char2
                        
                    else:
                        # When trailing quote is encountered, strip off from
                        # the front of the line and continue to the next parse.
                        lines = lines.lstrip(str(current_dict['Name'] + '\" '))
                        break
                    
                # Load Category string with characters up until the next space.    
                for char3 in lines:
                    if char3 != ' ':
                        current_dict['Category'] += char3
                        
                    else:
                        # When space is encountered, chop that portion off of 
                        # the front of the line and continue to the next parse.
                        lines = lines.lstrip(str(current_dict['Category'] + ' '))
                        break
                
                # Remaining string characters repreent quantity.  Strip white 
                # space off and load in.
                current_dict['Quantity'] = lines.strip()
                
                # Append the list database with this populated dictionary entry.
                
                self.__data_list.append(current_dict)
        
            infile.close()
        
        else:       # If filename was invalid, create an empty database.
            
            self.__data_list = []
    
    def save(self, out_str = "Default_DB.txt"):
        """
        Input: File name as string.
        Process: Write database list to given file.
        Return: Save status as boolean.

        """
        
        # If database list is empty.
        if self.is_empty():
            return False
        
        # If not empty, loop through database and write each item to file.
        else:
            
            outfile = open(out_str, 'w')
            
            # Write initial date string using datetime.now() string.
            print(datetime.datetime.now().strftime("%m/%d/%y"), file = outfile)
    
            for element in self.__data_list:
                
                # Write a formatted line for each item in the database list.
                print ('{} "{}" {} {}'.format(element['ID'], element['Name'],\
                    element['Category'], element['Quantity']), file = outfile )
    
            outfile.close()
            
            return True
    
    def search_by_id(self, item_id = ''):
        """
        Input: Item ID as string
        Process: Loop through database list to find appropriate ID.
        Return: Found status as boolean, index as int.

        """
        
        # If database list is empty, return false, empty dictionary.
        if self.is_empty():
            return (False, 0)
        
        # If not empty, loop through database comparing input to dictionary IDs.
        else:
            
            for element in self.__data_list:
                
                # If item ID is found.
                if str(item_id) == element['ID']:
                    return (True, self.__data_list.index(element))
        
            # If item is not found.
            return (False, 0)
        
    def search_by_name(self, name_str = ""):
        """
        Input: Name to search as string.
        Process: Loop through database list comparing input with existing names.
        Return: Found status as boolean, index as int.

        """
        
        # If database list is empty, return false, empty dictionary.
        if self.is_empty():
            return (False, 0)
        
        # If not empty, loop through database comparing input to dictionary IDs.
        else:
            
            for element in self.__data_list:
                
                # if item name is found, disregarding capitals.
                if str(name_str).lower() == element['Name'].lower():
                    return (True, self.__data_list.index(element))
        
            # If item name is not found.
            return (False, 0)
                
    def add_item(self, name = "", cat = "", num = ""):
        """
        Input: Attributes for new dictionary item as string, string, string.
        Process: Insert item into list in next available ID of list.
        Return: Success as boolean.

        """
        
        # If any of the passed variables are empty, do not add item.
        if not name or not cat or not num:
            return False
        
        # If new item name already exists in the database list.
        if self.search_by_name(name)[0]:
            return False
        
        # All values are not blank.
    
        # Find next avalable ID using current_ID and __id_to_int() method.
        next_id = self.__id_to_int(self.current_id)[1] + 1
        
        # Create a new dictionary item and populate the fields. Cast each 
        # as string to avoid type discrepancies.
        new_item = dict()
        new_item['ID'] = str(next_id).zfill(4)
        new_item['Name'] = str(name)
        new_item['Category'] = str(cat)
        new_item['Quantity'] = str(num)
        
        self.__data_list.append(new_item)
        
        # Increment current_ID to new ID
        self.current_id = str(next_id).zfill(4)
        
        return True
    
    def delete_item(self, name = ""):
        """
        Input: Asset item name as string.
        Process: Remove item from database list, and update IDs.
        Return: Success as boolean.
        """
        
        # If name is empty, return false.
        if not name:
            return False
        
        # If item name is found in the list database.
        if self.search_by_name(str(name))[0]:
            
            # Keep track of index to delete.
            del_index = self.search_by_name(str(name))[1]
            
            # For every item afterward, reset ID to the one prior.
            for i in range(del_index + 1, len(self)):
                self.__data_list[i]['ID'] = str(i).zfill(4)
    
            # Pop the item from the list.
            self.__data_list.pop(del_index)
            
            # Reset the current_id to the new last element.
            self.current_id = self.__data_list[len(self)-1]['ID']
            
            return True
        
        # Item name was not found.
        else:
            return False
    
    def increment(self, id_str, amount = 1):
        """
        Input: Item ID as string, amount to increment as int default 1.
        Process: Add amount value to existing item quantity.
        return: Increment success as boolean.

        """
        
        # Find index of id_str in list database, if exists, using search_by_ID().
        search_tup = self.search_by_id(id_str)
        
        # If search_by_ID() returns True and an integer number is passed, alter
        # list item at returned index under key 'Quantity'.
        if search_tup[0] and type(amount) == int:
            
            curr_num = int(self.__data_list[search_tup[1]]['Quantity'])
            self.__data_list[search_tup[1]]['Quantity'] = str(curr_num + amount)
            return True
            
        else:       # ID was not found in database
            return False
        
    def decrement(self, id_str, amount = 1):
        """
        Input: Item ID as string, amount to decrement as int default 1.
        Process: Subtract amount value from existing item quantity..
        return: Decrement success as boolean.

        """
        
        # Find index of id_str in list database, if exists, using search_by_ID().
        search_tup = self.search_by_id(id_str)
        
        # If search_by_ID() returns True and an integer number is passed, alter
        # list item at returned index under key 'Quantity'.
        if search_tup[0] and type(amount) == int:
            
            curr_num = int(self.__data_list[search_tup[1]]['Quantity'])
            
            # Check to make sure amount entered was not greater than existing
            # quantity.  If so, set quantity to 0.
            self.__data_list[search_tup[1]]['Quantity'] = \
                str(curr_num - amount if curr_num >= amount else 0)
            return True
            
        else:       # ID was not found in database
            return False
        
    def get_db(self):
        """
        Input: None.
        Process: None.
        Return: Copy of database list.
        """
        return list(self.__data_list)
    
    def get_item_by_name(self, name = ''):
        """
        Input: Name as string
        Process: None
        Return: Found as boolean, item as database

        """
        
        # Use search_by_name() to test if name is in database.  
        if self.search_by_name(name)[0]:
            
            # If so, return element at index found.
            return (True, self.__data_list[self.search_by_name(name)[1]])
    
        else:
            
            # If not found.
            return (False, dict())
        
    def get_item_by_id(self, id_str = ''):
        """
        Input: ID as string
        Process: None
        Return: Found as boolean, item as database

        """
        
        # Use search_by_id() to test if ID is in database.  
        if self.search_by_id(id_str)[0]:
            
            # If so, return element at index found.
            return (True, self.__data_list[self.search_by_id(id_str)[1]])
    
        else:
            
            # If not found.
            return (False, dict())   
    
if __name__ == '__main__':

    # __init__() with incorrect, correct and no file name.
    
    db1 = Database("wrongfile.txt")
    db2 = Database("Default_DB.txt")
    db3 = Database()
    
    # Test is_empty()) method.
    assert db1.is_empty() == True, "Assert Error: wrong file, not empty."
    assert db2.is_empty() == False, "Assert Error: correct file, empty."
    assert db3.is_empty() == True, "Assert Error: no file, not empty."
    
    # Test load_test() via load() via the self.date_str variable.
    assert db1.date_str == "No Date", \
        "Assert Error: wrong file, date has value."
    assert db2.date_str != "No Date", \
        "Assert Error: correct file, no date value."
    assert db3.date_str == "No Date", \
        "Assert Error: no file, date has value."
    
    # Test __len__() magic method.
    assert len(db1) == 0, "Assert Error: wrong file, length not 0"
    assert len(db2) != 0, "Assert Error: correct file, length is 0"
    assert len(db3) == 0, "Assert Error: no file, length not 0"
    
    # Test __str__() method
    assert str(db1) == "Database is empty!", \
        "Assert Error: wrong file, database str displays as not empty."
    assert str(db2) != "Database is empty!", \
        "Assert Error: correct file, database str displays as empty."
    assert str(db3) == "Database is empty!", \
        "Assert Error: no file, database str displays as not empty."
        
    # Test search_by_id() and search_by_name() method.
    
    # Test for empty pass, valid ID and invalid type and ID not present.
    db_test_id = ['', '0001', 26, '0070']
    db1_test_out = [False, False, False, False]
    db2_test_out = [False, True, False, False]
    
    for x in range(0,4):
        assert db1.search_by_id(db_test_id[x])[0] == db1_test_out[x], \
            "Assert Error: empty database, ID test list failed."
    
        assert db2.search_by_id(db_test_id[x])[0] == db2_test_out[x], \
            "Assert Error, full database, ID test list failed."
         
    # Test for empty pass, invalid name, invalid type and valid name.
    db_test_name = ['', 'sdlfk', 23, 'hammer']
    db1_test_out = [False, False, False, False]
    db2_test_out = [False, False, False, True]        
    
    for y in range(0,4):
        assert db1.search_by_name(db_test_name[y])[0] == db1_test_out[y], \
            "Assert Error: empty database, name test list failed."
            
        assert db2.search_by_name(db_test_name[y])[0] == db2_test_out[y], \
            "Assert Error: full database, name test list failed."
    
    # Test save() method.
    # Nothing passed, nothing in database, save attempt.
    assert db1.save() == False, \
        "Assert Error: no database, save succeeded."
        
    # Nothing passed, full database, save attempt.
    assert db2.save() == True, \
        "Assert Error: full database, save failed."
        
    # Test __id_to_int().
    # Nothing passed, no database.
    assert db2._Database__id_to_int()[0] == False, \
        "Assert Error, empty database, ID found." 
    
    # ID not present passed, full database.
    assert db2._Database__id_to_int("0027")[0] == False, \
        "Assert Error, full database, ID out of range found."

    # ID present passed, full database.
    assert db2._Database__id_to_int("0002")[0] == True and \
        db2._Database__id_to_int("0002")[1] == 2,\
        "Assert Error, full database, ID in range but not found."
        
    # Test add_item() method.
    # Pass value conditions testing empty values, existing name, integer
    # quantity and correct input.
    
    db_test_add = [("", "", ""),
                   ('carrot', '', '3'),
                   ('Hammer', 'Tool', '8'),
                   ('carrot', 'vegetable', '3'),
                   ('onion', 'vegetable', 4)]
    
    db1_test_out = [False, False, True, True, True]
    db2_test_out = [False, False, False, True, True]
    
    for x in range(0,5):    
        el = db_test_add[x]
        assert db1.add_item(el[0], el[1], el[2]) == db1_test_out[x], \
            "Assert Error, no database, add item list failed."
            
    for y in range(0,5):    
        el = db_test_add[y]
        assert db2.add_item(el[0], el[1], el[2]) == db2_test_out[y], \
            "Assert Error, full database, add item list failed."        
            
    # Test delete_item() method.
    # Pass value conditions testing empty, name not present, name present and
    # incorrect type.
    
    # Reset databases after previous add_item() test.
    db1 = Database("wrongfile.txt")
    db2 = Database("Default_DB.txt")
    
    db_test_del = ['', 'fox', 'hammer', 3]
    
    db1_test_out = [False, False, False, False]
    db2_test_out = [False, False, True, False]

    for x in range(0,4):    
        assert db1.delete_item(db_test_del[x]) == db1_test_out[x], \
            "Assert Error, no database, delete item list failed."
            
    for y in range(0,4):    
        assert db2.delete_item(db_test_del[y]) == db2_test_out[y], \
            "Assert Error, full database, delete item list failed."   
    
    # Test increment() & decrement() method.  
    # Pass value conditions testing presence of ID, incorrect quanity type, 
    # and correct input.
    
    db_test_inc = [('0001', '2kj'),
                   ('0008', 15),
                   ('0005', '15')]
    
    db1_test_out = [False, False, False]
    db2_test_out = [False, True, False]
    
    for x in range(0,3):    
        el = db_test_inc[x]
        assert db1.increment(el[0], el[1]) == db1_test_out[x], \
            "Assert Error, no database, increment list failed."
            
    for y in range(0,3):    
        el = db_test_inc[y]
        assert db2.increment(el[0], el[1]) == db2_test_out[y], \
            "Assert Error, full database, increment list failed."   
    
    # Additional decrement test of subtracting more than existing quantity.
    db_test_dec = [('0001', '2kj'),
                   ('0008', 1),
                   ('0008' ,15),
                   ('0005', '15')]
    
    db1_test_out = [False, False, False, False]
    db2_test_out = [False, True, True, False]
    
    for x in range(0,4):    
        el = db_test_dec[x]
        assert db1.decrement(el[0], el[1]) == db1_test_out[x], \
            "Assert Error, no database, decrement list failed."
            
    for y in range(0,4):    
        el = db_test_dec[y]
        assert db2.decrement(el[0], el[1]) == db2_test_out[y], \
            "Assert Error, full database, decrement list failed."   
   
    # Test get_item_by_name() method.
    # Test values passed as empty, wrong type, correct type.
    db_get_item = ['', 2, 'slkjfslk', 'washer','0002' ]
    
    db1_test_out = [False, False, False, False, False]
    db2_test_out = [False, False, False, True, False]
    
    for x in range(0,5):    
        assert db1.get_item_by_name(db_get_item[x])[0] == db1_test_out[x], \
            "Assert Error, no database, get item by name list failed."
            
    for y in range(0,5):    
        assert db2.get_item_by_name(db_get_item[y])[0] == db2_test_out[y], \
            "Assert Error, full database, get item by name list failed."  
            
    # Test get_item_by_id() method.
    
    db1_test_out = [False, False, False, False, False]
    db2_test_out = [False, False, False, False, True]
    
    for x in range(0,4):    
        assert db1.get_item_by_id(db_get_item[x])[0] == db1_test_out[x], \
            "Assert Error, no database, get item by ID list failed."
            
    for y in range(0,4):    
        assert db2.get_item_by_id(db_get_item[y])[0] == db2_test_out[y], \
            "Assert Error, full database, get item by ID list failed."          
    
    print ("Unit test completed successfully!")
    