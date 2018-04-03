//
//  ViewController.swift
//  GoalPost
//
//  Created by Sohel Dhengre on 29/03/18.
//  Copyright © 2018 Sohel Dhengre. All rights reserved.
//

import UIKit
import CoreData

var appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalsVC: UIViewController {

    var goals: [Goal] = []
    
   
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchTableViewData()
        tableView.reloadData()
    }
    
    func fetchTableViewData(){
        self.fetch { (completion) in
            if completion{
                if self.goals.count >= 1 {
                    self.tableView.isHidden = false
                } else {
                    self.tableView.isHidden = true
                }
            }
        }
    }

    @IBAction func unwindToContainerVC(segue: UIStoryboardSegue) {
    }
   
    @IBAction func addGoalPressed(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "createGoalVC") else {return}
        presentVC(vc)
        
    }
}

extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else {return UITableViewCell()}
        let goal = goals[indexPath.row]
        cell.configureCell(goal: goal)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, index) in
            self.removeGoals(atIndexPath: index)
            self.fetchTableViewData()
            tableView.deleteRows(at: [index], with: .automatic)
        }
        
        let progressAction = UITableViewRowAction(style: .normal, title: "ADD 1") { (rowAction, index) in
            self.setProgress(atIndexPath: index)
            tableView.reloadRows(at: [index], with: .automatic)
        }
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        progressAction.backgroundColor = #colorLiteral(red: 0.9385011792, green: 0.7164435983, blue: 0.3331357837, alpha: 1)
        return [deleteAction,progressAction]
    }
}

extension GoalsVC {
    
    func setProgress(atIndexPath indexpath:IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let chosenGoal = goals[indexpath.row]
        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue {
            chosenGoal.goalProgress += 1
        } else {
            return
        }
        
        do {
            try managedContext.save()
        } catch  {
            debugPrint("Could not save: \(error.localizedDescription)")
        }
    }
    
    func removeGoals(atIndexPath indexpath:IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        managedContext.delete(goals[indexpath.row])
        
        do {
            try managedContext.save()
            print("successful")
        } catch  {
            debugPrint("Could not load: \(error.localizedDescription)")
        }
    }
    
    func fetch(completion: @escaping (_ status: Bool)->()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
        do {
            goals = try managedContext.fetch(fetchRequest) as! [Goal]
            completion(true)
        } catch  {
            debugPrint("could not load: \(error.localizedDescription)")
            completion(false)
        }
    }
}

