//
//  ViewController.swift
//  ExpensesTrackerAssignment
//
//  Created by Ben on 26/03/2022.
//

import UIKit

class ExpenseViewController: UIViewController
{
    var expense:Expenses?
    
    @IBOutlet weak var saveExpenseButton: UIBarButtonItem!
    
    @IBAction func cancelExpenseCreation(_ sender: Any)
    {
        // If cancelled, dismiss the modal view
        dismiss(animated: true, completion: nil)
    }
    
    
    // Outlets for each element in the edit expense page
    @IBOutlet weak var expenseUIImage: UIImageView!
    @IBOutlet weak var expenseNameTextField: UITextField!
    @IBOutlet weak var expenseTotalAmountTextField: UITextField!
    @IBOutlet weak var isExpensePaidSwitch: UISwitch!
    @IBOutlet weak var expenseDescriptionTextField: UITextField!
    @IBOutlet weak var expenseReceiptDatePicker: UIDatePicker!
    @IBOutlet weak var isVATIncludedSwitch: UISwitch!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Round the corners of each UIView
        //descriptionView.layer.cornerRadius = 10
        //receiptDateView.layer.cornerRadius = 10
        //totalAmountView.layer.cornerRadius = 10
        //dateAddedView.layer.cornerRadius = 10
        //paidDateView.layer.cornerRadius = 10
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Check to see if the save button was pressed
        guard let button = sender as? UIBarButtonItem, button === saveExpenseButton
        else
        {
            return
        }
        
        // If the save button was pressed, the follow code will run
        let expenseImage = expenseUIImage.image
        let expenseName = expenseNameTextField.text ?? ""
        let expenseTotalAmount = Double(expenseTotalAmountTextField.text!) ?? 0
        let expenseDescription = expenseDescriptionTextField.text ?? ""
        let expenseReceiptDate = expenseReceiptDatePicker.date.formatted()
        let isVATIncluded = isVATIncludedSwitch.isOn
        
        expense = Expenses(expenseName: expenseName, expenseDescription: expenseDescription, expenseReceiptDate: expenseReceiptDate, expenseTotalAmount: expenseTotalAmount, isExpenseVATIncluded: isVATIncluded, expenseImage: expenseImage)
    }

}

