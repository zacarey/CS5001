//
//  ManagerLinear.swift
//  Algorithms
//
//  Created by TTung on 5/8/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
import UIKit

class ManagerLinear {
    
    var animate: AnimationLiear!
    var graph: GraphLinearBinary!
    var viewcontroller: UIViewController!
    var arrayLabel: [SortingLabel]!
    var arrayAction: [LinearStep]!
    var linear: LinearSearch!
    
    var textStudy: DetailTxtView!
    var dictData = NSDictionary()
    var arrayKey = [String]()
    var ele = 0
    var search: Int!
    
    func initLinear(viewcontroller: UIViewController, search: Int){
        
        
        graph = GraphLinearBinary(frame: CGRect(x: 32, y: (viewcontroller.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height * 2, width: viewcontroller.view.bounds.size.width - CGFloat(64), height: viewcontroller.view.bounds.size.width - CGFloat(64)))
        viewcontroller.view.addSubview(graph)
        
        self.search = search
        self.arrayAction = getAction(arr: graph.arrayFind)
        animate = AnimationLiear(arrayLabel: graph.arrayLabel, graph: graph, arrayAction: arrayAction)
        
        if(VIEW_CHOSEN=="study"){
            
            textStudy = DetailTxtView(frame: CGRect(x: graph.frame.origin.x + UIApplication.shared.statusBarFrame.height,
                                                    y: graph.frame.origin.y+graph.frame.height+CGFloat(8),
                                                    width: graph.frame.width - 2*UIApplication.shared.statusBarFrame.height ,
                                                    height: yMax-(graph.frame.origin.y+graph.frame.height)))
            
            viewcontroller.view.addSubview(textStudy)
            
            
            
            var path: String = ""
            
            path = Bundle.main.path(forResource:"Linear", ofType: "plist")!
            dictData = NSDictionary(contentsOfFile: path)!
            arrayKey = dictData.allKeys as! [String]            
            
            arrayKey = arrayKey.sorted(by: {$0 < $1})
            ele = 0
            animate = AnimationLiear(arrayLabel: graph.arrayLabel, graph: graph, arrayAction: arrayAction)
        }

    }
    
    func getAction(arr: [Int]) -> [LinearStep] {
        linear = LinearSearch(arrayInput: arr, search: search)
        return linear.arrayAction
    }
    @objc func run(sender: UIButton){
        textStudy.text = "Tim kiem so: \(search!)"
        animate.loop()
        btnRunTmp.isUserInteractionEnabled = false
        btnStepTmp.isUserInteractionEnabled = false
        btnRunTmp.layer.backgroundColor = UIColor.gray.cgColor
        btnStepTmp.layer.backgroundColor = UIColor.gray.cgColor
        btnRunTmp.setNeedsDisplay()
        btnStepTmp.setNeedsDisplay()
    }
    @objc func step(sender: UIButton){
        animate.next()
        btnRunTmp.isUserInteractionEnabled = false
        btnStepTmp.isUserInteractionEnabled = false
        btnRunTmp.layer.backgroundColor = UIColor.gray.cgColor
        btnRunTmp.setNeedsDisplay()
        btnStepTmp.setNeedsDisplay()
    }
    
}
