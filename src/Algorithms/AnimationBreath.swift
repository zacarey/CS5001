//
//  AnimationBreath.swift
//  Algorithms
//
//  Created by TTung on 5/19/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
import UIKit

class AnimationBreath{
    
    var graph: GraphBreadthDeap!
    var arrayAction: [BFS_Step]!
    var countSolution = 0
    var currentStep: BFS_Step!
    var arrayLabel:[SortingLabel]!
    var value: Int = 0
    var lastValue = 0
    var nextSolution = true
    
    init(graph: GraphBreadthDeap,arrayAction:[BFS_Step],arrayLabel: [SortingLabel]!) {
        self.graph = graph
        self.arrayAction = arrayAction
        self.arrayLabel = arrayLabel
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func animation(){
        UIView.setAnimationsEnabled(true)
        UIView.animate(withDuration: 1, animations: {
            
            switch self.currentStep.point{
                
            case "A":
                self.lastValue = self.value
                self.value = 1
                self.setColorLabel(change: true)
                self.nextSolution = true
                break
            case "B":
                self.lastValue = self.value
                self.value = 4;
                self.setColorLabel(change: false)
                self.nextSolution = false
                
                break;
            case "C":
                self.lastValue = self.value
                self.value = 6;
                self.setColorLabel(change: false);
                self.nextSolution = false
                
                break;
            case "D":
                self.lastValue = self.value
                self.value = 2;
                self.setColorLabel(change: true);
                self.nextSolution = true
                
                break;
            case "E":
                self.lastValue = self.value
                self.value = 7;
                self.nextSolution = true
                self.setColorLabel(change: false);
                
                break;
            case "F":
                self.lastValue = self.value
                self.value = 3;
                self.nextSolution = true
                self.setColorLabel(change: true);
                
                break;
            case "G":
                self.lastValue = self.value
                self.value = 5;
                self.nextSolution = false
                self.setColorLabel(change: false);
                
                break;
            default: break
            }
            
        }){_ in
            self.countSolution += 1
            if(self.countSolution==self.arrayAction.count){
                return
            }
            else if (self.currentStep.act == "putOut" && self.nextSolution == false){
                
                self.arrayLabel[self.value].layer.backgroundColor = UIColor.green.withAlphaComponent(0.5).cgColor
                self.arrayLabel[self.value].layer.borderColor = UIColor.black.cgColor

                self.arrayLabel[self.value].layer.setNeedsDisplay()
                self.graph.arrayArrow[self.graph.arrowCorresponding(value: self.value)].fillColor = UIColor.black.cgColor
            }
            self.currentStep = self.arrayAction[self.countSolution]
            self.animation()
        }
    }
    
    func animationStep(){
        UIView.setAnimationsEnabled(true)
        UIView.animate(withDuration: 1, animations: {
            
            switch self.currentStep.point{
                
            case "A":
                self.lastValue = self.value
                self.value = 1
                self.setColorLabel(change: true)
                self.nextSolution = true
                break
            case "B":
                self.lastValue = self.value
                self.value = 4;
                self.setColorLabel(change: false)
                self.nextSolution = false
                
                break;
            case "C":
                self.lastValue = self.value
                self.value = 6;
                self.setColorLabel(change: false);
                self.nextSolution = false
                
                break;
            case "D":
                self.lastValue = self.value
                self.value = 2;
                self.setColorLabel(change: true);
                self.nextSolution = true
                
                break;
            case "E":
                self.lastValue = self.value
                self.value = 7;
                self.nextSolution = true
                self.setColorLabel(change: false);
                
                break;
            case "F":
                self.lastValue = self.value
                self.value = 3;
                self.nextSolution = true
                self.setColorLabel(change: true);
                
                break;
            case "G":
                self.lastValue = self.value
                self.value = 5;
                self.nextSolution = false
                self.setColorLabel(change: false);
                
                break;
            default: break
            }
            
        }){_ in
            self.countSolution += 1
            if(self.countSolution==self.arrayAction.count){
                return
            }
            else if (self.currentStep.act == "putOut" && self.nextSolution == false){
                self.arrayLabel[self.value].layer.backgroundColor = UIColor.green.withAlphaComponent(0.5).cgColor
                 self.arrayLabel[self.value].layer.borderColor = UIColor.black.cgColor
                self.arrayLabel[self.value].layer.setNeedsDisplay()
                self.graph.arrayArrow[self.graph.arrowCorresponding(value: self.value)].fillColor = UIColor.black.cgColor
            }
            btnStepTmp.isUserInteractionEnabled = true
            self.currentStep = self.arrayAction[self.countSolution]
        }
    }
    
    func setColorLabel(change: Bool){
        if(change){
            self.arrayLabel[value].text = "\u{f00d}"
            self.arrayLabel[value].font = UIFont.fontAwesome(ofSize: 12)
        }
        
        if(self.currentStep.act=="putOut"){
            self.arrayLabel[value].layer.backgroundColor = UIColor.green.withAlphaComponent(1).cgColor
            self.arrayLabel[value].layer.borderColor = UIColor.red.cgColor

            self.arrayLabel[value].layer.setNeedsDisplay()

                    }
        else{

            self.arrayLabel[value].layer.backgroundColor = UIColor.green.withAlphaComponent(0.5).cgColor
            self.arrayLabel[value].layer.setNeedsDisplay()

            self.graph.arrayArrow[self.graph.arrowCorresponding(value: value)].fillColor = UIColor.green.cgColor
            
        }
    }
    
    func loop(){
        self.currentStep = arrayAction[countSolution]
        animation()
    }
    func next(){
        self.currentStep = arrayAction[countSolution]
        animationStep()
    }
    
}
