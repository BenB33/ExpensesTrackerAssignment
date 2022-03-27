//
//  ExpensesTableViewController.swift
//  ExpensesTrackerAssignment
//
//  Created by Ben on 26/03/2022.
//

import UIKit

class ExpensesTableViewController: UITableViewController
{

    // Create the array of Expenses that will be displayed in the list
    var expensesArray:[Expenses] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return expensesArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpenseCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = expensesArray[indexPath.row].expenseName
        cell.detailTextLabel?.text = expensesArray[indexPath.row].expenseDescription
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
        case "AddExpense":
            
            break
            
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
            let selectedExpense = expensesArray[indexPath.row]
            expenseViewController.expense = selectedExpense
            
            break
            
        case "EditExpense":
            guard let expenseViewController = segue.destination as? ExpenseViewController
            else
            {
                print("[ERROR] Unable to obtain ExpenseViewController")
                break
            }
            
            guard let indexPath = tableView.indexPathForSelectedRow
            else
            {
                print("[ERROR] Unable to obtain index path")
                break
            }
            
            let selectedExpense = expensesArray[indexPath.row]
            expenseViewController.expense = selectedExpense
            break
            
        default:
            break
        }
    }
    
    
    
    @IBAction func unwindToExpenses(sender:UIStoryboardSegue)
    {
        if let sourceViewController = sender.source as? ExpenseViewController, let expense = sourceViewController.expense
        {
            // Check if editing or adding an expense
            if let selectedIndexPath = tableView.indexPathForSelectedRow
            {
                // If there is a selected row in the table, then edit
                expensesArray[selectedIndexPath.row] = expense
                
                // Update the table view
                tableView.reloadRows(at:[selectedIndexPath], with:.none)
            }
            else
            {
                // There is no selected row in the table, then add
                // Add the new expense to the array from the segue
                expensesArray.append(expense)
            }
            

            
            // Update the table at the correct index path
            let newIndexPath = IndexPath(row:expensesArray.count-1, section:0)
            tableView.insertRows(at:[newIndexPath], with:.automatic)
        }
    }

}
