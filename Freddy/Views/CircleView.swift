//
//  CircleView.swift
//  Freddy
//
//  Created by Sonam Dhingra on 6/28/16.
//  Copyright © 2016 Sonam Dhingra. All rights reserved.
//

import UIKit

@IBDesignable class CircleView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .redColor()
        layer.cornerRadius = CGRectGetWidth(self.frame)/2
        clipsToBounds = true
    }

}