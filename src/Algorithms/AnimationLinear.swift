//
//  AnimationLinear.swift
//  Algorithms
//
//  Created by TTung on 5/9/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
import UIKit

class AnimationLiear {
    
    var arrayLabel: [SortingLabel]!
    var linear: LinearSearch!
    var countSolution = 0
    var graph: GraphLinearBinary!
    var currentStep = LinearStep()
    var arrayAction = [LinearStep]()
    
    init(arrayLabel:[SortingLabel] ,graph: GraphLinearBinary, arrayAction: [LinearStep]){
        self.arrayLabel = arrayLabel
        self.graph = graph
        self.arrayAction = arrayAction
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animation(){
        UIView.setAnimationsEnabled(true)
        UIView.animate(withDuration: 0.5, animations: {
            if self.currentStep.act == "true"{
                self.arrayLabel[self.countSolution].alpha = 0.5
                self.arrayLabel[self.countSolution].layer.backgroundColor = UIColor.green.cgColor
                self.arrayLabel[self.countSolution].text = String(self.graph.arrayFind[self.countSolution])
            }
            else if self.currentStep.act == "false" {
                self.arrayLabel[self.countSolution].alpha = 0.8
                self.arrayLabel[self.countSolution].layer.backgroundColor = UIColor.red.cgColor
                self.arrayLabel[self.countSolution].text = String(self.graph.arrayFind[self.countSolution])
            }
        }) {_ in
            if self.countSolution == self.arrayAction.count - 1 {
                return
            }
                
            else if self.currentStep.act == "false" {
                
                self.countSolution = self.countSolution + 1
                
            }
            else if self.currentStep.act == "true" {
                
                return
            }
            self.currentStep = self.arrayAction[self.countSolution]
            self.animation()
            
        }
    }
    
    func animationStep(){
        UIView.setAnimationsEnabled(true)
        UIView.animate(withDuration: 0.2, animations: {
            if self.currentStep.act == "true"{
                self.arrayLabel[self.countSolution].alpha = 0.5
                self.arrayLabel[self.countSolution].layer.backgroundColor = UIColor.green.cgColor
                self.arrayLabel[self.countSolution].text = String(self.graph.arrayFind[self.countSolution])
            }
            else if self.currentStep.act == "false" {
                self.arrayLabel[self.countSolution].alpha = 0.8
                self.arrayLabel[self.countSolution].layer.backgroundColor = UIColor.red.cgColor
                self.arrayLabel[self.countSolution].text = String(self.graph.arrayFind[self.countSolution])
            }
        }) {_ in
            if self.countSolution == self.arrayAction.count - 1 {
                return
            }
                
            else if self.currentStep.act == "false" {
                
                self.countSolution = self.countSolution + 1
                
            }
            else if self.currentStep.act == "true" {
                
                return
            }
            btnStepTmp.isUserInteractionEnabled = true
            self.currentStep = self.arrayAction[self.countSolution]
            
        }
    }
    
    func next(){
        self.currentStep = arrayAction[countSolution]
        animationStep()
    }
    
    func loop(){
        self.currentStep = arrayAction[countSolution]
        animation()
    }
    
}
