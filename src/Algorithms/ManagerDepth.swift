//
//  ManagerDepth.swift
//  Algorithms
//
//  Created by Loc Tran on 5/17/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
class ManagerDepth {

    var graph: GraphBreadthDepth!
    var viewcontroller: UIViewController!
    var arrayLabel: [SortingLabel]!

    var textStudy: DetailTxtView!
    var dictData = NSDictionary()
    var arrayKeys = [String]()
    var ele = 0
    var arrayAction: [DFS_Step]!
    var sort: DepthFirstSearch!
    var animation: AnimationDepth!

    func initDepth(viewcontroller: UIViewController){

        graph = GraphBreadthDepth(frame: CGRect(x: 0,
                                               y:(viewcontroller.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height * 2,
                                               width: viewcontroller.view.bounds.size.width,
                                               height: viewcontroller.view.bounds.size.height/2))
        viewcontroller.view.addSubview(graph)

        self.arrayAction = self.getArrayAction()
        self.animation = AnimationDepth(graph: graph, arrayAction: self.arrayAction, arrayLabel:self.graph.arrayLabel)
        
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
    func getArrayAction() -> [DFS_Step] {

        sort = DepthFirstSearch()
        return sort.arrayAction

    }
}
