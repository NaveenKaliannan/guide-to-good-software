# A small math programs for Bunks

## PayTM Transcations
A simple program to calculate the sum of paytm transcations for specific time period. The command to run this program is `python3 paytm.py test.csv "2024-11-11 09:57:00" "2024-11-11 09:59:59"`.
```python3
import pandas as pd
from tabulate import tabulate
import sys
from datetime import datetime

# Function to display transactions within a date range, sorted by transaction time, and calculate total amount
def display_transactions_in_date_range(file_path, start_date, end_date):
    try:
        # Read the CSV file
        data = pd.read_csv(file_path, quotechar="'")  # Specify quotechar to handle quotes correctly
        
        # Convert 'Transaction_Date' column to datetime format
        data['Transaction_Date'] = pd.to_datetime(data['Transaction_Date'], errors='coerce')
        
        # Filter transactions based on the date range
        mask = (data['Transaction_Date'] >= start_date) & (data['Transaction_Date'] <= end_date)
        filtered_data = data.loc[mask]
        
        # Sort the filtered data by 'Transaction_Date' in ascending order
        filtered_data = filtered_data.sort_values(by='Transaction_Date', ascending=True)
        
        # Calculate the sum of the Amount column for filtered transactions only
        total_amount = filtered_data['Amount'].sum()
        
        # Convert DataFrame to a list of lists for tabulate
        table = filtered_data[['Transaction_ID', 'Transaction_Date', 'Customer_ID', 'Customer_Nickname', 'Status', 'Amount']].values.tolist()
        
        # Get the column headers
        headers = ['Transaction_ID', 'Transaction_Date', 'Customer_ID', 'Customer_Nickname', 'Status', 'Amount']
        
        # Display the content as a table
        print(tabulate(table, headers=headers, tablefmt='grid'))  # Using 'grid' format for better visibility
        
        # Print the total amount at the bottom
        print(f"\nTotal Amount between {start_date} and {end_date}: {total_amount:.2f}")
        
    except FileNotFoundError:
        print(f"Error: The file '{file_path}' was not found.")
    except pd.errors.EmptyDataError:
        print("Error: The file is empty.")
    except pd.errors.ParserError:
        print("Error: There was a problem parsing the file.")
    except KeyError as e:
        print(f"Error: The column '{e}' does not exist in the data.")

# Main execution
if __name__ == "__main__":
    # Check if sufficient arguments are provided
    if len(sys.argv) != 4:
        print("Usage: python paytm.py <csv_file_path> <start_date> <end_date>")
        print("Date format should be YYYY-MM-DD HH:MM:SS")
    else:
        csv_file_path = sys.argv[1]  # Get the CSV file path from command line argument
        start_date_str = sys.argv[2]  # Get start date from command line argument
        end_date_str = sys.argv[3]    # Get end date from command line argument
        
        # Convert string dates to datetime objects with time included
        start_date = datetime.strptime(start_date_str, '%Y-%m-%d %H:%M:%S')
        end_date = datetime.strptime(end_date_str, '%Y-%m-%d %H:%M:%S')
        
        display_transactions_in_date_range(csv_file_path, start_date, end_date)
```
