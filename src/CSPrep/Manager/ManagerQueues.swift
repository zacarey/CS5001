//
//  ManagerQueues.swift
//  Algorithms
//
//  Created by Loc Tran on 5/6/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
import UIKit

class ManagerQueues {
    
    var graph: GraphQueues!
    var viewcontroller: UIViewController!
    var animation: AnimationQueues!
    var arrayLabel: [SortingLabel]!
    
    var textStudy: DetailTxtView!
    var dictData = NSDictionary()
    var arrayKeys = [String]()
    var ele = 0
    
    
    func initQueues(viewcontroller: UIViewController){
        
        graph = GraphQueues(frame: CGRect(x: 0,
                                          y:(viewcontroller.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height * 2,
                                          width: viewcontroller.view.bounds.size.width,
                                          height: viewcontroller.view.bounds.size.height/2))
        
        y_nav = (viewcontroller.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height * 2
        viewcontroller.view.addSubview(graph)
        self.arrayLabel = graph.arrayLabel
        animation = AnimationQueues(arrayLabel: arrayLabel, graph: graph)
        
        textStudy = DetailTxtView(frame: CGRect(x: graph.frame.origin.x + UIApplication.shared.statusBarFrame.height,
                                                y: graph.frame.origin.y+graph.frame.height,
                                                width: graph.frame.width - 2*UIApplication.shared.statusBarFrame.height ,
                                                height: yMax-(graph.frame.origin.y+graph.frame.height)))
        
        viewcontroller.view.addSubview(textStudy)
        
        
        textStudy.text = "  A queue is a list where you can only insert new items at the back and remove items from the front. This ensures that the first item you enqueue is also the first item you dequeue. First come, first serve! "
        var path: String = ""
        
        path = Bundle.main.path(forResource:"Queues", ofType: "plist")!
        dictData = NSDictionary(contentsOfFile: path)!
        arrayKeys = dictData.allKeys as! [String]
        
        arrayKeys = arrayKeys.sorted(by: {$0 < $1})
        ele = 0
        animation = AnimationQueues(arrayLabel: arrayLabel, graph: graph)
        
        
        
    }
    @objc func step(sender: UIButton) {
        
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
