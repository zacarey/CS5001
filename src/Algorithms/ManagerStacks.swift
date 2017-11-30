//
//  ManagerStacks.swift
//  Algorithms
//
//  Created by TTung on 5/4/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation

class ManagerStacks {
    
    var graph: GraphStacks!
    var viewcontroller: UIViewController!
    var animation: AnimationStacks!
    var arrayLabel: [SortingLabel]!
    
    var textStudy: DetailTxtView!
    var dictData = NSDictionary()
    var arrayKeys = [String]()
    var ele = 0
    
    
    
    func initStacks(viewcontroller: UIViewController){
        graph = GraphStacks(frame: CGRect(x: 0,
                                          y:(viewcontroller.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height * 2,
                                          width: viewcontroller.view.bounds.size.width,
                                          height: viewcontroller.view.bounds.size.height/2))
        viewcontroller.view.addSubview(graph)
        self.arrayLabel = graph.arrayLabel
        animation = AnimationStacks(arrayLabel: arrayLabel, graph: graph)
        
        if(VIEW_CHOSEN=="study"){
            
            textStudy = DetailTxtView(frame: CGRect(x: graph.frame.origin.x + UIApplication.shared.statusBarFrame.height,
                                                y: graph.frame.origin.y+graph.frame.height,
                                                width: graph.frame.width - 2*UIApplication.shared.statusBarFrame.height ,
                                                height: yMax-(graph.frame.origin.y+graph.frame.height)))
            
            viewcontroller.view.addSubview(textStudy)
            
            
            textStudy.text = "  Stack is an abstract data type that serves as a collection of elements. "
            
            var path: String = ""
            
            path = Bundle.main.path(forResource:"Stacks", ofType: "plist")!
            dictData = NSDictionary(contentsOfFile: path)!
            arrayKeys = dictData.allKeys as! [String]
        
            arrayKeys = arrayKeys.sorted(by: {$0 < $1})
            ele = 0
            animation = AnimationStacks(arrayLabel: arrayLabel, graph: graph)

        }
    }
    @objc func step(sender: UIButton) {

        if VIEW_CHOSEN == "study" {
            if (ele==arrayKeys.count){
                textStudy.text = ""
                return
            }
            btnStepBigTmp.isUserInteractionEnabled = false
            
            if(arrayKeys[ele].integerValue==10){
                btnStepBigTmp.isUserInteractionEnabled = true
                let data = dictData[arrayKeys[ele]]
                textStudy.text = data as! String?
            }else if(arrayKeys[ele].integerValue==11){
                let data = dictData[arrayKeys[ele]]
                textStudy.text = data as! String?
                btnStepBigTmp.isUserInteractionEnabled = false
                animation.loop()
            }
            ele = ele + 1
        }
        
    }
}
