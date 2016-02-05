//
//  KSProgressView.swift
//  ProgressBar
//
//  Created by Kusal Shrestha on 1/25/16.
//  Copyright © 2016 Kusal Shrestha. All rights reserved.
//

import UIKit

let circleRadius: CGFloat = 13
let stepSize = CGSize(width: circleRadius * 2, height: circleRadius * 2)
let progressedCircle = CGSize(width: circleRadius, height: circleRadius)
let unprogressedCircle = CGSizeZero
let thickness: CGFloat = 3

class KSLProgressView: UIView {

    private var steps: [UIView] = []
    private var lines: [UIView] = []
    private var insideCircles: [UIView] = []
    
    var numberOfSteps: Int! {
        didSet {
            createProgressBar()
        }
    }

    var progressViewColor: UIColor! = UIColor.redColor()
    
    convenience init(frame: CGRect, color: UIColor) {
        self.init(frame: frame)
        
        self.progressViewColor = color
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }

    private func createProgressBar() {
        for _ in 1...numberOfSteps {
            createCirclularStep()
            createInsideFillCircle()
        }
        for _ in 1..<numberOfSteps {
            createLineConnector()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//  MARK: - Drawing functions
    
    private func createCirclularStep() {
        let circle = UIView(frame: CGRect(origin: CGPointZero, size: stepSize))
        circle.backgroundColor = UIColor.clearColor()
        steps.append(circle)
        makeCircularLayer(circle.layer)
        self.addSubview(circle)
    }
    
    private func createInsideFillCircle() {
        let circle = UIView(frame: CGRectZero)
        circle.backgroundColor = progressViewColor
        insideCircles.append(circle)
        circle.layer.cornerRadius = circleRadius / 2
        self.addSubview(circle)
    }
    
    private func makeCircularLayer(layer: CALayer) {
        layer.cornerRadius = circleRadius
        layer.borderWidth = thickness
        layer.borderColor = progressViewColor.CGColor
    }
    
    private func createLineConnector() {
        let line = UIView(frame: CGRectZero)
        line.backgroundColor = progressViewColor
        lines.append(line)
        self.addSubview(line)
    }
    
    func setProgress(progress: Int) {
        print(progress)
        guard progress >= 1  && progress <= self.numberOfSteps else {
            return
        }
        func appear() {
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .CurveEaseInOut, animations: { () -> Void in
                self.insideCircles[progress - 1].bounds = CGRect(origin: CGPointZero, size: progressedCircle)
                }, completion: nil)
        }
        func disappear() {
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .CurveEaseInOut, animations: { () -> Void in
                self.insideCircles[progress - 1].bounds = CGRectZero
                }, completion: nil)
        }
        self.insideCircles[progress - 1].bounds == CGRectZero ? appear() : disappear()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for iterator in 0..<steps.count {
            steps[iterator].center = getPositionForStepAtIndex(iterator)
            insideCircles[iterator].center = steps[iterator].center
        }
        for iterator in 0..<lines.count {
            lines[iterator].frame = CGRect(origin: CGPoint(x: CGRectGetMaxX(steps[iterator].frame), y: CGRectGetMidY(steps[iterator].frame) - thickness / 2), size: CGSize(width: CGRectGetMinX(steps[iterator + 1].frame) - CGRectGetMaxX(steps[iterator].frame), height: thickness))
        }
    }
    
    private func getPositionForStepAtIndex(index: Int) -> CGPoint {
        let xPos = circleRadius + (self.bounds.width - CGFloat(2 * circleRadius)) / CGFloat(numberOfSteps - 1) * CGFloat(index)
        let yPos = self.bounds.height / 2
        return CGPoint(x: xPos, y: yPos)
    }
    
    private func dynamicChangeLineWidth(index: Int, maxX: CGFloat, midY: CGFloat) -> CGRect {
        let lineWidth = (self.bounds.width - CGFloat(stepSize.width * CGFloat(numberOfSteps))) / CGFloat(numberOfSteps - 1)
        return CGRect(origin: CGPoint(x: maxX, y: -midY), size: CGSize(width: lineWidth + 1, height: thickness))
    }
    
}
