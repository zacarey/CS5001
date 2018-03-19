//
//  MergeSortVC.swift
//  Algorithms
//
//  Created by Loc Tran on 3/28/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import UIKit

class MergeSortSVC: StudyVC {
    
    var managerSort: ManagerMergeSort!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        PDF_TITLE = "Merge Sort"
        title = "Merge Sort"
        self.managerSort = ManagerMergeSort()
        self.managerSort.initSortWith(viewcontroller: self, arrayInput: [4,1,9,2,5,3,6,7])
        
        btnRun.addTarget(self.managerSort, action: #selector(managerSort.run(sender:)), for: .touchUpInside)
        btnStep.addTarget(self.managerSort, action: #selector(managerSort.step(sender:)), for: .touchUpInside)
        btnReset.addTarget(self, action:  #selector(reset(sender:)), for: .touchUpInside)
        
    }
    @objc func reset(sender:UIButton){
        self.managerSort.graph.removeFromSuperview()
        btnRun.isUserInteractionEnabled = true
        btnStep.isUserInteractionEnabled = true
        btnRun.layer.backgroundColor = LIME_COLOR.cgColor
        btnStep.layer.backgroundColor = LIME_COLOR.cgColor
        btnRun.setNeedsDisplay()
        btnStep.setNeedsDisplay()
        managerSort.initSortWith(viewcontroller: self, arrayInput: [4,1,9,2,5,3,6])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
}
