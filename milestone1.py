#skeleton code from professor
import psycopg2
import sys
from PyQt6.QtWidgets import QMainWindow, QApplication, QWidget, QTableWidget,QTableWidgetItem,QVBoxLayout
from PyQt6 import uic, QtCore
from PyQt6.QtGui import QIcon, QPixmap

qtCreatorFile = "milestone1App.ui" 
Ui_MainWindow, QtBaseClass = uic.loadUiType(qtCreatorFile)

class milestone1(QMainWindow):
    def __init__(self):
        super(milestone1, self).__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)
        try:
            self.conn = psycopg2.connect(
                database="milestone1db",
                user="sydnee"
            )
            self.cursor = self.conn.cursor()
            print("Database connected!")
        except Exception as e:
            print(f"Database connection error: {e}")
            return
        
        self.ui.stateComboBox.currentIndexChanged.connect(self.on_state_selected)
        self.ui.cityComboBox.currentTextChanged.connect(self.on_city_selected)
        self.load_states()


    #load states from csv
    def load_states(self):
        try:
            self.cursor.execute("""
                SELECT DISTINCT state 
                FROM business 
                ORDER BY state
            """)
            states = self.cursor.fetchall()
            print(f"Found {len(states)} states")
            
            self.ui.stateComboBox.clear()
            self.ui.stateComboBox.addItem("")  # Empty option
            for state in states:
                self.ui.stateComboBox.addItem(state[0])
                print(f"Added state: {state[0]}")
        except Exception as e:
            print(f"Error loading states: {e}")

    #print to console check
        print(self.ui.stateComboBox)
        print(self.ui.cityComboBox)
        print(self.ui.businessTable)
    
    def on_state_selected(self):
        selected_state = self.ui.stateComboBox.currentText()
        print(f"State selected: {selected_state}")
        #display cities
        if not selected_state:
            self.ui.cityComboBox.clear()
            self.ui.businessTable.setRowCount(0) 
            return
        
        try: #query to fetch all cities for given state
            self.cursor.execute(""" 
                SELECT DISTINCT city 
                FROM business 
                WHERE state = %s 
                ORDER BY city
            """, (selected_state,))
            cities = self.cursor.fetchall()
            print(f"Found {len(cities)} in state {selected_state}")
            self.ui.cityComboBox.clear()
            self.ui.cityComboBox.addItem("") 

            for city in cities: #print all cities in ui
                self.ui.cityComboBox.addItem(city[0])
                print(f"Added city: {city[0]}")
            self.ui.businessTable.setRowCount(0)

        except Exception as e:
            print(f"Error loading cities for state {selected_state}: {e}")


    def on_city_selected(self):
        state = self.ui.stateComboBox.currentText()
        item = self.ui.cityComboBox.currentItem()

        if not item:
            self.ui.businessTable.setRowCount(0)
            return
        city = item.text()

    # # DEBUG 
    #     print(f"DEBUG: state = '{state}'")
    #     print(f"DEBUG: city = '{city}'")


        if not state or not city:
            self.ui.businessTable.setRowCount(0)
            return
        try: #query to fetch all businesses  
            self.cursor.execute("""
                SELECT name, city, state 
                FROM business 
                WHERE city = %s and state = %s
                ORDER BY name
            """, (city, state))
            businesses = self.cursor.fetchall()

            # print(f"Found {len(businesses)} businesses in {city}, {state}")
            # print(f"DEBUG: businesses data = {businesses}") 

            self.ui.businessTable.setColumnCount(3) #columns for name, city, and state
            self.ui.businessTable.setRowCount(len(businesses))

            for row_idx, business in enumerate(businesses):
                for col_idx, value in enumerate(business):
                    self.ui.businessTable.setItem(row_idx, col_idx, QTableWidgetItem(str(value)))   

        except Exception as e:  
            print(f"Error loading businesses: {e}")


if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = milestone1()
    window.show()
    sys.exit(app.exec())