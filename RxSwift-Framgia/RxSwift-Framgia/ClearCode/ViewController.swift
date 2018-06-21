//
//  ViewController.swift
//  RxSwift-Framgia
//
//  Created by nguyen.van.bao on 21/06/2018.
//  Copyright © 2018 nguyen.van.bao. All rights reserved.
//

import UIKit

class ViewController<V: View>: UIViewController {
    
    override func loadView() {
        view = V()
    }
    
    var customView: V {
        return view as! V
    }
    
}
