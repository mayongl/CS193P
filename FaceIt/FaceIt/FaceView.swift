//
//  FaceView.swift
//  FaceIt
//
//  Created by Yonglin on 16/03/2017.
//  Copyright © 2017 Yonglin. All rights reserved.
//

import UIKit


@IBDesignable
class FaceView: UIView {
    var scale: CGFloat = 0.9 { didSet { setNeedsDisplay() } }
    @IBInspectable    
    var eyesOpen: Bool = true  {
        didSet {
            leftEye.eyesOpen = eyesOpen
            rightEye.eyesOpen = eyesOpen
            setNeedsDisplay()
        }
    }
    @IBInspectable
    var mouthCurvature: Double = 1.0  { didSet { setNeedsDisplay() } }   //1.p is full smile and -1.0 is full frown
    
    var lineWidth: CGFloat = 5.0 { didSet { setNeedsDisplay() } }
    
    private var skullRadius : CGFloat {
        return min(bounds.size.width, bounds.size.height)/2 * scale
    }
    
    private var skullCenter : CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    private enum Eye
    {
        case left
        case right
    }
    
    func changeScale(byReactingTo pinchRecognizer: UIPinchGestureRecognizer) {
        switch pinchRecognizer.state {
        case .changed, .ended:
            scale *= pinchRecognizer.scale
            pinchRecognizer.scale = 1
        default:
            break
        }
        
    }
    
    
    
    
    
    private struct Ratios {
        static let skullRadiusToEyeOffset: CGFloat = 3
        static let skullRadiusToEyeRadius: CGFloat = 10
        static let skullRadiusToMouthWidth: CGFloat = 1
        static let skullRadiusToMouthHeight: CGFloat = 3
        static let skullRadiusToMouthOffset: CGFloat = 3
    }
    
    private func centerOfEye(_ eye: Eye) -> CGPoint {
        let eyeOffset = skullRadius / Ratios.skullRadiusToEyeOffset
        var eyeCenter = skullCenter
        eyeCenter.y -= eyeOffset
        eyeCenter.x += ((eye == .left) ? -1 : 1) * eyeOffset
        return eyeCenter
    }
    
    private lazy var leftEye: EyeView = self.createEye()
    private lazy var rightEye: EyeView = self.createEye()
    
    private func createEye() -> EyeView {
        let eye = EyeView()
        eye.isOpaque = false
        eye.color = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        eye.lineWidth = lineWidth
        addSubview(eye)
        
        return eye
    }
    
    private func positionEye(_ eye: EyeView, center: CGPoint) {
        let size = skullRadius / Ratios.skullRadiusToEyeRadius * 2
        eye.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: size, height: size))
        eye.center = center
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        positionEye(leftEye, center: centerOfEye(.left))
        positionEye(rightEye, center: centerOfEye(.right))
    }
    
//    private func pathForEye(_ eye: Eye) -> UIBezierPath {
//        
//        let eyeRadius = skullRadius / Ratios.skullRadiusToEyeRadius
//        let eyeCenter = centerOfEye(eye)
//        
//        let path: UIBezierPath
//        
//        if eyesOpen {
//            path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0.0, endAngle: CGFloat.pi * 2, clockwise: true)
//        } else {
//            path = UIBezierPath()
//            path.move(to: CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
//            path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
//        }
//        path.lineWidth = 5.0
//        return path
//        
//    }
    
    private func pathForMouth() -> UIBezierPath {
        let mouthWidth = skullRadius / Ratios.skullRadiusToMouthWidth
        let mouthHeight = skullRadius / Ratios.skullRadiusToMouthHeight
        let mouthOffset = skullRadius / Ratios.skullRadiusToMouthOffset
        
        let mouthRect = CGRect(x: skullCenter.x - mouthWidth / 2, y: skullCenter.y + mouthOffset, width: mouthWidth, height: mouthHeight)
        
        //let path = UIBezierPath(rect: mouthRect)
        
        let smileOffset = CGFloat(max(-1, min(mouthCurvature, 1))) * mouthRect.height
        let start = CGPoint(x: mouthRect.minX, y:mouthRect.midY)
        let end = CGPoint(x: mouthRect.maxX, y:mouthRect.midY)
        
        let cp1 = CGPoint(x: start.x + mouthRect.width / 3, y: start.y + smileOffset)
        let cp2 = CGPoint(x: end.x - mouthRect.width / 3, y: start.y + smileOffset)
        
        let path = UIBezierPath()
        
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        
        path.lineWidth = 5.0
        return path
    }
    
    private func pathForSkull() -> UIBezierPath {
        let path = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0.0, endAngle: CGFloat.pi * 2, clockwise: true)
        path.lineWidth = 5.0
        return path
        
    }
    
    // Only override draw() if you perform custom drawing.
    override func draw(_ rect: CGRect) {
        // Drawing code
        UIColor.blue.set()
        
        pathForSkull().stroke()
//        pathForEye(.left).stroke()
//        pathForEye(.right).stroke()
        pathForMouth().stroke()
    }
    
}
