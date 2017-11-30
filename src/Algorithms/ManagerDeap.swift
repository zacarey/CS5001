//
//  ManagerDeap.swift
//  Algorithms
//
//  Created by Ledung95d on 5/17/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
class ManagerDeap {

    var graph: GraphBreadthDeap!
    var viewcontroller: UIViewController!
    var arrayLabel: [SortingLabel]!

    var textStudy: DetailTxtView!
    var dictData = NSDictionary()
    var arrayKeys = [String]()
    var ele = 0
    var arrayAction: [DFS_Step]!
    var sort: DeapFirstSearch!
    var animation: AnimationDeap!

    func initDeap(viewcontroller: UIViewController){

        graph = GraphBreadthDeap(frame: CGRect(x: 0,
                                               y:(viewcontroller.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height * 2,
                                               width: viewcontroller.view.bounds.size.width,
                                               height: viewcontroller.view.bounds.size.height/2))
        viewcontroller.view.addSubview(graph)

        self.arrayAction = self.getArrayAction()
        self.animation = AnimationDeap(graph: graph, arrayAction: self.arrayAction, arrayLabel:self.graph.arrayLabel)
        
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

        sort = DeapFirstSearch()
        return sort.arrayAction

    }
}
