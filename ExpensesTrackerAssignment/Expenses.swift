//
//  Expenses.swift
//  ExpensesTrackerAssignment
//
//  Created by Ben on 26/03/2022.
//

import UIKit

class Expenses: NSObject, NSCoding
{
    var expenseName: String
    var expenseDescription: String
    var expenseReceiptDate: String
    var expenseTotalAmount: Double
    var isExpensePaid: Bool // Always false on creation
    var isExpenseVATIncluded: Bool
    var expenseAddedDate: String // Always the system's current date
    var expensePaidDate: String
    var expenseImage: UIImage?
    
    init?(expenseName:String, expenseDescription:String, expenseReceiptDate:String, expenseTotalAmount:Double, isExpenseVATIncluded:Bool, expensePaidDate: String, expenseImage:UIImage?)
    {
        if(expenseName.isEmpty || expenseDescription.isEmpty || expenseReceiptDate.isEmpty || expensePaidDate.isEmpty)
        {
            // One or more variables are empty so the init has failed
            return nil
        }
        
        // Set variables to ones being passed in to the init
        self.expenseName = expenseName
        self.expenseDescription = expenseDescription
        self.expenseReceiptDate = expenseReceiptDate
        self.expenseTotalAmount = expenseTotalAmount
        self.isExpensePaid = false
        self.isExpenseVATIncluded = isExpenseVATIncluded
        self.expenseAddedDate = Date.now.formatted(.dateTime)
        self.expensePaidDate = expensePaidDate
        self.expenseImage = expenseImage
    }
    
    // Save the expense data to the phone storage
    struct PropertyKey
    {
        static let expenseName = "expenseName"
        static let expenseDescription = "expenseDescription"
        static let expenseReceiptDate = "expenseReceiptDate"
        static let expenseTotalAmount = "expenseTotalAmount"
        static let isExpensePaid = "isExpensePaid"
        static let isExpenseVATIncluded = "isExpenseVATIncluded"
        static let expenseAddedDate = "expenseAddedDate"
        static let expensePaidDate = "expensePaidDate"
        static let expenseImage = "expenseImage"
    }
    
    // Obtain a URL for a unique directory on the phone to store application data
    static let DataDirectory = FileManager().urls(for:.documentDirectory, in:.userDomainMask).first!
    
    // Add a directory in the directory to store expenses
    static let ArchiveURL = DataDirectory.appendingPathComponent("expenses")
    
    // Encode the data being stored conforming to NSCoding principles
    func encode(with coder: NSCoder) {
        coder.encode(expenseName, forKey:PropertyKey.expenseName)
        coder.encode(expenseDescription, forKey:PropertyKey.expenseDescription)
        coder.encode(expenseReceiptDate, forKey:PropertyKey.expenseReceiptDate)
        coder.encode(expenseTotalAmount, forKey:PropertyKey.expenseTotalAmount)
        coder.encode(isExpensePaid, forKey:PropertyKey.isExpensePaid)
        coder.encode(isExpenseVATIncluded, forKey:PropertyKey.isExpenseVATIncluded)
        coder.encode(expenseAddedDate, forKey:PropertyKey.expenseAddedDate)
        coder.encode(expensePaidDate, forKey:PropertyKey.expensePaidDate)
        coder.encode(expenseImage, forKey:PropertyKey.expenseImage)
    }
    
    // Secondary constructor to use when it is convenient
    //
    required convenience init?(coder: NSCoder) {
        // Ensure the information can be decoded
        guard let expenseName = coder.decodeObject(forKey:PropertyKey.expenseName) as? String
        else
        {
            print("[ERROR] Unable to decode Expense Name...")
            return nil;
        }
        
        guard let expenseDescription = coder.decodeObject(forKey:PropertyKey.expenseDescription) as? String
        else
        {
            print("[ERROR] Unable to decode Expense Description...")
            return nil;
        }
        
        guard let expenseReceiptDate = coder.decodeObject(forKey:PropertyKey.expenseReceiptDate) as? String
        else
        {
            print("[ERROR] Unable to decode Expense Receipt Date...")
            return nil;
        }
        
        guard let expenseTotalAmount = coder.decodeObject(forKey:PropertyKey.expenseTotalAmount) as? Double
        else
        {
            print("[ERROR] Unable to decode Expense Total Amount...")
            return nil;
        }
        
        guard let isExpenseVATIncluded = coder.decodeObject(forKey:PropertyKey.isExpenseVATIncluded) as? Bool
        else
        {
            print("[ERROR] Unable to decode Expense VAT Included Flag...")
            return nil;
        }
        
        guard let expensePaidDate = coder.decodeObject(forKey:PropertyKey.expensePaidDate) as? String
        else
        {
            print("[ERROR] Unable to decode Expense Paid Date...")
            return nil;
        }
        
        guard let expenseImage = coder.decodeObject(forKey:PropertyKey.expenseImage) as? UIImage
        else
        {
            print("[ERROR] Unable to decode Expense Image...")
            return nil;
        }
        
        self.init(expenseName:expenseName, expenseDescription:expenseDescription, expenseReceiptDate:expenseReceiptDate, expenseTotalAmount:expenseTotalAmount, isExpenseVATIncluded:isExpenseVATIncluded, expensePaidDate:expensePaidDate, expenseImage:expenseImage)
    }
}

