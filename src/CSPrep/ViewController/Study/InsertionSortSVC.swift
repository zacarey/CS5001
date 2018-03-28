//
//  InsertionSortVC.swift
//  Algorithms
//
//  Created by Loc Tran on 3/28/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import UIKit

class InsertionSortSVC: StudyVC {
    
    var managerSort: ManagerInsertionSort!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        PDF_TITLE = "Insertion Sort"
        title = "Insertion Sort"
        
        self.managerSort = ManagerInsertionSort()
        self.managerSort.initSortWith(viewcontroller: self, arrayInput: [4,3,2,7,0,8])
        
        btnRun.addTarget(self.managerSort, action: #selector(managerSort.run(sender:)), for: .touchUpInside)
        
        btnStep.addTarget(self.managerSort, action: #selector(managerSort.step(sender:)), for: .touchUpInside)
        
        btnReset.addTarget(self, action:  #selector(reset(sender:)), for: .touchUpInside)
        
    }
    
    @objc func reset(sender:UIButton){
        self.managerSort.graph.removeFromSuperview()
        self.managerSort.textStudy.removeFromSuperview()
        btnRun.isUserInteractionEnabled = true
        btnStep.isUserInteractionEnabled = true
        btnRun.layer.backgroundColor = LIME_COLOR.cgColor
        btnStep.layer.backgroundColor = LIME_COLOR.cgColor
        btnRun.setNeedsDisplay()
        btnStep.setNeedsDisplay()
        managerSort.initSortWith(viewcontroller: self, arrayInput: [4,3,2,7,0,8])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
