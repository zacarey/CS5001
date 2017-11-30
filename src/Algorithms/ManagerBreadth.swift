//
//  ManagerBreadth.swift
//  Algorithms
//
//  Created by TTung on 5/15/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation

class ManagerBreadth {
    
    var graph: GraphBreadthDeap!
    var viewcontroller: UIViewController!
    var arrayLabel: [SortingLabel]!
    
    var textStudy: DetailTxtView!
    var dictData = NSDictionary()
    var arrayKeys = [String]()
    var ele = 0
    var arrayAction: [BFS_Step]!
    var sort: BreadthFirstSearch!
    var animation: AnimationBreath!
    
    func initBreadth(viewcontroller: UIViewController){
        
        graph = GraphBreadthDeap(frame: CGRect(x: 0,
                                               y:(viewcontroller.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height * 2,
                                               width: viewcontroller.view.bounds.size.width,
                                               height: viewcontroller.view.bounds.size.height/2))
        viewcontroller.view.addSubview(graph)
        self.arrayAction = getArrayAction()
        self.animation = AnimationBreath(graph: graph, arrayAction: self.arrayAction, arrayLabel: self.graph.arrayLabel)
        
    }
    @objc func run(sender: UIButton){
        self.animation.loop()
        btnRunTmp.isUserInteractionEnabled = false
        btnStepTmp.isUserInteractionEnabled = true
        btnRunTmp.layer.backgroundColor = UIColor.gray.cgColor
        btnRunTmp.setNeedsDisplay()
        btnStepTmp.setNeedsDisplay()
    }
    @objc func step(sender: UIButton){
        self.animation.next()
        btnRunTmp.isUserInteractionEnabled = false
        btnStepTmp.isUserInteractionEnabled = false
        btnRunTmp.layer.backgroundColor = UIColor.gray.cgColor
        btnRunTmp.setNeedsDisplay()
        btnStepTmp.setNeedsDisplay()
    }

    func getArrayAction() -> [BFS_Step] {

        sort = BreadthFirstSearch()
        return sort.arrayAction
        
    }
}
