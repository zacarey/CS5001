//
//  BinarySVC.swift
//  Algorithms
//
//  Created by Loc Tran on 5/11/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import UIKit

class BinarySVC: StudyVC {
    
    var search: Int!
    var manager: ManagerBinary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Binary Search"
        
        manager = ManagerBinary()
        
        search = 34
        manager.initBinary(viewcontroller: self, search: search)
        btnRun.addTarget(self.manager, action: #selector(manager.run(sender:)), for: .touchUpInside)
        btnStep.addTarget(self.manager, action: #selector(manager.step(sender:)), for: .touchUpInside)
        btnReset.addTarget(self, action: #selector(reset(sender:)), for: .touchUpInside)
    }
    @objc func reset(sender:UIButton){
        self.manager.graph.removeFromSuperview()
        self.manager.textStudy.removeFromSuperview()
        btnRun.isUserInteractionEnabled = true
        btnStep.isUserInteractionEnabled = true
        btnRun.layer.backgroundColor = LIME_COLOR.cgColor
        btnStep.layer.backgroundColor = LIME_COLOR.cgColor
        btnRun.setNeedsDisplay()
        btnStep.setNeedsDisplay()
        search = 34
        manager.initBinary(viewcontroller: self, search: search)
        
    }
    
    
}
