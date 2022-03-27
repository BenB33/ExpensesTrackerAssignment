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
    
    @IBOutlet weak var expenseNameLabel: UILabel!
    @IBOutlet weak var expenseUIImage: UIImageView!
    @IBOutlet weak var expenseDescriptionLabel: UILabel!
    @IBOutlet weak var expenseReceiptDateLabel: UILabel!
    @IBOutlet weak var expenseTotalAmountLabel: UILabel!
    @IBOutlet weak var expenseDateAddedLabel: UILabel!
    @IBOutlet weak var expensePaidDateLabel: UILabel!
    
    // UIViews that contain labels
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var receiptDateView: UIView!
    @IBOutlet weak var totalAmountView: UIView!
    @IBOutlet weak var dateAddedView: UIView!
    @IBOutlet weak var paidDateView: UIView!
    
    
    
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


}

