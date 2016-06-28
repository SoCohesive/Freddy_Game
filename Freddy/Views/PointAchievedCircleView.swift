//
//  PointAchievedCircleView.swift
//  Freddy
//
//  Created by Sonam Dhingra on 6/28/16.
//  Copyright © 2016 Sonam Dhingra. All rights reserved.
//

import UIKit

class PointAchievedCircleView: CircleView {
    
    @IBOutlet weak var pointAchievedLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    func style() {
        pointAchievedLabel.textColor = .whiteColor()
        pointAchievedLabel.text = "Nice"
        backgroundColor = .seaGlassBlue()
    }
    
    //MARK: Animation Handling
    
    func animateInToYPosition(yPosition: CGFloat, constraint: NSLayoutConstraint, completionClosure: CompletionClosure) {
        transform = CGAffineTransformMakeScale(0.4, 0.4)
        UIView.animateWithDuration(1.3, delay: 0, options: .TransitionCrossDissolve, animations: { [weak self] () -> Void in
            self?.alpha = 1
            constraint.constant = yPosition
            self?.transform = CGAffineTransformMakeScale(1.0, 1.0)
            self?.layoutIfNeeded()
        }) { (complete) in
            completionClosure()
        }
    }
    
    func animateOutToBottomWithConstraint(constraint: NSLayoutConstraint) {
        UIView.animateWithDuration(1.3, delay: 1.5, options: .TransitionCrossDissolve, animations: {
            self.alpha = 0
            constraint.constant = 0
            self.layoutIfNeeded()
            }, completion: nil)
    }
}