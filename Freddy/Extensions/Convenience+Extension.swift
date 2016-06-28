//
//  Convenience+Extension.swift
//  Freddy
//
//  Created by Sonam Dhingra on 6/28/16.
//  Copyright © 2016 Sonam Dhingra. All rights reserved.
//

import Foundation

public typealias CompletionClosure = () -> ()

func mainQueue(completion:CompletionClosure) {
    dispatch_async(dispatch_get_main_queue()) {() -> Void in
        completion()
    }
}