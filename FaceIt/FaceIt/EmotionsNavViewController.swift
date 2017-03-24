//
//  EmotionsNavViewController.swift
//  FaceIt
//
//  Created by Yonglin Ma on 3/23/17.
//  Copyright © 2017 Yonglin. All rights reserved.
//

import UIKit

class EmotionsNavViewController: UINavigationController, UINavigationControllerDelegate {
    private var displayed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UINavigationControllerDelegate
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if displayed == false {
            displayed = true
            popViewController(animated: true)
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
