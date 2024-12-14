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


## Process WhatsAPP data 
The command to run this program is `python3 pertrolcustomers.py  WhatsAppChatExportedZIPFILE.zip`
```
import pandas as pd
from tabulate import tabulate
import re
from datetime import datetime
import argparse
import zipfile
import os
import matplotlib.pyplot as plt

# Function to read messages from a text file and process them
def process_whatsapp_data(file_path):
    # Read the txt file
    with open(file_path, 'r', encoding='utf-8') as file:
        lines = file.readlines()

    # Initialize an empty list to store customer data
    customer_data = []

    # Process each line in the file
    for line in lines:
        match = re.search(r'(\d{2}/\d{2}/\d{4}, \d{2}:\d{2}) - [^:]+:\s*([^:]+)\s+(\d+)', line)
        if match:
            timestamp_str = match.group(1)
            name = match.group(2).strip()
            count = int(match.group(3))
            timestamp = datetime.strptime(timestamp_str, '%d/%m/%Y, %H:%M')
            customer_data.append({'Name': name, 'Points': count, 'LastFilled': timestamp})
        else:
            match_last_colon = re.search(r'(\d{2}/\d{2}/\d{4}, \d{2}:\d{2}) - [^:]+:\s*([^:]+):\s*([^:]+)\s+(\d+)', line)
            if match_last_colon:
                timestamp_str = match_last_colon.group(1)
                name = match_last_colon.group(3).strip()
                count = int(match_last_colon.group(4))
                timestamp = datetime.strptime(timestamp_str, '%d/%m/%Y, %H:%M')
                customer_data.append({'Name': name, 'Points': count, 'LastFilled': timestamp})

    df = pd.DataFrame(customer_data)

    if not df.empty:
        aggregated_df = df.groupby('Name').agg({'Points': 'sum', 'LastFilled': 'max'}).reset_index()
        aggregated_df.sort_values(by='Points', ascending=False, inplace=True)
    else:
        aggregated_df = pd.DataFrame(columns=['Name', 'Points', 'LastFilled'])

    return aggregated_df

# Function to unzip the given zip file and return the text file path
def unzip_file(zip_path):
    with zipfile.ZipFile(zip_path, 'r') as zip_ref:
        zip_ref.extractall("temp_extracted")
        for file_name in os.listdir("temp_extracted"):
            if file_name.endswith('.txt'):
                return os.path.join("temp_extracted", file_name)
    return None

# Function to save DataFrame as an image using matplotlib with colored rows for top scorers
def save_dataframe_as_image(df, filename):
    fig, ax = plt.subplots(figsize=(10, len(df) * 0.5))
    
    ax.axis('tight')
    ax.axis('off')
    
    # Prepare table data with color coding for top 3 scorers
    table_data = [df.columns.tolist()] + df.values.tolist()
    
    # Create a color list for the rows
    colors = ['lightgreen', 'lightblue', 'lightcoral']  # Colors for top scorers
    row_colors = ['white'] * (len(df) + 1)  # Default color for other rows (+1 for header)
    
    # Assign colors to the top 3 scorers if they exist
    if len(df) > 0:
        row_colors[1] = colors[0]  # First place (header is at index 0)
    if len(df) > 1:
        row_colors[2] = colors[1]  # Second place
    if len(df) > 2:
        row_colors[3] = colors[2]  # Third place
    
    # Create a table and apply row colors
    table = ax.table(cellText=table_data, loc='center', cellLoc='center', colLabels=None)
    
    for i in range(len(table_data)):
        table[i, 0].set_facecolor(row_colors[i])  # Set row color
    
    table.auto_set_font_size(False)
    table.set_fontsize(10)
    
    plt.savefig(filename, bbox_inches='tight', dpi=300)

# Main function to handle command-line arguments and processing
def main():
    parser = argparse.ArgumentParser(description='Process WhatsApp messages from a zip file containing a text file.')
    parser.add_argument('file', type=str, help='Path to the WhatsApp messages zip file')

    args = parser.parse_args()

    text_file_path = unzip_file(args.file)

    if text_file_path is None:
        print("No .txt file found in the zip archive.")
        return

    aggregated_results = process_whatsapp_data(text_file_path)

    if not aggregated_results.empty:
        print(tabulate(aggregated_results, headers='keys', tablefmt='psql'))
        
        save_dataframe_as_image(aggregated_results, 'aggregated_results.png')
        print("Results saved as 'aggregated_results.png'.")
        
    else:
        print("No valid messages found.")

if __name__ == '__main__':
    main()
```

### App Script for google sheet
```
function logEdits(e) {
  const excludedSheets = ['VerfifictionData', 'Template', 'DontDuplicate', '0Master', 'DataPresentation', 'logsheets'];
  const logSheetName = 'logsheets';
  
  const sheet = e.source.getActiveSheet();
  const sheetName = sheet.getName();

  // Exit if the edited sheet is in the excluded list
  if (excludedSheets.includes(sheetName)) return;

  // Get the log sheet or create it if it doesn't exist
  let logSheet = e.source.getSheetByName(logSheetName);
  if (!logSheet) {
    logSheet = e.source.insertSheet(logSheetName);
    logSheet.appendRow(["Serial No", "Timestamp", "Action", "Sheet Name", "Row Number", "Old Row Data", "New Row Data"]);
    formatLogSheet(logSheet); // Format headers on creation
  }

  const timestamp = new Date();
  
  // Handle multiple row deletions
  if (e.oldValue === undefined && e.value === undefined) {
    const deletedRows = e.range.getNumRows(); // Get number of rows deleted
    for (let i = 0; i < deletedRows; i++) {
      const oldRowData = getRowData(sheet, e.range.getRow() + i); // Get old data for each deleted row
      logDeletedRow(logSheet, oldRowData, sheetName, e.range.getRow() + i); // Log deleted row in red with sheet name
    }
    return; // Exit after logging deleted rows
  }

  const editedRow = e.range.getRow();
  
  // Get old row data before any changes
  const oldRowData = getRowData(sheet, editedRow);
  
  let action;
  
  // Determine action based on old and new values
  if (e.oldValue === undefined && e.value !== undefined) {
    action = 'Added'; // New entry added
    // Since it's a new entry, we don't have old data
    logSheet.appendRow([null, timestamp, action, sheetName, editedRow, "", getRowDataAfterEdit(sheet, editedRow, e)]);
    return; // Exit after logging added entry
  } else if (e.oldValue !== undefined && e.value === undefined) {
    action = 'Deleted'; // Entry deleted
    logDeletedRow(logSheet, oldRowData, sheetName, editedRow); // Log deleted row in red with sheet name
    return; // Exit after logging deleted row
  } else {
    action = 'Modified'; // Entry modified
  }

  // Get new row data after applying the edit
  const newRowData = getRowDataAfterEdit(sheet, editedRow, e);

  // Generate serial number based on timestamp
  const serialNumber = generateSerialNumber(logSheet);

  // Log the change with old and new row data including the edited row number
  logSheet.appendRow([serialNumber, timestamp, action, sheetName, editedRow, oldRowData, newRowData]);

  // Format columns for Old Row Data and New Row Data after appending the row
  formatLogSheet(logSheet);
}

function getRowData(sheet, row) {
  const range = sheet.getRange(row, 1, 1, 12); // Get columns A to L (1 to 12)
  const values = range.getValues()[0]; // Get values from the range
  return values.join(", "); // Join values into a single string for logging
}

function getRowDataAfterEdit(sheet, row, e) {
  const range = sheet.getRange(row, 1, 1, 12); // Get columns A to L (1 to 12)
  
  // Create an array of current values in the row
  let currentValues = range.getValues()[0];

  // Update the specific cell that was edited
  currentValues[e.range.getColumn() - 1] = e.value; // Set the edited cell value

  return currentValues.join(", "); // Join values into a single string for logging
}

function logDeletedRow(logSheet, rowData, sheetName, rowNumber) {
  const timestamp = new Date();
  
  // Append deleted row data with red formatting including row number
  const deletedRowLog = logSheet.appendRow([null, timestamp, "Deleted", sheetName, rowNumber, rowData, ""]);
  
  // Apply red text color to the last appended row (deleted entry)
  const lastRowIndex = logSheet.getLastRow();
  
  for (let colIndex = 1; colIndex <= logSheet.getLastColumn(); colIndex++) {
    logSheet.getRange(lastRowIndex, colIndex).setFontColor("red");
  }
}

function generateSerialNumber(logSheet) {
   const lastLogRow = logSheet.getLastRow();
  
   // If there are no logs yet or it's a fresh start with no entries
   if (lastLogRow === 0) return 1;

   const lastTimestamp = logSheet.getRange(lastLogRow, 2).getValue(); // Get the last timestamp
  
   // Check if the last entry is within an hour
   if ((new Date() - new Date(lastTimestamp)) <= (60 * 60 * 1000)) {
     return logSheet.getRange(lastLogRow, 1).getValue(); // Return the same serial number if within an hour
   } else {
     return lastLogRow + 1; // Increment serial number for a new hour or after reset
   }
}

function formatLogSheet(logSheet) {
   // Set widths for Old Row Data and New Row Data columns (E and F)
   logSheet.setColumnWidth(5,600); // Column E (Old Row Data)
   logSheet.setColumnWidth(6,600); // Column F (New Row Data)

   // Format header row (assumed to be row 1)
   const headerRange = logSheet.getRange("A1:F1"); 
   headerRange.setFontSize(14);         // Set font size to larger value
   headerRange.setFontColor("blue");     // Set font color to blue 
   headerRange.setFontWeight("bold");     // Make headers bold

   // Optionally: Set background color for headers if desired
   headerRange.setBackground("#D9EAD3");   // Light green background color for headers
}

function onEdit(e) {
  const sheetName = e.source.getActiveSheet().getName();
  const excludedSheets = ['VerfifictionData', 'Template', 'DontDuplicate', '0Master', 'DataPresentation', 'logsheets'];
  const correctPassword = '5892'; // Replace with your desired password

  // Exit early for excluded sheets or non-modification events
  if (excludedSheets.includes(sheetName) || e.oldValue === undefined) return;

  const ui = SpreadsheetApp.getUi();
  const range = e.range;
  const fileName = e.source.getName(); // Get the name of the spreadsheet
  const cellAddress = range.getA1Notation(); // Get the cell address (e.g., "B2")
  const oldValue = e.oldValue || 'Empty'; // Handle case where oldValue is empty
  const newValue = e.value || 'Empty'; // Handle case where newValue is empty

  // Check if the edit is a deletion (oldValue exists and newValue is empty)
  const isDeletion = oldValue !== '' && newValue === '';

  // Show first warning dialog with filename, cell address, old value, and new value
  const firstResponse = ui.alert(
    'Warning',
    `${fileName} - You are about to ${isDeletion ? 'delete' : 'modify'} data in a monitored sheet.\n` +
    `Cell: ${cellAddress}\n` +
    `Old Value: ${oldValue}\n` +
    `New Value: ${newValue}\n` +
    `Please confirm.`,
    ui.ButtonSet.OK_CANCEL
  );

  if (firstResponse !== ui.Button.OK) {
    // Revert change if the user cancels
    range.setValue(oldValue);
    return;
  }

  // Prompt for password
  const passwordPrompt = ui.prompt(
    'Password Required',
    'Please enter the password to proceed:',
    ui.ButtonSet.OK_CANCEL
  );

  if (passwordPrompt.getSelectedButton() !== ui.Button.OK) {
    // Revert change if the user cancels the password prompt
    range.setValue(oldValue);
    return;
  }

  const enteredPassword = passwordPrompt.getResponseText();

  if (enteredPassword === correctPassword) {
    // Show second warning and confirm again
    const secondResponse = ui.alert(
      'Warning',
      `${fileName} - This is your second warning. You are about to ${isDeletion ? 'delete' : 'modify'} data.\n` +
      `Cell: ${cellAddress}\n` +
      `Old Value: ${oldValue}\n` +
      `New Value: ${newValue}\n` +
      `Do you want to proceed?`,
      ui.ButtonSet.OK_CANCEL
    );

    if (secondResponse !== ui.Button.OK) {
      // Revert the change if the user cancels the second warning
      range.setValue(oldValue);
    } else if (isDeletion) {
      // If confirmed, clear the cell value
      range.setValue('');
    }
  } else {
    // Incorrect password, revert the change
    ui.alert(
      'Incorrect Password',
      'The password you entered is incorrect. The change will be reverted.',
      ui.ButtonSet.OK
    );
    range.setValue(oldValue);
  }
}


function sortSheets() {
  var ss = SpreadsheetApp.getActiveSpreadsheet();
  var sheets = ss.getSheets();
  var sheetNames = [];
  
  // Define the priority sheets
  var prioritySheets = ['0Master', 'VerfifictionData', 'DontDuplicate', 'DataPresentation', 'Template' , 'logsheets'];

  // Create a set for quick lookup of priority sheets
  var prioritySet = new Set(prioritySheets);

  // Collect all sheet names excluding priority ones
  for (var i = 0; i < sheets.length; i++) {
    var sheetName = sheets[i].getName();
    if (!prioritySet.has(sheetName)) {
      sheetNames.push(sheetName);
    }
  }

  // Sort remaining sheet names alphabetically
  sheetNames.sort();

  // Move priority sheets first
  for (var j = 0; j < prioritySheets.length; j++) {
    if (ss.getSheetByName(prioritySheets[j])) { // Check if the sheet exists
      ss.setActiveSheet(ss.getSheetByName(prioritySheets[j]));
      ss.moveActiveSheet(j + 1); // Move to position j + 1 (1-based index)
    }
  }

  // Reorder remaining sheets based on sorted names
  for (var k = 0; k < sheetNames.length; k++) {
    ss.setActiveSheet(ss.getSheetByName(sheetNames[k]));
    ss.moveActiveSheet(k + prioritySheets.length + 1); // Adjust for priority sheets
  }
}



function readAndPresentData() {
  const ss = SpreadsheetApp.getActiveSpreadsheet();
  const sheets = ss.getSheets();
  
  // Create or clear the 'DataPresentation' sheet
  const presentationSheetName = 'DataPresentation'; // You can customize this name as needed
  let presentationSheet = ss.getSheetByName(presentationSheetName);
  if (!presentationSheet) {
    presentationSheet = ss.insertSheet(presentationSheetName);
  } else {
    presentationSheet.clear(); // Clear existing content
  }

  // Set headers for the results
  const headers = ['Date', 'Time', 'Customer Name', 'Liter', 'Filled Amount', 'Paid Amount'];
  
  presentationSheet.getRange('A1:F1').setValues([headers]); // Set header values
  
  // Apply formatting to headers
  const headerRange = presentationSheet.getRange('A1:F1');
  headerRange.setFontWeight('bold');       // Set font to bold
  headerRange.setFontSize(16);              // Set font size to 16 for headers
  headerRange.setBackground('#4CAF50');     // Set background color to green
  headerRange.setFontColor('#FFFFFF');       // Set font color to white
  headerRange.setHorizontalAlignment('center'); // Center align text

  let rowIndex = 2; // Start writing results from row 2

  const dataRows = []; // Array to hold all data rows

  // Prompt the user for a date input
  const ui = SpreadsheetApp.getUi();
  const response = ui.prompt('Enter the date to search for (format: DD.MM.YYYY):');
  
  // Check if the user clicked "OK" and entered a value
  if (response.getSelectedButton() !== ui.Button.OK || !response.getResponseText()) {
    ui.alert('No date entered. Function will exit.');
    return; // Exit if no date is provided
  }
  
  const targetDate = response.getResponseText();
  
  // Validate the date format
  const dateRegex = /^(0[1-9]|[12][0-9]|3[01])[./](0[1-9]|1[0-2])[./](\d{4})$/;
  if (!dateRegex.test(targetDate)) {
    ui.alert('Invalid date format. Please use DD.MM.YYYY.');
    return; // Exit if the format is invalid
  }

  // Convert targetDate to a Date object for comparison
  const targetDateObj = new Date(targetDate.split('.').reverse().join('-')); // Convert DD.MM.YYYY to YYYY-MM-DD

  // Loop through all sheets
  sheets.forEach(sheet => {
    const sheetName = sheet.getName();
    
    // Skip specified sheets
    if (sheetName !== 'VerfifictionData' && sheetName !== 'Template' && sheetName !== 'DontDuplicate' && sheetName !== '0Master'  && sheetName !== 'DataPresentation' && sheetName !== 'logsheets') {
      const dataRange = sheet.getRange('B14:B'); // Column B from row 14 downwards
      const dataValues = dataRange.getValues();
      
      // Loop through the data values
      for (let i = 0; i < dataValues.length; i++) {
        const dateValue = dataValues[i][0];
        
        // Check if the dateValue matches the valid date format (DD.MM.YYYY or DD/MM/YYYY)
        if (dateValue && /^(0[1-9]|[12][0-9]|3[01])[./](0[1-9]|1[0-2])[./](\d{4})$/.test(dateValue)) {
          const [day, month, year] = dateValue.split(/\.|\//); // Split by either '.' or '/'
          const currentDate = new Date(`${year}-${month}-${day}`); // Create a Date object

          // Only consider rows that match the target date
          if (currentDate.toDateString() === targetDateObj.toDateString()) {
            const timeValue = sheet.getRange(i + 14, 3).getValue(); // Column C (Time)
            const literValue = sheet.getRange(i + 14, 6).getValue(); // Column F (Liter)
            const amountJ = sheet.getRange(i + 14, 10).getValue(); // Column J (Filled Amount)
            const amountK = sheet.getRange(i + 14, 11).getValue(); // Column K (Paid Amount)

            // Format time as HH.mm and calculate total minutes for sorting
            let formattedTime = '';
            let totalMinutes = null;
            if (timeValue instanceof Date) {
              const hours = timeValue.getHours();
              const minutes = timeValue.getMinutes();
              formattedTime = `${hours}.${String(minutes).padStart(2, '0')}`; // Format as HH.mm
              totalMinutes = hours * 60 + minutes; // Calculate total minutes for sorting
            }

            // Add row data to array, including the source sheet name as "Customer Name"
            dataRows.push([dateValue, formattedTime, sheetName, literValue, amountJ, amountK, totalMinutes]); 
          }
        }
      }
    }
  });

   // Sort dataRows by total minutes in ascending order (or descending based on your requirement)
   dataRows.sort((a, b) => b[6] - a[6]); 

   // Write collected rows to the DataPresentation sheet without the total minutes column
   if (dataRows.length > 0) {
     const outputRows = dataRows.map(row => row.slice(0, -1)); // Remove totalMinutes from output
    
     presentationSheet.getRange(rowIndex, 1, outputRows.length, headers.length).setValues(outputRows);
     
     rowIndex += outputRows.length;
     
     // Center align all data in the table and set column widths
     presentationSheet.getRange(2, 1, rowIndex - 2, headers.length).setHorizontalAlignment('center'); 

     // Set font size for data rows
     presentationSheet.getRange(2, 1, rowIndex - 2, headers.length).setFontSize(14); 

     // Set column widths for better visibility of data
     presentationSheet.setColumnWidth(1,200); 
     presentationSheet.setColumnWidth(2,100);   // Width for Time column
     presentationSheet.setColumnWidth(3,200); 
     presentationSheet.setColumnWidth(4,100); 
     presentationSheet.setColumnWidth(5,200); 
   }
}




function calculateSums() {
  const ss = SpreadsheetApp.getActiveSpreadsheet();
  const sheets = ss.getSheets();
  
  // Initialize an object to store results
  const results = {};
  
  // Regular expression to match valid date formats (DD.MM.YYYY or DD/MM/YYYY)
  const dateRegex = /^(0[1-9]|[12][0-9]|3[01])[./](0[1-9]|1[0-2])[./](\d{4})$/;
  
  // Date cutoff for filtering
  const cutoffDate = new Date('2024-11-28'); // November 28, 2024

  // Loop through all sheets
  sheets.forEach(sheet => {
    const sheetName = sheet.getName();
    
    // Skip specified sheets
    if (sheetName !== 'VerfifictionData' && sheetName !== 'Template' && sheetName !== 'DontDuplicate' && sheetName !== '0Master'  && sheetName !== 'DataPresentation' && sheetName !== 'logsheets') {
      const dataRange = sheet.getRange('B14:B'); // Column B from row 14 downwards
      const dataValues = dataRange.getValues();
      
      // Loop through the data values
      for (let i = 0; i < dataValues.length; i++) {
        const dateValue = dataValues[i][0];
        
        // Check if the dateValue matches the valid date format
        if (dateRegex.test(dateValue)) { // Only process if there's a valid date format
          const [day, month, year] = dateValue.split(/\.|\//); // Split by either '.' or '/'
          const currentDate = new Date(`${year}-${month}-${day}`); // Create a Date object for comparison

          // Only consider dates greater than the cutoff date
          if (currentDate > cutoffDate) {
            const amountJ = sheet.getRange(i + 14, 10).getValue(); // Column J (10th column)
            const amountK = sheet.getRange(i + 14, 11).getValue(); // Column K (11th column)
            
            // Initialize result object for this date if it doesn't exist
            if (!results[dateValue]) {
              results[dateValue] = { sumJ: 0, sumK: 0 };
            }
            
            // Accumulate sums for J and K columns
            results[dateValue].sumJ += amountJ;
            results[dateValue].sumK += amountK;
          }
        }
      }
    }
  });
  
  // Access the 'VerfifictionData' sheet to write results
  const verificationSheet = ss.getSheetByName('VerfifictionData');
  
  if (!verificationSheet) {
    Logger.log("VerfifictionData sheet not found.");
    return; // Exit if the VerfifictionData sheet does not exist
  }

  // Read existing data from the "Amount Counted Hand" column, map it to dates
  const existingDataMap = {};
  const existingDates = verificationSheet.getRange(2, 1, verificationSheet.getLastRow() - 1).getValues();
  const existingAmounts = verificationSheet.getRange(2, 5, verificationSheet.getLastRow() - 1).getValues();

  for (let i = 0; i < existingDates.length; i++) {
    const existingDate = existingDates[i][0];
    if (existingDate) {
      existingDataMap[existingDate] = existingAmounts[i][0]; // Map the manually entered Amount Counted Hand
    }
  }

  // Clear previous results in the VerfifictionData sheet but keep headers intact
  verificationSheet.getRange('A2:F').clearContent(); // Clear all content below headers
  
  // Set headers for the results with formatting
  const headers = ['Date', 'Filled Amount', 'Paid Amount', 'Amount Received', 'Amount Counted Hand', 'Verified Data', 'logsheets'];
  verificationSheet.getRange('A1:F1').setValues([headers]); // Set header values
  
  // Apply formatting to headers
  const headerRange = verificationSheet.getRange('A1:F1');
  headerRange.setFontWeight('bold');       // Set font to bold
  headerRange.setFontSize(16);            // Set font size to 16 for headers
  headerRange.setBackground('#4CAF50');   // Set background color to green
  headerRange.setFontColor('#FFFFFF');    // Set font color to white
  headerRange.setHorizontalAlignment('center'); // Center align text

  let rowIndex = 2; // Start writing results from row 2

  // Sort results by date in descending order and write to VerfifictionData sheet
  Object.entries(results)
    .sort((a, b) => new Date(b[0].split(/\.|\//).reverse().join('-')) - new Date(a[0].split(/\.|\//).reverse().join('-'))) // Sort dates descending
    .forEach(([date, sums]) => {
      const difference = sums.sumJ - sums.sumK;

      verificationSheet.getRange(rowIndex, 1).setValue(date); // Write Date
      verificationSheet.getRange(rowIndex, 2).setValue(sums.sumJ); // Write Filled Amount (Column B)
      verificationSheet.getRange(rowIndex, 3).setValue(sums.sumK); // Write Paid Amount (Column C)
      verificationSheet.getRange(rowIndex, 4).setValue(difference); // Write Amount Received (Column D)
      
      // Retain manually entered "Amount Counted Hand"
      const countedHand = existingDataMap[date] !== undefined ? existingDataMap[date] : ""; // Use existing or blank
      verificationSheet.getRange(rowIndex, 5).setValue(countedHand); // Write Amount Counted Hand

      // Verify data if within tolerance
      if (countedHand !== "" && Math.abs(countedHand - difference) <= 1) {
        verificationSheet.getRange(rowIndex, 6).setValue('Verified').setBackground('#00FF00'); // Green for verified
      } else {
        verificationSheet.getRange(rowIndex, 6).setValue('Not Verified').setBackground('#FF0000'); // Red for not verified
      }
      
      rowIndex++;
    });

  // Center align all data in the table and set column widths
  verificationSheet.getRange(2, 1, rowIndex - 2, headers.length).setHorizontalAlignment('center'); // Center align all data
  verificationSheet.getRange(2, 1, rowIndex - 2, headers.length).setFontSize(14); // Set font size for data rows

  // Set column widths for better visibility of data
  verificationSheet.setColumnWidth(1, 200); // Width for Date column
  verificationSheet.setColumnWidth(2, 200); // Width for Filled Amount column
  verificationSheet.setColumnWidth(3, 200); // Width for Paid Amount column
  verificationSheet.setColumnWidth(4, 200); // Width for Amount Received column
  verificationSheet.setColumnWidth(5, 300); // Width for Amount Counted Hand column
  verificationSheet.setColumnWidth(6, 150); // Width for Verified Data column
}




function sendSheetAsEmail() {
    var sheet = SpreadsheetApp.getActiveSpreadsheet();
    var sheetId = sheet.getId();
    var emailAddress = "naveenkumar5892@gmail.com"; // Replace with your email address

    // Export as PDF with muteHttpExceptions
    var pdfBlob = UrlFetchApp.fetch("https://docs.google.com/spreadsheets/d/" + sheetId + "/export?format=pdf&size=A4&portrait=true", {
        headers: { "Authorization": "Bearer " + ScriptApp.getOAuthToken() },
        muteHttpExceptions: true
    }).getBlob();
    pdfBlob.setName(sheet.getName() + ".pdf");

    // Export as XLSX with muteHttpExceptions
    var xlsxBlob = UrlFetchApp.fetch("https://docs.google.com/feeds/download/spreadsheets/Export?key=" + sheetId + "&exportFormat=xlsx", {
        headers: { "Authorization": "Bearer " + ScriptApp.getOAuthToken() },
        muteHttpExceptions: true
    }).getBlob();
    xlsxBlob.setName(sheet.getName() + ".xlsx");

    // Export as CSV
    var csvData = [];
    var rows = sheet.getDataRange().getValues(); // Get all data from the sheet
    for (var i = 0; i < rows.length; i++) {
        csvData.push(rows[i].join(",")); // Join each row into a CSV format
    }
    
    // Create CSV blob from the joined string
    var csvBlob = Utilities.newBlob(csvData.join("\n"), 'text/csv', sheet.getName() + ".csv"); // Create CSV blob

    // Send Email
    MailApp.sendEmail({
        to: emailAddress,
        subject: "Google Sheet Export",
        body: "Attached are the exported files.",
        attachments: [pdfBlob, xlsxBlob, csvBlob]
    });
}


function CreateNewSheet() {
  // Get the active spreadsheet
  var ss = SpreadsheetApp.getActiveSpreadsheet();
  
  // Specify the name of the sheet you want to duplicate
  var sheetNameToDuplicate = "Template"; // Change this to your template sheet name
  
  // Prompt the user for the customer name
  var ui = SpreadsheetApp.getUi();
  var response = ui.prompt("Enter Customer Name", "Please enter the customer name:", ui.ButtonSet.OK_CANCEL);
  
  // Check if the user clicked "OK" and provided a name
  if (response.getSelectedButton() == ui.Button.OK) {
    var customerName = response.getResponseText().trim();
    
    if (customerName) {
      // Create a new sheet name using the customer name
      var newSheetName = customerName; // Use customer name as new sheet name
      
      // Get the sheet to duplicate
      var sheetToDuplicate = ss.getSheetByName(sheetNameToDuplicate);
      
      if (sheetToDuplicate) {
        // Copy the sheet and rename it
        var newSheet = sheetToDuplicate.copyTo(ss);
        newSheet.setName(newSheetName);
        
        // Fill cell A8 with the customer name
        newSheet.getRange("A8").setValue(customerName);
        
        // Optionally, you can move the new sheet to a specific position
        ss.setActiveSheet(newSheet);
        ss.moveActiveSheet(ss.getSheets().length); // Moves it to the last position
      } else {
        Logger.log("Sheet not found: " + sheetNameToDuplicate);
      }
    } else {
      ui.alert("No customer name entered. Please try again.");
    }
  } else {
    ui.alert("Operation cancelled.");
  }
}


function AllCustomerData() {
  var spreadsheet = SpreadsheetApp.getActiveSpreadsheet();
  var masterSheet = spreadsheet.getSheetByName('0Master');
  
  // Check if the master sheet exists
  if (!masterSheet) {
    Logger.log("Master sheet not found.");
    return; // Exit if the master sheet does not exist
  }

  var allSheets = spreadsheet.getSheets();
  var sourceSheets = []; // Array to hold names of sheets to monitor
  
  // Loop through all sheets and collect names except "Master"
  allSheets.forEach(function(sheet) {
    var sheetName = sheet.getName();
    if (sheetName !== 'VerfifictionData' && sheetName !== 'Template' && sheetName !== 'DontDuplicate' && sheetName !== '0Master'  && sheetName !== 'DataPresentation' && sheetName !== 'logsheets') {
      sourceSheets.push(sheetName); // Add to sourceSheets if it's not excluded
    }
  });

  var targetStartRow = 10; // Starting row for headers
  var targetColumn = 1; // Column A for sheet names

  // Clear existing data from the target range
  masterSheet.getRange(targetStartRow, targetColumn, masterSheet.getMaxRows() - targetStartRow + 1, 5).clear(); 

  // Set title with merged cells
  var titleCell = masterSheet.getRange(1, 1, 1, 5);
  
  titleCell.setValue("NACCHIYAAR AGENCY")
    .setFontSize(40) // Title font size set to 40
    .setFontWeight("bold")
    .setFontColor("#FFFFFF") // White color for title text
    .setBackground("#003366") // Dark blue background for title
    .setHorizontalAlignment("center");
  
  titleCell.merge(); // Merge cells for title

  // Set dealer information in separate rows
  var dealerInfo = [
    ["Dealer: Bharat Petroleum Corporation Limited"],
    ["GSTIN: 33ATZPN1862F1ZB"],
    ["Address: 531/5B, Velur Road, Paramathi Post 637207"],
    ["Cell: 9894394079, 9444488733"],
    ["Email: yuvabpcl@gmail.com"]
  ];

  dealerInfo.forEach(function(infoData, index) {
    var row = masterSheet.getRange(2 + index, 1); // Start from row 2 in column A
    row.setValue(infoData[0]); 
    row.setFontSize(14); // Font size for dealer info is set to **14**

    if (index % 2 === 0) {
      row.setBackground("#f9f9f9"); // Light gray background for even rows
    }
  });
  
  // Add some space below address info before table starts
  masterSheet.insertRowsAfter(dealerInfo.length + 2, 2); // Increase space between address and table rows

  // Set headers for the table
  masterSheet.getRange(targetStartRow, targetColumn).setValue("Sheet Name");
  masterSheet.getRange(targetStartRow, targetColumn + 1).setValue("Customer Name");
  masterSheet.getRange(targetStartRow, targetColumn + 2).setValue("Phone Number");
  masterSheet.getRange(targetStartRow, targetColumn + 3).setValue("Link"); // Link column comes before unpaid amount
  masterSheet.getRange(targetStartRow, targetColumn + 4).setValue("Unpaid Amount"); // Unpaid Amount is now the last column

   // Loop through each source sheet and write values to the master sheet
   sourceSheets.forEach(function(sheetName, index) {
     var sourceSheet = spreadsheet.getSheetByName(sheetName);
     if (sourceSheet) { // Check if the source sheet exists
       var customerName = sourceSheet.getRange('A8').getValue(); // Get value from cell A8 of the source sheet
       var unpaidAmount = sourceSheet.getRange('C11').getValue(); // Get value from cell C11 of the source sheet
       var phoneNumber = sourceSheet.getRange('E8').getValue(); // Get value from cell E8 of the source sheet
      
       // Write sheet name, customer name, phone number, and unpaid amount to the master sheet
       masterSheet.getRange(targetStartRow + index + 1, targetColumn).setValue(sheetName); // Sheet name in Column A
       masterSheet.getRange(targetStartRow + index + 1, targetColumn + 1).setValue(customerName); // Customer name in Column B
       masterSheet.getRange(targetStartRow + index + 1, targetColumn + 2).setValue(phoneNumber); // Phone number in Column C
      
       // Create hyperlink to the source sheet in Column D
       var linkFormula = '=HYPERLINK("https://docs.google.com/spreadsheets/d/' + spreadsheet.getId() + '/edit#gid=' + sourceSheet.getSheetId() + '", "Open ' + sheetName + '")';
       masterSheet.getRange(targetStartRow + index + 1, targetColumn + 3).setFormula(linkFormula); // Link in Column D
      
       // Write unpaid amount in Column E (last column)
       masterSheet.getRange(targetStartRow + index + 1, targetColumn + 4).setValue(unpaidAmount); // Unpaid amount in Column E
     }
   });

   formatTable(masterSheet, targetStartRow, sourceSheets.length);
}

function formatTable(sheet, startRow, numberOfRows) {
   var range = sheet.getRange(startRow,1 ,numberOfRows +1 ,5); 
   range.setBorder(true ,true ,true ,true ,true ,true); 
   range.setFontWeight("bold").setFontSize(21); // Font size for headers set to **21**

   range.getCell(1 ,1).setFontWeight("normal"); 

   sheet.getRange(startRow ,1 ,1 ,5).setBackground("#007ACC").setFontColor("#FFFFFF"); 

   // Set column widths to increase spacing (original width * 1.5)
   sheet.setColumnWidth(1 ,300); 
   sheet.setColumnWidth(2 ,300); 
   sheet.setColumnWidth(3 ,225); 
   sheet.setColumnWidth(4 ,300); 
   sheet.setColumnWidth(5 ,225); 

   range.setHorizontalAlignment("center");

   for (var i = startRow +1; i <= startRow + numberOfRows; i++) {
       var row = sheet.getRange(i ,1 ,1 ,5);
       row.setFontSize(14); // Font size for data rows set to **14**
       sheet.setRowHeight(i,30); // Set height for better spacing between rows
   }
}
```
