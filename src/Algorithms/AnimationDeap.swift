//
//  AnimationDepth.swift
//  Algorithms
//
//  Created by Loc Tran on 5/17/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
import UIKit
class AnimationDepth{
    var graph: GraphBreadthDepth!
    var arrayAction: [DFS_Step]!
    var countSolution = 0
    var currentStep: DFS_Step!
    var arrayLabel:[SortingLabel]!
    var a: SortingLabel!
    var value: Int = 0
    var lastValue = 0
    
    init(graph: GraphBreadthDepth,arrayAction:[DFS_Step],arrayLabel: [SortingLabel]!) {
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

            switch self.currentStep.to{

            case "A":
                self.lastValue = self.value
                self.value = 1
                    self.setColorLabel(change: true)
                    break
            case "B":
                self.lastValue = self.value
                self.value = 4;
                self.setColorLabel(change: false)

                    break;
            case "C":
                self.lastValue = self.value
                self.value = 6;
                self.setColorLabel(change: false);

                    break;
            case "D":
                self.lastValue = self.value
                self.value = 2;
                self.setColorLabel(change: true);

                    break;
            case "E":
                self.lastValue = self.value
                self.value = 7;
                self.setColorLabel(change: false);

                    break;
            case "F":
                self.lastValue = self.value
                self.value = 3;
                self.setColorLabel(change: true);

                    break;
            case "G":
                self.lastValue = self.value
                self.value = 5;
                self.setColorLabel(change: false);

                    break;
            default: break
            }
            
        }){_ in
            self.countSolution += 1
            if(self.countSolution==self.arrayAction.count){
                return
            }
            self.arrayLabel[self.value].layer.borderColor = UIColor.black.cgColor

            self.currentStep = self.arrayAction[self.countSolution]
            self.animation()

        }
    }
    
    func animationStep(){
        UIView.setAnimationsEnabled(true)
        UIView.animate(withDuration: 1, animations: {

            switch self.currentStep.to{


            case "A":
                self.lastValue = self.value
                self.value = 1
                self.setColorLabel(change: true)
                break
            case "B":
                self.lastValue = self.value
                self.value = 4;
                self.setColorLabel(change: false)
                
                break;
            case "C":
                self.lastValue = self.value
                self.value = 6;
                self.setColorLabel(change: false);
                
                break;
            case "D":
                self.lastValue = self.value
                self.value = 2;
                self.setColorLabel(change: true);
                
                break;
            case "E":
                self.lastValue = self.value
                self.value = 7;
                self.setColorLabel(change: false);
                
                break;
            case "F":
                self.lastValue = self.value
                self.value = 3;
                self.setColorLabel(change: true);
                
                break;
            case "G":
                self.lastValue = self.value
                self.value = 5;
                self.setColorLabel(change: false);
                
                break;
            default: break
            }
            
        }){_ in
            self.countSolution += 1
            if(self.countSolution==self.arrayAction.count){
                return
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
        self.arrayLabel[value].layer.backgroundColor = UIColor.green.cgColor
        self.arrayLabel[value].layer.borderColor = UIColor.red.cgColor
        self.arrayLabel[value].layer.setNeedsDisplay()
        if(self.currentStep.act=="push"){

            self.graph.arrayArrow[self.graph.arrowCorresponding(value: value)].fillColor = UIColor.green.cgColor
        }
        else{

            self.graph.arrayLabel[lastValue].alpha = 0.5

            self.graph.arrayArrow[self.graph.arrowCorresponding(value: lastValue)].fillColor = UIColor.black.cgColor

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
