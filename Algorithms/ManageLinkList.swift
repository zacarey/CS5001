//
//  ManageLinkList.swift
//  Algorithms
//
//  Created by Ledung95d on 5/5/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
import UIKit

class ManagerLinkList{
    var graph: Graph_LinkList!
    var animationStep: AnimationLinkList!
    var textStudy: DetailTxtView!
    var dictData = NSDictionary()
    var arrayKeys = [String]()
    var ele = 0
    func initSortWith(viewcontroller: UIViewController){
        graph = Graph_LinkList(frame: CGRect(x: 0,
                                             y:(viewcontroller.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height * 2,
                                             width: viewcontroller.view.bounds.size.width,
                                             height: viewcontroller.view.bounds.size.height/2))
        viewcontroller.view.addSubview(graph)

        if(VIEW_CHOSEN=="study"){

            textStudy = DetailTxtView(frame: CGRect(x: graph.frame.origin.x + UIApplication.shared.statusBarFrame.height,
                                                y: graph.frame.origin.y+graph.frame.height,
                                                width: graph.frame.width - 2*UIApplication.shared.statusBarFrame.height ,
                                                height: yMax-(graph.frame.origin.y+graph.frame.height)))

            viewcontroller.view.addSubview(textStudy)



            var path: String = ""

            path = Bundle.main.path(forResource:"LinkList", ofType: "plist")!
            dictData = NSDictionary(contentsOfFile: path)!
            arrayKeys = dictData.allKeys as! [String]


            arrayKeys = arrayKeys.sorted(by: {$0 < $1})
            ele = 0
            animationStep = AnimationLinkList(graph: graph)
        }

    }
    @objc func step(sender: UIButton) {

        if(VIEW_CHOSEN=="study"){
            if(ele==arrayKeys.count){
                textStudy.text = ""
                 btnStepTmp.isUserInteractionEnabled = false
                return
            }

            btnRunTmp.isUserInteractionEnabled = false
            btnRunTmp.layer.backgroundColor = UIColor.gray.cgColor
            btnRunTmp.setNeedsDisplay()

            if(arrayKeys[ele].integerValue==10){
                btnStepTmp.isUserInteractionEnabled = true
                let data = dictData[arrayKeys[ele]]
                textStudy.text = data as! String?
                
            }else if(arrayKeys[ele].integerValue==11){
                btnStepTmp.isUserInteractionEnabled = false
                let _step  = String((arrayKeys[ele].floatValue!-11)*10)
                animationStep.animationStep(step: _step.integerValue!)
                let data = dictData[arrayKeys[ele]]
                textStudy.text = data as! String?

            }else if(arrayKeys[ele].integerValue==12){
                btnStepTmp.isUserInteractionEnabled = false
                let _step  = String((arrayKeys[ele].floatValue!-12)*10)
                animationStep.animationStep(step: _step.integerValue!)
                let data = dictData[arrayKeys[ele]]
                textStudy.text = data as! String?

            }else{
                btnStepTmp.isUserInteractionEnabled = false
                let data = dictData[arrayKeys[ele]]
                textStudy.text = data as! String?
                
            }
            ele = ele + 1
        }
    }
    
    
}
