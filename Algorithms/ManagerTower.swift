//
//  ManagerTower.swift
//  Algorithms
//
//  Created by TTung on 5/3/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
import UIKit

class ManagerTower {
    
    var graph: Graph_Tower!
    var viewcontroller: UIViewController!
    var tower: TowerOfHaNoi!
    var arrayAction: [TowerStep]!
    var animation: AnimationTower!
    var animationStep: AnimationTower!
    var arrayCenter: [CGPoint]!
    var arrayLabel: [SortingLabel]!
    
    var textStudy: DetailTxtView!
    var dictData = NSDictionary()
    var arrayKeys = [String]()
    var ele = 0
    func initSortWith(viewcontroller: UIViewController) {
        
        
        graph = Graph_Tower(frame: CGRect(x: 0,
                                          y:(viewcontroller.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height * 2,
                                          width: viewcontroller.view.bounds.size.width,
                                          height: viewcontroller.view.bounds.size.height/2))
        viewcontroller.view.addSubview(graph)
        self.arrayAction = getArrayAction()
        self.arrayCenter = graph.bearingCenterPoint
        self.arrayLabel = graph.arrayLabel
        animation = AnimationTower(arrayLabel: arrayLabel, arrayCenter: arrayCenter, arrayAction: arrayAction,graph: graph)
        if(VIEW_CHOSEN=="study"){
            
            textStudy = DetailTxtView(frame: CGRect(x: graph.frame.origin.x + UIApplication.shared.statusBarFrame.height,
                                                y: graph.frame.origin.y+graph.frame.height,
                                                width: graph.frame.width - 2*UIApplication.shared.statusBarFrame.height ,
                                                height: yMax-(graph.frame.origin.y+graph.frame.height)))
            
            viewcontroller.view.addSubview(textStudy)
            
            
            textStudy.text = "The Tower of Hanoi is a mathematical puzzle. It consists of three rods and a number of disks of different sizes, which can slide onto any rod. The puzzle starts with the disks in a neat stack in ascending order of size on one rod, the smallest at the top. The objective of the puzzle is to move the entire stack to another rod."
            
            var path: String = ""
            
            path = Bundle.main.path(forResource:"TowerofHanoi", ofType: "plist")!
            dictData = NSDictionary(contentsOfFile: path)!
            arrayKeys = dictData.allKeys as! [String]
            
            
            arrayKeys = arrayKeys.sorted(by: {$0 < $1})
            ele = 0
            animationStep = AnimationTower(arrayLabel: arrayLabel, arrayCenter: arrayCenter, arrayAction: arrayAction,graph: self.graph)
        }
        
        
    }
    @objc func run(sender: UIButton) {
        
        
        animation = AnimationTower(arrayLabel: arrayLabel, arrayCenter: arrayCenter, arrayAction: arrayAction,graph: self.graph)
        btnRunTmp.isUserInteractionEnabled = false
        btnStepTmp.isUserInteractionEnabled = false
        
        animation.loop()
    }
    
    @objc func step(sender: UIButton) {
        
        if(VIEW_CHOSEN=="study"){
            if(ele==arrayKeys.count){
                textStudy.text = ""
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
                if(arrayKeys[ele].characters.count<5){
                    // thuc hien animation
                    btnStepTmp.isUserInteractionEnabled = false
                    let _step  = String((arrayKeys[ele].floatValue!-11)*10)
                    animation.animationFirst(step: _step.integerValue!)
                    let data = dictData[arrayKeys[ele]]
                    textStudy.text = data as! String?
                }else{
                    let data = dictData[arrayKeys[ele]]
                    textStudy.text = data as! String?
                    self.graph.resetGraph()
                    
                }
                
            }else if(arrayKeys[ele].integerValue==12){
                textStudy.text = "Now. let's begin:" 
                self.graph.resetGraph()
            }else if (arrayKeys[ele].integerValue==13){
                
                let data = dictData[arrayKeys[ele]]
                textStudy.text = data as! String?
                btnStepTmp.isUserInteractionEnabled = false
                btnRunTmp.isUserInteractionEnabled = false
                animationStep.next()
                
            }else if (arrayKeys[ele] == "end"){
                
                textStudy.text = "After 7 steps, the goal of this puzzle is now reached"
                
                btnStepTmp.layer.backgroundColor = UIColor.gray.cgColor
                btnStepTmp.setNeedsDisplay()
                btnStepTmp.isUserInteractionEnabled = false
            }
            
            ele = ele + 1
        }
    }
    
    func getArrayAction() -> [TowerStep]{
        tower = TowerOfHaNoi(disk: 3)
        return tower.arrayAction
    }
}
