//
//  UIViewControllerExt.swift
//  GoalPost
//
//  Created by Sohel Dhengre on 29/03/18.
//  Copyright © 2018 Sohel Dhengre. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func presentVC(_ viewControllerToPresent: UIViewController){
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        present(viewControllerToPresent, animated: false, completion: nil)
    }
    
    func dismissVC(){
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false, completion: nil)
        
    }
}
