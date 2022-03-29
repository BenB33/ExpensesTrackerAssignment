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
    
    // Outlets for each element in the view expense page
    @IBOutlet weak var expenseViewUIImage: UIImageView!
    @IBOutlet weak var expenseViewNameLabel: UILabel!
    @IBOutlet weak var expenseViewDescriptionLabel: UILabel!
    @IBOutlet weak var expenseViewReceiptDateLabel: UILabel!
    @IBOutlet weak var expenseViewTotalAmountLabel: UILabel!
    @IBOutlet weak var expenseViewDateAddedLabel: UILabel!
    @IBOutlet weak var expenseViewPaidDateLabel: UILabel!
    
    // When the UI Image in the view expense page is tapped,
    // the image expands full screen to allow for better viewing
    @IBAction func expandExpenseViewUIImage(_ sender: UITapGestureRecognizer)
    {
        let fullscreenImage = sender.view as! UIImageView
        let newImageView = UIImageView(image: fullscreenImage.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        
        let tapFullscreenImage = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tapFullscreenImage)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // When the fullscreen image is tapped, the fullscreen image
    // is removed and the view expense page is visible again
    @objc func dismissFullscreenImage(sender: UITapGestureRecognizer)
    {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
    
    // UIView containers on View Expenses page
    @IBOutlet weak var expenseDescriptionUIView: UIView!
    @IBOutlet weak var expenseReceiptDateUIView: UIView!
    @IBOutlet weak var expenseTotalAmountUIView: UIView!
    @IBOutlet weak var expenseDateAddedUIView: UIView!
    @IBOutlet weak var expensePaidDateUIView: UIView!

    
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

            if(expense.isExpenseVATIncluded)
            {
                // If the user determines VAT is already included in the total amount
                // Then no changes need to be made and the user determined amount can
                // be displayed. Adding the inc VAT tag
                let totalAmountWithVAT = String(expense.expenseTotalAmount) + " inc VAT"
                
                expenseViewTotalAmountLabel.text = totalAmountWithVAT
            }
            else
            {
                // Because the total amount doesn't include VAT, it will be added on by the line below
                // and the amount with the VAT added will be displayed with the inc VAT tag.
                let totalAmountAddingVAT = expense.expenseTotalAmount + (expense.expenseTotalAmount * 0.2)
                
                let totalAmountWithVAT = String(totalAmountAddingVAT) + " inc VAT"
                
                expenseViewTotalAmountLabel.text = totalAmountWithVAT
            }

            expenseViewDateAddedLabel.text = expense.expenseAddedDate
            expenseViewPaidDateLabel.text = expense.expensePaidDate
            
            // Round the corners of each UIView
            expenseDescriptionUIView.layer.cornerRadius = 10
            expenseReceiptDateUIView.layer.cornerRadius = 10
            expenseTotalAmountUIView.layer.cornerRadius = 10
            expenseDateAddedUIView.layer.cornerRadius = 10
            expensePaidDateUIView.layer.cornerRadius = 10
        }
    }
}
