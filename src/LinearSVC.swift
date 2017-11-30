//
//  LinearSVC.swift
//  Algorithms
//
//  Created by TTung on 5/8/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import UIKit

class LinearSVC: StudyVC {
  
    var search: Int!
    var manager: ManagerLinear!

    override func viewDidLoad() {
        super.viewDidLoad()
        manager = ManagerLinear()
        
        search = Int(arc4random_uniform(88)) + 11
        manager.initLinear(viewcontroller: self, search: search)
        btnRun.addTarget(self.manager, action: #selector(manager.run(sender:)), for: .touchUpInside)
        btnStep.addTarget(self.manager, action: #selector(manager.step(sender:)), for: .touchUpInside)
        btnReset.addTarget(self, action: #selector(reset(sender:)), for: .touchUpInside)
        
    }
    
    func reset(sender:UIButton){
        self.manager.graph.removeFromSuperview()
        self.manager.textStudy.removeFromSuperview()
        btnRun.isUserInteractionEnabled = true
        btnStep.isUserInteractionEnabled = true
        btnRun.layer.backgroundColor = LIME_COLOR.cgColor
        btnStep.layer.backgroundColor = LIME_COLOR.cgColor
        btnRun.setNeedsDisplay()
        btnStep.setNeedsDisplay()
        search = Int(arc4random_uniform(88)) + 11
        manager.initLinear(viewcontroller: self, search: search)

    }
    
}
