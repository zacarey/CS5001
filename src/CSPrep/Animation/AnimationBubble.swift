//
//  AnimationBubble.swift
//  Algorithms
//
//  Created by Loc Tran on 3/21/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
import UIKit

class AnimationBubble {
    
    var arrayAction: [Step]!
    var colSolution = 0
    var currentStep = Step()
    
    var arrayLabel: [SortingLabel]!
    var arrayLabelAbove: [SortingLabel]!
    var arrayLabelMiddle: [SortingLabel]!
    var arrayLabelBelow: [SortingLabel]!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(arrayLabel:[SortingLabel] , arrayLabelMiddle: [SortingLabel], arrayLabelAbove: [SortingLabel], arrayLabelBelow: [SortingLabel], arrayAction: [Step]){
        
        self.arrayAction = arrayAction
        self.arrayLabel = arrayLabel
        self.arrayLabelAbove = arrayLabelAbove
        self.arrayLabelBelow = arrayLabelBelow
        self.arrayLabelMiddle = arrayLabelMiddle
    }
    
    func animation() {
        
        UIView.setAnimationsEnabled(true)
        UIView.animate(withDuration: 0.5, animations: {
            if (self.currentStep.act == "compare") {
                self.arrayLabel[self.currentStep.i].backgroundColor = COMPARE_COLOR
                self.arrayLabel[self.currentStep.j].backgroundColor = COMPARE_COLOR
                
                
                self.arrayLabel[self.currentStep.i].alpha = 0.95
                self.arrayLabel[self.currentStep.j].alpha = 0.95
            }
            else
            {
                self.arrayLabel[self.currentStep.i].backgroundColor = SWAP_COLOR
                self.arrayLabel[self.currentStep.j].backgroundColor = SWAP_COLOR
                
                
                self.arrayLabel[self.currentStep.i].alpha = 0.95
                self.arrayLabel[self.currentStep.j].alpha = 0.95
            }
        }){(finished) in
            if (self.currentStep.act == "compare") {
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.arrayLabel[self.currentStep.i].alpha = DEFAULT_ALPHA
                    self.arrayLabel[self.currentStep.j].alpha = DEFAULT_ALPHA
                }) {_ in
                    
                    self.arrayLabel[self.currentStep.i].backgroundColor = DEFAULT_COLOR
                    self.arrayLabel[self.currentStep.j].backgroundColor = DEFAULT_COLOR
                    
                    self.continueAnimation()
                }
            }
            else
            {
                UIView.animate(withDuration: 0.5, animations: {
                    self.moveLabel(from: self.arrayLabel[self.currentStep.i], to: self.arrayLabelAbove[self.currentStep.i])
                    self.moveLabel(from: self.arrayLabel[self.currentStep.j], to: self.arrayLabelBelow[self.currentStep.j])
                }){_ in
                    UIView.animate(withDuration: 0.5, animations: {
                        self.moveLabel(from: self.arrayLabel[self.currentStep.i], to: self.arrayLabelAbove[self.currentStep.j])
                        self.moveLabel(from: self.arrayLabel[self.currentStep.j], to: self.arrayLabelBelow[self.currentStep.i])
                    }){_ in
                        UIView.animate(withDuration: 0.5, animations: {
                            
                            self.moveLabel(from: self.arrayLabel[self.currentStep.i], to: self.arrayLabelMiddle[self.currentStep.j])
                            self.moveLabel(from: self.arrayLabel[self.currentStep.j], to: self.arrayLabelMiddle[self.currentStep.i])
                        }){_ in
                            self.arrayLabel[self.currentStep.i].backgroundColor = DEFAULT_COLOR
                            self.arrayLabel[self.currentStep.j].backgroundColor = DEFAULT_COLOR
                            
                            self.arrayLabel[self.currentStep.i].alpha = DEFAULT_ALPHA
                            self.arrayLabel[self.currentStep.j].alpha = DEFAULT_ALPHA
                            
                            self.swapLabel(i: self.currentStep.i, j: self.currentStep.j)
                            
                            self.continueAnimation()
                        }
                    }
                }
            }
        }
    }
    
    func animationStep() {
        UIView.setAnimationsEnabled(true)
        UIView.animate(withDuration: 0.5, animations: {
            if (self.currentStep.act == "compare") {
                self.arrayLabel[self.currentStep.i].backgroundColor = COMPARE_COLOR
                self.arrayLabel[self.currentStep.j].backgroundColor = COMPARE_COLOR
                
                self.arrayLabel[self.currentStep.i].alpha = 0.95
                self.arrayLabel[self.currentStep.j].alpha = 0.95
            }
            else
            {
                
                self.arrayLabel[self.currentStep.i].backgroundColor = SWAP_COLOR
                self.arrayLabel[self.currentStep.j].backgroundColor = SWAP_COLOR
                
                self.arrayLabel[self.currentStep.i].alpha = 0.95
                self.arrayLabel[self.currentStep.j].alpha = 0.95
            }
        }){(finished) in
            if (self.currentStep.act == "compare") {
                UIView.animate(withDuration: 0.5, animations: {
                    self.arrayLabel[self.currentStep.i].alpha = DEFAULT_ALPHA
                    self.arrayLabel[self.currentStep.j].alpha = DEFAULT_ALPHA
                }) {_ in
                    
                    self.arrayLabel[self.currentStep.i].backgroundColor = DEFAULT_COLOR
                    self.arrayLabel[self.currentStep.j].backgroundColor = DEFAULT_COLOR
                    
                    self.continueAnimationStep()
                }
            }
            else{
                UIView.animate(withDuration: 0.5, animations: {
                    self.moveLabel(from: self.arrayLabel[self.currentStep.i], to: self.arrayLabelAbove[self.currentStep.i])
                    self.moveLabel(from: self.arrayLabel[self.currentStep.j], to: self.arrayLabelBelow[self.currentStep.j])
                    
                }){_ in
                    UIView.animate(withDuration: 0.5, animations: {
                        self.moveLabel(from: self.arrayLabel[self.currentStep.i], to: self.arrayLabelAbove[self.currentStep.j])
                        self.moveLabel(from: self.arrayLabel[self.currentStep.j], to: self.arrayLabelBelow[self.currentStep.i])
                    }){_ in
                        UIView.animate(withDuration: 0.5, animations: {
                            self.moveLabel(from: self.arrayLabel[self.currentStep.i], to: self.arrayLabelMiddle[self.currentStep.j])
                            self.moveLabel(from: self.arrayLabel[self.currentStep.j], to: self.arrayLabelMiddle[self.currentStep.i])
                        }){_ in
                            self.arrayLabel[self.currentStep.i].backgroundColor = DEFAULT_COLOR
                            self.arrayLabel[self.currentStep.j].backgroundColor = DEFAULT_COLOR
                            
                            self.arrayLabel[self.currentStep.i].alpha = DEFAULT_ALPHA
                            self.arrayLabel[self.currentStep.j].alpha = DEFAULT_ALPHA
                            
                            self.swapLabel(i: self.currentStep.i, j: self.currentStep.j)
                            
                            self.continueAnimationStep()
                            
                        }
                    }
                }
            }
        }
    }
    
    
    func swapLabel(i: Int, j: Int) {
        let temp = arrayLabel[i]
        arrayLabel[i] = arrayLabel[j]
        arrayLabel[j] = temp
    }
    
    func continueAnimation(){
        self.colSolution += 1
        
        if (self.colSolution == self.arrayAction.count) {
            return
        }
        self.currentStep = self.arrayAction[self.colSolution]
        self.animation()
    }
    
    func continueAnimationStep(){
        self.colSolution += 1
        
        if (self.colSolution == self.arrayAction.count) {
//            if(VIEW_CHOSEN=="study"){
//                btnStepTmp.isUserInteractionEnabled = true
//            }else{
//                btnStepTmp.isUserInteractionEnabled = false
//                
//            }
            
            btnStepTmp.isUserInteractionEnabled = true
            return
        }else{
            btnStepTmp.isUserInteractionEnabled = true
            
        }
        self.currentStep = self.arrayAction[self.colSolution]
    }
    
    func loop(){
        currentStep = self.arrayAction[self.colSolution]
        animation()
    }
    
    func next(){
        currentStep = self.arrayAction[self.colSolution]
        animationStep()
    }
    
    
    func moveLabel(from: SortingLabel, to: SortingLabel) {
        from.center = to.center
    }
}

