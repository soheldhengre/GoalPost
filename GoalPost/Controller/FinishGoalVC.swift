//
//  FinishGoalVC.swift
//  GoalPost
//
//  Created by Sohel Dhengre on 02/04/18.
//  Copyright © 2018 Sohel Dhengre. All rights reserved.
//

import UIKit

class FinishGoalVC: UIViewController {

    @IBOutlet weak var createGoalBtn: UIButton!
    @IBOutlet weak var pointsTxtField: UITextField!
    
    var desc:String!
    var goalType: GoalType!

    func initData(description:String, type: GoalType) {
        self.desc = description
        self.goalType = type
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalBtn.bindToKeyboard()
        
    }
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissVC()
    }
    
    @IBAction func createGoalPressed(_ sender: Any) {
        if pointsTxtField.text != "" {
            self.save(completion: { (completion) in
                if completion{
                    self.performSegue(withIdentifier: "dismissToHome", sender: self)
                }
            })
        }
    }
    
    func save(completion:@escaping (_ status:Bool)->()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let goal = Goal(context: managedContext)
        goal.goalDescription = desc
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(pointsTxtField.text!)!
        goal.goalProgress = Int32(0)
        
        do {
            try managedContext.save()
            completion(true)
        } catch  {
            debugPrint("Error: \(error.localizedDescription)")
            completion(false)
        }
    }
}
