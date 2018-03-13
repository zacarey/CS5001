//
//  TowerOfHaNoiVC.swift
//  Algorithms
//
//  Created by Loc Tran on 5/3/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import UIKit

class TowerOfHaNoiVC: StudyVC {

    var manager: ManagerTower!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor.white
        manager = ManagerTower()
        manager.initSortWith(viewcontroller: self)
        btnRun.addTarget(self.manager, action: #selector(manager.run(sender:)), for: .touchUpInside)

        btnStep.addTarget(self.manager, action: #selector(manager.step(sender:)), for: .touchUpInside)

        btnReset.addTarget(self, action:  #selector(reset(sender:)), for: .touchUpInside)
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
        manager.initSortWith(viewcontroller: self)
    }
   

}
