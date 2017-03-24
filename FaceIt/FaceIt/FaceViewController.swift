//
//  ViewController.swift
//  FaceIt
//
//  Created by Yonglin on 16/03/2017.
//  Copyright © 2017 Yonglin. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {
    
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            let handler = #selector(FaceView.changeScale(byReactingTo:))
            let pinchRecognizer = UIPinchGestureRecognizer(target:faceView, action: handler)
            faceView.addGestureRecognizer(pinchRecognizer)
            
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleEyes(byReactingTo:)))
            tapRecognizer.numberOfTapsRequired = 1
            faceView.addGestureRecognizer(tapRecognizer)
            
            let swipUpRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(increseHappiness))
            swipUpRecognizer.direction = .up
            faceView.addGestureRecognizer(swipUpRecognizer)
            
            let swipDownRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(decressHappiness))
            swipDownRecognizer.direction = .down
            faceView.addGestureRecognizer(swipDownRecognizer)
            
            updateUI()
        }
    }

    private let mouthCurvatures = [FacialExpression.Mouth.grin : 0.5, .frown: -1.0, .smile: 1.0, .neutral: 0.0, .smirk: -0.5]
    
    var expression = FacialExpression(eyes: .closed, mouth: .grin) {
        didSet {
            updateUI()
        }
    }
    
    func toggleEyes(byReactingTo tapRecognizer: UITapGestureRecognizer) {
        if tapRecognizer.state == .ended {
            let eyes: FacialExpression.Eyes = (expression.eyes == .closed) ? .open : .closed
            expression = FacialExpression(eyes: eyes, mouth: expression.mouth)
        }
    }
    
    func increseHappiness(){
        expression = expression.happier
        
    }
    
    func decressHappiness(){
        expression = expression.sadder
    }
    
    private func updateUI() {
        switch expression.eyes {
        case .open:
            faceView?.eyesOpen = true
        case .closed:
            faceView?.eyesOpen = false
        case .squinting:
            faceView?.eyesOpen = false
        }
        faceView?.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
        
    }
}

