//
//  QueuesSVC.swift
//  Algorithms
//
//  Created by Loc Tran on 5/6/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import UIKit

class QueuesSVC: StudyVC {

    var manager: ManagerQueues!
    var labelEnqueues: SortingLabel!
    var labelDequeues: SortingLabel!
    var labelRear: SortingLabel!
    var labelFront: SortingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Queues"
        
        manager = ManagerQueues()
        manager.initQueues(viewcontroller: self)
        btnStepBigTmp.addTarget(self.manager, action: #selector(manager.step(sender:)), for: .touchUpInside)
        btnReset.addTarget(self, action: #selector(reset(sender:)), for: .touchUpInside)
        btnStepBig.isHidden = false
        addDequeues()
        addEnqueues()
        addRear()
        addFront()
        labelEnqueues.isHidden = true
        labelDequeues.isHidden = true
        labelRear.isHidden = true
        labelFront.isHidden = true
    }
    
    @objc func reset(sender:UIButton){
        self.manager.graph.removeFromSuperview()
        self.manager.textStudy.removeFromSuperview()
        btnStepBig.isUserInteractionEnabled = true
        labelEnqueues.isHidden = true
        labelDequeues.isHidden = true
        labelRear.isHidden = true
        labelFront.isHidden = true
        manager.initQueues(viewcontroller: self)
        
    }
    func addEnqueues(){
        labelEnqueues = SortingLabel(frame: CGRect(x: view.bounds.size.width*2/21, y: y_Queues + y_nav, width: 100, height: 30))
        labelEnqueuesTmp = labelEnqueues
        labelEnqueues.text = "Enqueue"
        labelEnqueues.textColor = UIColor.lightGray
        labelEnqueues.textAlignment = .center
        view.addSubview(labelEnqueues)
    }
    
    func addDequeues(){
        
        labelDequeues = SortingLabel(frame: CGRect(x: view.bounds.size.width*14/21, y: y_Queues + y_nav, width: 100, height: 30))
        labelDequeuesTmp = labelDequeues
        labelDequeues.text = "Dequeue"
        labelDequeues.textColor = UIColor.lightGray
        labelDequeues.textAlignment = .center
        view.addSubview(labelDequeues)

    }
    
    func addRear(){
        labelRear = SortingLabel(frame: CGRect(x: view.bounds.size.width*2/21, y: y_Queues*4 + y_Queues/2 + y_nav, width: 50, height: 30))
        labelRearTmp = labelRear
        labelRear.text = "rear"
        labelRear.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        labelRear.textAlignment = .center
        labelRear.layer.masksToBounds = true
        labelRear.layer.borderWidth = 2
        labelRear.layer.borderColor = UIColor.black.cgColor
        labelRear.layer.cornerRadius = 10

        view.addSubview(labelRear)

    }
    
    func addFront(){
        labelFront = SortingLabel(frame: CGRect(x: view.bounds.size.width*16/21, y: y_Queues*4 + y_Queues/2 + y_nav, width: 50, height: 30))
        labelFrontTmp = labelFront
        labelFront.text = "front"
        labelFront.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        labelFront.textAlignment = .center
        labelFront.layer.masksToBounds = true
        labelFront.layer.borderWidth = 2
        labelFront.layer.borderColor = UIColor.black.cgColor
        labelFront.layer.cornerRadius = 10

        
        view.addSubview(labelFront)

    }
   

}
