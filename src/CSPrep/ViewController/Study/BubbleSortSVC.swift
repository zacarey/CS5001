//
//  BubbleSortVC.swift
//  Algorithms
//
//  Created by Loc Tran on 3/21/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import UIKit

class BubbleSortSVC: StudyVC {
    
    var managerSort: ManagerBubbleSort!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        PDF_TITLE = "Bubble Sort"
        title = "Bubble Sort"
        
        self.managerSort = ManagerBubbleSort()
        self.managerSort.initSortWith(viewcontroller: self, arrayInput: [4,3,2,7,6,0,8])
        
        btnRun.addTarget(self.managerSort, action: #selector(managerSort.run(sender:)), for: .touchUpInside)
        
        btnStep.addTarget(self.managerSort, action: #selector(managerSort.step(sender:)), for: .touchUpInside)
        
        btnReset.addTarget(self, action:  #selector(reset(sender:)), for: .touchUpInside)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetApp()
        
    }
    
    
    @objc func reset(sender:UIButton){
        resetApp()
    }
    
    func resetApp(){
        self.managerSort.graph.removeFromSuperview()
        self.managerSort.textStudy.removeFromSuperview()
        btnRun.isUserInteractionEnabled = true
        btnStep.isUserInteractionEnabled = true
        btnRun.layer.backgroundColor = LIME_COLOR.cgColor
        btnStep.layer.backgroundColor = LIME_COLOR.cgColor
        btnRun.setNeedsDisplay()
        btnStep.setNeedsDisplay()
        managerSort.initSortWith(viewcontroller: self, arrayInput: [4,3,2,7,6,0,8])
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

