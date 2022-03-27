//
//  ViewController.swift
//  ExpensesTrackerAssignment
//
//  Created by Ben on 26/03/2022.
//

import UIKit

class ExpenseViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate
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
    
    // Outlets for each element in the view expense page
    @IBOutlet weak var expenseViewUIImage: UIImageView!
    @IBOutlet weak var expenseViewNameLabel: UILabel!
    @IBOutlet weak var expenseViewDescriptionLabel: UILabel!
    @IBOutlet weak var expenseViewReceiptDateLabel: UILabel!
    @IBOutlet weak var expenseViewTotalAmountLabel: UILabel!
    @IBOutlet weak var expenseViewDateAddedLabel: UILabel!
    @IBOutlet weak var expenseViewPaidDateLabel: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // If there isn't an existing expense, the if statement will not run
        // If there is an existing expense to view, expense can be unwrapped
        if let expense = expense
        {
            expenseViewUIImage.image = expense.expenseImage
            expenseViewNameLabel.text = expense.expenseName
            expenseViewDescriptionLabel.text = expense.expenseDescription
            expenseViewReceiptDateLabel.text = expense.expenseReceiptDate
            expenseViewTotalAmountLabel.text = String(expense.expenseTotalAmount)
            expenseViewDateAddedLabel.text = expense.expenseAddedDate
            expenseViewPaidDateLabel.text = expense.expensePaidDate
        }
        
        // Round the corners of each UIView
        //descriptionView.layer.cornerRadius = 10
        //receiptDateView.layer.cornerRadius = 10
        //totalAmountView.layer.cornerRadius = 10
        //dateAddedView.layer.cornerRadius = 10
        //paidDateView.layer.cornerRadius = 10
    }
    
    
    // This action is connected to both the image
    // and the 'Edit Image' label under the image
    //
    // It allows the user to select an image for the expense
    // they are creating or editing
    @IBAction func selectExpenseImageFromLibrary(_ sender: Any)
    {
        // Force dismiss the keyboard to ensure nothing is blocking
        expenseNameTextField.resignFirstResponder()
        
        // Launch UIImagePickerController to select an image from library
        let expenseImagePickerController = UIImagePickerController()

        
        // Set the delegate to the current class
        expenseImagePickerController.delegate = self
        
        // Present the image picker controller
        present(expenseImagePickerController, animated: true, completion: nil)
    }
    
    // If the image picker controller is cancelled, then
    // it will be dismissed and nothing will be changed
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    
    // If the user chooses an image, the chosen image will
    // replace the current expense image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        guard let newExpenseImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        else
        {
            // If the image cannot be a UIImage, then the image picker
            // controller is dismissed without changing anything
            dismiss(animated: true, completion: nil)
            print("[ERROR] Unable to load selected image.")
            return
        }
        
        // If the image doesn't flag any errors, then
        // it replaces the old image
        expenseUIImage.image = newExpenseImage
        dismiss(animated: true, completion: nil)
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

