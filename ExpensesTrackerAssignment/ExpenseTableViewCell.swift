//
//  ExpenseTableViewCell.swift
//  ExpensesTrackerAssignment
//
//  Created by Ben on 29/03/2022.
//

import UIKit

class ExpenseTableViewCell: UITableViewCell
{

    @IBOutlet weak var expenseNameCellLabel: UILabel!
    @IBOutlet weak var expenseDateCellLabel: UILabel!
    @IBOutlet weak var expenseIsPaidUIImage: UIImageView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
