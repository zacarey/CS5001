//
//  StacksSVC.swift
//  Algorithms
//
//  Created by Loc Tran on 5/4/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import UIKit

class StacksSVC: StudyVC {

    var manager: ManagerStacks!
    var labelPush: UILabel!
    var labelPop: UILabel!
    var labelTop: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Stacks"
        
        manager = ManagerStacks()
        manager.initStacks(viewcontroller: self)
        btnStepBig.addTarget(self.manager, action: #selector(manager.step(sender:)), for: .touchUpInside)
        btnReset.addTarget(self, action: #selector(reset(sender:)), for: .touchUpInside)
        btnStepBig.isHidden = false
        addLabelPush()
        addLabelPop()
        addLabelTop()
        labelPush.isHidden = true
        labelPop.isHidden = true
    }
    
    @objc func reset(sender:UIButton){
        self.manager.graph.removeFromSuperview()
        self.manager.textStudy.removeFromSuperview()
        btnStepBig.isUserInteractionEnabled = true
        manager.initStacks(viewcontroller: self)
        labelTop.isHidden = false
        labelTop.frame = CGRect(x: view.bounds.size.width/10, y: yEndMove_Stacks*7+CGFloat(12), width: 70, height: 30)
        labelPop.isHidden = true
        labelPush.isHidden = true
    }
    
    func addLabelPush(){
        labelPush = UILabel(frame: CGRect(x: view.bounds.size.width/9, y: yEndMove_Stacks*5, width: 40, height: 30))
        labelPushTmp = labelPush
        labelPush.text = "push"
        labelPush.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        labelPush.textAlignment = .center
        labelPush.layer.masksToBounds = true
        labelPush.layer.borderWidth = 2
        labelPush.layer.borderColor = UIColor.black.cgColor
        labelPush.layer.cornerRadius = 10
        view.addSubview(labelPush)
    }
    
    func addLabelPop(){
        labelPop = UILabel(frame: CGRect(x: view.bounds.size.width*7/9, y: yEndMove_Stacks*5, width: 40, height: 30))
        labelPopTmp = labelPop
        labelPop.text = "pop"
        labelPop.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        labelPop.textAlignment = .center
        labelPop.layer.masksToBounds = true
        labelPop.layer.borderWidth = 2
        labelPop.layer.borderColor = UIColor.black.cgColor
        labelPop.layer.cornerRadius = 10
        view.addSubview(labelPop)
    }
    
    func addLabelTop(){
        labelTop = SortingLabel(frame: CGRect(x: view.bounds.size.width/10, y: yEndMove_Stacks*7+CGFloat(12), width: 70, height: 30))
        labelTopTmp = labelTop
        labelTop.text = "Top  =>"
        labelTop.textAlignment = .center
        labelTop.layer.masksToBounds = true
        view.addSubview(labelTop)

    }

}

