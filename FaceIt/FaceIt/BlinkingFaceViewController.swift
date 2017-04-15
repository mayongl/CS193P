//
//  BlinkingFaceViewController.swift
//  FaceIt
//
//  Created by Yonglin on 15/04/2017.
//  Copyright © 2017 Yonglin. All rights reserved.
//

import UIKit

class BlinkingFaceViewController: FaceViewController {
    var blinking = false {
        didSet {
            blinkIfNeeded()
        }
    }
    
    
    private struct BlinkRate {
        static let closeDuration: TimeInterval = 0.4
        static let openDuration: TimeInterval = 2.5
    }
    
    func blinkIfNeeded() {
        if blinking {
            faceView.eyesOpen = false
            Timer.scheduledTimer(withTimeInterval: BlinkRate.closeDuration, repeats: false) { [weak self] timer in
                self?.faceView.eyesOpen = true
                Timer.scheduledTimer(withTimeInterval: BlinkRate.openDuration   , repeats: false) { [weak self] timer in
                    self?.blinkIfNeeded()
                }
            }
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        blinking = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        blinking = false
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
