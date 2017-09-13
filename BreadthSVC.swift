//
//  BreadthSVC.swift
//  Algorithms
//
//  Created by TTung on 5/15/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation

class BreadthSVC: StudyVC {
    
    var manager: ManagerBreadth!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = ManagerBreadth()
        manager.initBreadth(viewcontroller: self)
        btnRun.addTarget(self.manager, action: #selector(manager.run(sender:)), for: .touchUpInside)
        btnStep.addTarget(self.manager, action: #selector(manager.step(sender:)), for: .touchUpInside)
        btnReset.addTarget(self, action: #selector(reset(sender:)), for: .touchUpInside)
    }
    
    func reset(sender:UIButton){
        self.manager.graph.removeFromSuperview()
        //        self.manager.textStudy.removeFromSuperview()
        btnRun.isUserInteractionEnabled = true
        btnStep.isUserInteractionEnabled = true
        btnRun.layer.backgroundColor = LIME_COLOR.cgColor
        btnStep.layer.backgroundColor = LIME_COLOR.cgColor
        btnRun.setNeedsDisplay()
        btnStep.setNeedsDisplay()
        self.manager.initBreadth(viewcontroller: self)
    }
}
