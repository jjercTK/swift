//
//  FaceView.swift
//  FaceIt
//
//  Created by Juanjo on 10/17/16.
//  Copyright © 2016 Tektonlabs. All rights reserved.
//

import UIKit

@IBDesignable class FaceView: UIView {
    
    @IBInspectable public var scale: CGFloat = 0.80 { didSet { setNeedsDisplay() }}
    @IBInspectable public var lineWidth: CGFloat = 3.0 { didSet { setNeedsDisplay() }}
    @IBInspectable public var mouthCurvature:Double = 1.0 { didSet { setNeedsDisplay() }}
    @IBInspectable public var eyesOpen: Bool = true { didSet { setNeedsDisplay() }}
    @IBInspectable public var eyeBrowTilt: Double = 0.5 { didSet { setNeedsDisplay() }}
    @IBInspectable public var color:UIColor = UIColor.blue { didSet { setNeedsDisplay() }}
    
    public func changeScale(_ recognizer: UIPinchGestureRecognizer){
        switch recognizer.state {
        case .changed, .ended:  
            scale *= recognizer.scale
            recognizer.scale = 1.0
        default:
            break
        }
    }
    
    private var skullRadius :CGFloat {
        return min(bounds.size.width,bounds.size.height) / 2 * scale
    }
    
    private var skullCenter: CGPoint{
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    private struct Ratios {
        static let SkullRadiusToEyeOffset: CGFloat = 3
        static let SkullRadiusToEyeRadius: CGFloat = 10
        static let SkullRadiusToMouthWidth: CGFloat = 1
        static let SkullRadiusToMouthHeight: CGFloat = 3
        static let SkullRadiusToMouthOffset: CGFloat = 3
        static let SkullRadiusToBrowOffset: CGFloat = 3
    }
    
    private enum Eye {
        case Left
        case Right
        
        static let all = [Left,Right]
    }
    
    private func getEyeCenter(eye: Eye) -> CGPoint {
        let eyeOffset = skullRadius / Ratios.SkullRadiusToEyeOffset
        var eyeCenter = skullCenter
            eyeCenter.y -= eyeOffset
        switch eye {
        case .Left:
            eyeCenter.x -= eyeOffset
        case .Right:
            eyeCenter.x += eyeOffset
        }
        return eyeCenter
    }
    
    private func pathForMouth() -> UIBezierPath {
        let path = UIBezierPath()
        
        let mouthWidth = skullRadius / Ratios.SkullRadiusToMouthWidth
        let mouthHeight = skullRadius / Ratios.SkullRadiusToMouthHeight
        let mouthOffset = skullRadius / Ratios.SkullRadiusToMouthOffset
        let mouthX = skullCenter.x - mouthWidth/2
        let mouthY = skullCenter.y + mouthOffset
        
        let mouthRect = CGRect(x: mouthX, y: mouthY, width: mouthWidth, height: mouthHeight)
        
        let smileOffset = CGFloat(max(-1,min(mouthCurvature,1))) * mouthRect.height
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.minY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.minY)
        let cp1 = CGPoint(x: mouthRect.minX + mouthRect.width / 3, y: mouthRect.minY + smileOffset)
        let cp2 = CGPoint(x: mouthRect.maxX - mouthRect.width / 3, y: mouthRect.minY + smileOffset)

        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        return path
    }
    
    private func pathForEye(eye: Eye) -> UIBezierPath{
        let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
        let eyeCenter = getEyeCenter(eye: eye)
        if eyesOpen {
            return pathForCircleCenteredAtPoint(midPoint: eyeCenter, widthRadius: eyeRadius)
        } else {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
            path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
            path.lineWidth = lineWidth
            return path
        }
        
    }
    
    private func pathForBrow(eye: Eye) -> UIBezierPath{
        var tilt = eyeBrowTilt
        switch eye {
            case .Left: tilt *= -1.0
            case .Right: break
        }
        var browCenter = getEyeCenter(eye: eye)
        browCenter.y -= skullRadius / Ratios.SkullRadiusToBrowOffset
        let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
        let tiltOffset = CGFloat(max(-1, min(tilt,1))) * eyeRadius / 2
        let browStart = CGPoint(x: browCenter.x - eyeRadius, y: browCenter.y - tiltOffset)
        let browEnd = CGPoint(x: browCenter.x + eyeRadius, y: browCenter.y + tiltOffset)
        let path = UIBezierPath()
        path.move(to: browStart)
        path.addLine(to: browEnd)
        path.lineWidth = lineWidth
        return path
    }
    
    private func pathForCircleCenteredAtPoint(midPoint: CGPoint, widthRadius radius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath(
            arcCenter: midPoint,
            radius: radius,
            startAngle: 0.0,
            endAngle: CGFloat(2*M_PI),
            clockwise: false
        )
        path.lineWidth = lineWidth
        return path
    }

    override func draw(_ rect: CGRect) {
        color.set()
        pathForCircleCenteredAtPoint(midPoint: skullCenter, widthRadius: skullRadius).stroke()
        pathForMouth().stroke()
        for eye in Eye.all {
            pathForEye(eye: eye).stroke()
            pathForBrow(eye: eye).stroke()
        }
    }

}
