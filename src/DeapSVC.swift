//
//  DeapSVC.swift
//  Algorithms
//
//  Created by Ledung95d on 5/17/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
class DeapSVC: StudyVC{
    var manager: ManagerDeap!

    override func viewDidLoad() {
        super.viewDidLoad()
        manager = ManagerDeap()
        manager.initDeap(viewcontroller: self)
        btnRun.addTarget(self.manager, action: #selector(manager.run(sender:)), for: .touchUpInside)

        btnStep.addTarget(self.manager, action: #selector(manager.step(sender:)), for: .touchUpInside)

        btnReset.addTarget(self, action:  #selector(reset(sender:)), for: .touchUpInside)
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
       self.manager.initDeap(viewcontroller: self)
        
    }
}
