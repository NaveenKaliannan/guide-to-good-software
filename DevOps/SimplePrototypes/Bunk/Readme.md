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
  var masterSheet = spreadsheet.getSheetByName('Master');
  
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
    if (sheetName !== 'Master' && sheetName !== 'Template') {
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
