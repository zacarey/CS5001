//
//  LinkListVC.swift
//  Algorithms
//
//  Created by Loc Tran on 5/5/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation

class LinkListVC:StudyVC{
    var manager: ManagerLinkList!
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = ManagerLinkList()
        manager.initSortWith(viewcontroller: self)
        btnRun.removeFromSuperview()
        btnStep.frame = CGRect(x: x, y: view.bounds.size.height-spacing-btnSizeHeight, width: btnSizeWidth*2 + spacing, height: btnSizeHeight)

        btnStep.addTarget(self.manager, action: #selector(manager.step(sender:)), for: .touchUpInside)

        btnReset.addTarget(self, action:  #selector(reset(sender:)), for: .touchUpInside)

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
        manager.initSortWith(viewcontroller: self)
    }

}
