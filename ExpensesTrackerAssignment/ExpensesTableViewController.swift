//
//  ExpensesTableViewController.swift
//  ExpensesTrackerAssignment
//
//  Created by Ben on 26/03/2022.
//

import UIKit

class ExpensesTableViewController: UITableViewController, UISearchBarDelegate
{

    // Create the array of Expenses
    var expensesArray:[Expenses] = []
    
    // Array used for searching/sorting to display in table view
    var filteredExpensesArray:[Expenses] = []
    
    
    @IBOutlet weak var expenseSearchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If there is data to be loaded, load it
        // If not, the application is running for the
        // first time so load without data
        if let savedExpenses = loadExpenses()
        {
            expensesArray = savedExpenses
            print("Loading Saved Expenses")
        }
        else
        {
            print("[INFO] First time loading the application, no data to be loaded.")
        }
        
        // Sort the expenses array
        sortExpenses()
        
        
        // Copy the expenses array into the filtered array
        filteredExpensesArray = expensesArray

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Display an Edit button in the navigation bar
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredExpensesArray.count
    }


    // Configure each custom cell with the correct expense information
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ExpenseCell", for: indexPath) as? ExpenseTableViewCell
        else
        {
            fatalError("[ERROR] Unable to generate cell...")
        }
        
        // Configure the custom cell...
        cell.expenseNameCellLabel.text = filteredExpensesArray[indexPath.row].expenseName
        cell.expenseDateCellLabel.text = filteredExpensesArray[indexPath.row].expenseAddedDate
        
        if(filteredExpensesArray[indexPath.row].isExpensePaid == true)
        {
            cell.expenseIsPaidUIImage.image = UIImage(named: "expensePaidImage")
        }
        else
        {
            cell.expenseIsPaidUIImage.image = UIImage(named: "expenseUnpaidImage")
        }
        
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        // Return false if you do not want the specified item to be editable.
        
        // If the expense has been marked as paid, then the user is no longer
        // ages to delete the expense. This is to retain the paid expense for documentation
        if(filteredExpensesArray[indexPath.row].isExpensePaid == true)
        {
            return false
        }
        else
        {
            return true
        }
        //return true
    }
    

    // Swipe to mark as paid
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let editSwipeAction = UIContextualAction(style: .normal, title: "Mark as Paid") {(editSwipeAction, view, completionHandler) in self.markAsPaid(indexPath: indexPath)}
            
        editSwipeAction.backgroundColor = .systemGreen
        return UISwipeActionsConfiguration(actions: [editSwipeAction])
    }
        
    // The index path of cell being swiped is passed to this function to mark
    // it as paid. Once marked, the table is reloaded to update it.
    private func markAsPaid(indexPath:IndexPath)
    {
        // The expense being marked as paid
        let expenseToBeMarkedAsPaid = filteredExpensesArray[indexPath.row]
        
        // Edit the expense in the filtered expense array
        filteredExpensesArray[indexPath.row].isExpensePaid = true
        
        // Mark the expense as paid
        for expense in indexPath.row ..< expensesArray.count
        {
            if(expensesArray[expense].expenseName == expenseToBeMarkedAsPaid.expenseName && expensesArray[expense].expenseAddedDate == expenseToBeMarkedAsPaid.expenseAddedDate)
            {
                // Remove the correct element and break from the loop
                expensesArray[indexPath.row].isExpensePaid = true
                break
            }
        }
        
        // After marking expense as paid, set the search scope index to 0
        expenseSearchBar.selectedScopeButtonIndex = 0
        
        // Set the filtered expense array to the expense array as the search scope
        // index has been changed to 0
        filteredExpensesArray = expensesArray
        
        // Reload the table data to account for edits made
        tableView.reloadData()
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            // Delete the row from the data source
            print("[INFO] Deleting \(filteredExpensesArray[indexPath.row].expenseName) expense.")
            
            // The expense being removed
            let expenseToDelete = filteredExpensesArray[indexPath.row]
            
            filteredExpensesArray.remove(at:indexPath.row)
            //expensesArray.remove(at:indexPath.row)
            // Search for correct contact to remove from original expensesArray
            
            // Using the expense name and the expense time, compare expenses in the
            // original list to find the correct one to remove
            //
            // The expense added time offers a unique key identifier as the time is exact
            for expense in indexPath.row ..< expensesArray.count
            {
                if(expensesArray[expense].expenseName == expenseToDelete.expenseName && expensesArray[expense].expenseAddedDate == expenseToDelete.expenseAddedDate)
                {
                    // Remove the correct element and break from the loop
                    expensesArray.remove(at: expense)
                    break
                }
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            saveExpenses()
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        // Call the parent and let them know to segue
        super.prepare(for: segue, sender: sender)
        
        
        switch(segue.identifier ?? "")
        {
        case "ViewExpense":
            // Prepare to display the expense on the view page
            
            // Obtain the new view controller from the segue destination
            guard let expenseViewController = segue.destination as? ExpenseViewController
            else
            {
                print("[ERROR] Unable to obtain ExpenseViewController...")
                break
            }
            
            // Obtain the index path from the table view selected row
            guard let indexPath = tableView.indexPathForSelectedRow
            else
            {
                print("[ERROR] Unable to obtain index path...")
                break
            }
            
            // Grab the corrisponding expense from the expense array using
            // the previously obtained index path
            let selectedExpense = filteredExpensesArray[indexPath.row]
            expenseViewController.expense = selectedExpense
            
            break
            
        case "AddExpense":
            print("Reached 'AddExpense' switch case")
            
            
            break

        default:
            break
        }
    }
    
    
    
    @IBAction func unwindToExpenses(sender:UIStoryboardSegue)
    {
        if let sourceViewController = sender.source as? ExpenseEditViewController, let expense = sourceViewController.expense
        {
            // Check if editing or adding an expense
            if let selectedIndexPath = tableView.indexPathForSelectedRow
            {
                let expenseToEdit = filteredExpensesArray[selectedIndexPath.row]
                
                // If there is a selected row in the table, then edit
                filteredExpensesArray[selectedIndexPath.row] = expense
                
                // Using the expense name and the expense time, compare expenses in the
                // original list to find the correct one to edit
                //
                // The expense added time offers a unique key identifier as the time is exact
                for expenseCount in selectedIndexPath.row ..< expensesArray.count
                {
                    if(expensesArray[expenseCount].expenseName == expenseToEdit.expenseName && expensesArray[expenseCount].expenseAddedDate == expenseToEdit.expenseAddedDate)
                    {
                        print("Found an expense that matches")
                        expensesArray[expenseCount] = expense
                        
                        // Sort the expenses after one is edited
                        sortExpenses()
                        break
                    }
                }
                
                // Update the table view
                tableView.reloadRows(at:[selectedIndexPath], with:.none)
            }
            else
            {
                // There is no selected row in the table, then add
                // Add the new expense to the array from the segue
                filteredExpensesArray.append(expense)
                expensesArray.append(expense)
                
                // Sort the expenses after a new one is added
                sortExpenses()
                
                // Update the table at the correct index path
                let newIndexPath = IndexPath(row:filteredExpensesArray.count-1, section:0)
                tableView.insertRows(at:[newIndexPath], with:.automatic)
                
                // Clear the search bar
                // TODO: Update the table
                expenseSearchBar.text = ""
            }
            
            // After marking expense as paid, set the search scope index to 0
            expenseSearchBar.selectedScopeButtonIndex = 0
            
            // Set the filtered expense array to the expense array as the search scope
            // index has been changed to 0
            filteredExpensesArray = expensesArray
            
            // Reload the table to display the up-to-date array
            tableView.reloadData()
            
            // Ensure the expenses are saved to the device after editing/added
            saveExpenses()
        }
    }

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        // Only display filtered result if the search bar isn't empty
        if(searchText.isEmpty)
        {
            filteredExpensesArray = expensesArray
        }
        else
        {
            // Search for text input in search bar
            filteredExpensesArray = expensesArray.filter({expense -> Bool in return
                                    expense.expenseName.lowercased().contains(searchText.lowercased())})
        }
        
        // Update the table view
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int)
    {
        // Clear the search bar when changing scope so the search remains accurate
        searchBar.text = ""
        
        // Gets the title of the selected search scope
        let selectedScopeText = searchBar.scopeButtonTitles![selectedScope]
        
        switch(selectedScopeText)
        {
        case "All":
            // Display all of the expenses in the list
            filteredExpensesArray = expensesArray
            break
            
        case "Paid":
            // Display all of the paid expenses in the list
            filteredExpensesArray = expensesArray.filter({expense -> Bool in return expense.isExpensePaid == true})
            break
            
        case "Unpaid":
            // Display all of the unpaid expenses in the list
            filteredExpensesArray = expensesArray.filter({expense -> Bool in return expense.isExpensePaid != true})
            break
            
        default:
            break
        }
        
        // Update the table view
        tableView.reloadData()
    }
    
    
    // MARK: Private Methods
    private func saveExpenses()
    {
        let isSaveSuccessful = NSKeyedArchiver.archiveRootObject(expensesArray, toFile: Expenses.ArchiveURL.path)
        
        if(!isSaveSuccessful)
        {
            print("[ERROR] Save was unsuccessful...")
        }
    }
    
    private func loadExpenses() -> [Expenses]?
    {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Expenses.ArchiveURL.path) as? [Expenses]
    }
    
    
    private func sortExpenses()
    {
        // Sort the expenses array
        expensesArray.sort(by: {$0.expenseReceiptDate > $1.expenseReceiptDate})
        filteredExpensesArray.sort(by: {$0.expenseReceiptDate > $1.expenseReceiptDate})
    }
}
