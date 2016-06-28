//
//  SquashFreddyViewController.swift
//  Freddy
//
//  Created by Sonam Dhingra on 6/28/16.
//  Copyright © 2016 Sonam Dhingra. All rights reserved.
//

import UIKit
import CoreMotion

/*
    This is a small demonstration of a game idea where the user must move the device in the direction in which the red dot is flashing. I plan to implement an SVG file and place the "red" dots on certain hit areas defined in the SVG file itself
 
    The accelerometer algorithm will need to managed all directions (Up, Down, Left, Right)
 
 */

class SquashFreddyViewController: UIViewController {
    
    static let storyboardIdentifier = "SquashFreddyViewController"
    
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var foreheadView: CircleView!
    @IBOutlet weak var pointsStaticLabel: UILabel!
    @IBOutlet weak var pointCountLabel: UILabel!
    @IBOutlet weak var pointGainedView: PointAchievedCircleView!
    @IBOutlet weak var pointGainedViewBottomConstraint: NSLayoutConstraint!
 
    private let motionManager = CMMotionManager()
    private var startingZPos: Double = 0.00
    private var pointCount = 0
    
    enum Direction {
        case Up, Down, Left, Right
    }
    
    //MARK: Lifecycle 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bringSubviewToFront(foreheadView)
        configureMotionManager()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        foreheadView.pulse()
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        motionManager.stopDeviceMotionUpdates()
    }
    
    //MARK:  Core Motion Management
    
    func configureMotionManager() {
        if motionManager.deviceMotionAvailable {
            motionManager.startAccelerometerUpdates()
            trackMotionData()
        }
    }
    
    func trackMotionData() {
        startingZPos = motionManager.deviceMotion?.userAcceleration.z ?? 0
        motionManager.deviceMotionUpdateInterval = 0.10
        let queue = NSOperationQueue()
        motionManager.startDeviceMotionUpdatesToQueue(queue) {[weak self] (data, error) in
            if let zAccleration = data?.userAcceleration.z,
                let safeStartingZPos = self?.startingZPos {
                if zAccleration > 0 && zAccleration - safeStartingZPos > 0.15 {
                    self?.pointCount += 1
                    self?.achivedTargetForDirection(.Up)
                }
            }
        }
    }
    
    //MARK: Game Handling
    
    func achivedTargetForDirection(direction: Direction) {
        mainQueue { [weak self] in
            guard let viewFrame = self?.view.frame,
                    let safeBottomGainedViewConstraint = self?.pointGainedViewBottomConstraint else {
                    return
            }
            
            //Show point gained view
            self?.pointGainedView.animateInToYPosition(CGRectGetHeight(viewFrame)/2, constraint: safeBottomGainedViewConstraint, completionClosure: {
                if let weakSelf = self {
                    //Use weakSelf here to avoid an optional string
                    weakSelf.pointCountLabel.text = String(weakSelf.pointCount)
                    weakSelf.pointGainedView.animateOutToBottomWithConstraint(safeBottomGainedViewConstraint)
                }
            })
        }
    }

    //MARK: Button Actions
    
    @IBAction func didTapDismissButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}