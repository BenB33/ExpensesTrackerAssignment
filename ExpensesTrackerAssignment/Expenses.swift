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
    
    init?(expenseName:String, expenseDescription:String, expenseReceiptDate:String, expenseTotalAmount:Double, isExpenseVATIncluded:Bool, expenseImage:UIImage?, isExpensePaid:Bool)
    {
        if(expenseName == "" || expenseDescription == "" || expenseReceiptDate == "")
        {
            // One or more variables are empty so the init has failed
            return nil
        }
        
        // Set variables to ones being passed in to the init
        self.expenseName = expenseName
        self.expenseDescription = expenseDescription
        self.expenseReceiptDate = expenseReceiptDate
        self.expenseTotalAmount = expenseTotalAmount
        self.isExpensePaid = isExpensePaid
        self.isExpenseVATIncluded = isExpenseVATIncluded
        self.expenseAddedDate = Date.now.formatted(.dateTime)
        self.expensePaidDate = "Unpaid"
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
            return nil
        }
        
        guard let expenseDescription = coder.decodeObject(forKey:PropertyKey.expenseDescription) as? String
        else
        {
            print("[ERROR] Unable to decode Expense Description...")
            return nil
        }
        
        guard let expenseReceiptDate = coder.decodeObject(forKey:PropertyKey.expenseReceiptDate) as? String
        else
        {
            print("[ERROR] Unable to decode Expense Receipt Date...")
            return nil
        }
        
        guard let expenseImage = coder.decodeObject(forKey:PropertyKey.expenseImage) as? UIImage
        else
        {
            print("[ERROR] Unable to decode Expense Image...")
            return nil
        }
        
        // Decoding a double using .decodeDouble so decoding cannot fail
        let expenseTotalAmount = coder.decodeDouble(forKey:PropertyKey.expenseTotalAmount)
        
        // Decoding a Bool using .decodeBool so decoding cannot fail
        let isExpenseVATIncluded = coder.decodeBool(forKey:PropertyKey.isExpenseVATIncluded)
        
        // Decoding a Bool using .decodeBool so decoding cannot fail
        let isExpensePaid = coder.decodeBool(forKey:PropertyKey.isExpensePaid)
        
        // Call to the init function using the decoded values
        self.init(expenseName:expenseName, expenseDescription:expenseDescription, expenseReceiptDate:expenseReceiptDate, expenseTotalAmount:expenseTotalAmount, isExpenseVATIncluded:isExpenseVATIncluded, expenseImage:expenseImage, isExpensePaid:isExpensePaid)
    }
}

