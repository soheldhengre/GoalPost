//
//  GoalCell.swift
//  GoalPost
//
//  Created by Sohel Dhengre on 29/03/18.
//  Copyright © 2018 Sohel Dhengre. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var goalDescription: UILabel!
    @IBOutlet weak var goalType: UILabel!
    @IBOutlet weak var noOFDays: UILabel!
    @IBOutlet weak var completionView: UIView!
    
    
    func configureCell(goal: Goal){
        self.goalDescription.text = goal.goalDescription
        self.goalType.text = goal.goalType
        self.noOFDays.text = String(describing: goal.goalProgress)
        
        if goal.goalProgress == goal.goalCompletionValue {
            self.completionView.isHidden = false
        } else {
            self.completionView.isHidden = true
        }
    }

}
