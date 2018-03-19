//
//  AnimationInsertion.swift
//  Algorithms
//
//  Created by Loc Tran on 3/28/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
import UIKit

class AnimationInsertion {
    
    var arrayAction: [InsertStep]!
    var colSolution = 0
    var currentStep = InsertStep()
    var isMOVE = false
    var compareCout = 0
    var swapCount = 0
    
    var arrayLabel: [SortingLabel]!
    var arrayLabelAbove: [SortingLabel]!
    var arrayLabelMiddle: [SortingLabel]!
    var arrayLabelBelow: [SortingLabel]!
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(arrayLabel:[SortingLabel] , arrayLabelMiddle: [SortingLabel], arrayLabelAbove: [SortingLabel], arrayLabelBelow: [SortingLabel], arrayAction: [InsertStep]){
        
        self.arrayAction = arrayAction
        self.arrayLabel = arrayLabel
        self.arrayLabelAbove = arrayLabelAbove
        self.arrayLabelBelow = arrayLabelBelow
        self.arrayLabelMiddle = arrayLabelMiddle
        
    }
    
    func animation(){
        
        UIView.setAnimationsEnabled(true)
        UIView.animate(withDuration: 1, animations: {
            if (self.currentStep.act == "start"){
                self.isMOVE = false
                self.arrayLabel[self.currentStep.i].backgroundColor = KEY_COLOR
                self.moveLabel(from: self.arrayLabel[self.currentStep.i], to: self.arrayLabelAbove[self.currentStep.i])
                
            }
            
            if (self.currentStep.act == "move"){
                self.isMOVE = true
                self.arrayLabel[self.currentStep.i].backgroundColor = COMPARE_COLOR
                self.compareCout = self.compareCout + 1
                
                self.moveLabel(from: self.arrayLabel[self.currentStep.i], to:self.arrayLabelMiddle[self.currentStep.j] )
                self.moveLabel(from: self.arrayLabel[self.currentStep.j], to: self.arrayLabelAbove[self.currentStep.i])
                self.swapLabel(i: self.currentStep.i, j: self.currentStep.j)
                
            }
            
            if (self.currentStep.act == "end"){
                if(self.isMOVE){
                    self.swapCount = self.swapCount + 1
                    
                    self.arrayLabel[self.currentStep.key].backgroundColor = SWAP_COLOR
                    
                    
                }else{
                    
                    self.arrayLabel[self.currentStep.key].backgroundColor = COMPARE_COLOR
                    self.compareCout = self.compareCout + 1
                    
                }
                self.moveLabel(from: self.arrayLabel[self.currentStep.key], to: self.arrayLabelMiddle[self.currentStep.key])
            }
            
        }){_ in
            if (self.currentStep.act == "move"){
                self.arrayLabel[self.currentStep.j].backgroundColor = DEFAULT_COLOR
            }
            if (self.currentStep.act == "end"){
                self.arrayLabel[self.currentStep.j].backgroundColor = DEFAULT_COLOR
                self.arrayLabel[self.currentStep.key].backgroundColor = DEFAULT_COLOR
                
                
            }
            self.continueAnimation()
        }
    }
    
    func animationStep(){
        
        UIView.setAnimationsEnabled(true)
        UIView.animate(withDuration: 0.3, animations: {
            if (self.currentStep.act == "start"){
                self.isMOVE = false
                self.arrayLabel[self.currentStep.i].backgroundColor = KEY_COLOR
                self.moveLabel(from: self.arrayLabel[self.currentStep.i], to: self.arrayLabelAbove[self.currentStep.i])
                
            }
            
            if (self.currentStep.act == "move"){
                self.isMOVE = true
                self.arrayLabel[self.currentStep.i].backgroundColor = COMPARE_COLOR
                self.compareCout = self.compareCout + 1
                
                self.moveLabel(from: self.arrayLabel[self.currentStep.i], to:self.arrayLabelMiddle[self.currentStep.j] )
                self.moveLabel(from: self.arrayLabel[self.currentStep.j], to: self.arrayLabelAbove[self.currentStep.i])
                self.swapLabel(i: self.currentStep.i, j: self.currentStep.j)
                
                
            }
            
            if (self.currentStep.act == "end"){
                if(self.isMOVE){
                    self.swapCount = self.swapCount + 1
                    
                    self.arrayLabel[self.currentStep.key].backgroundColor = SWAP_COLOR
                    
                    
                }else{
                    
                    self.arrayLabel[self.currentStep.key].backgroundColor = COMPARE_COLOR
                    self.compareCout = self.compareCout + 1
                    
                }
                self.moveLabel(from: self.arrayLabel[self.currentStep.key], to: self.arrayLabelMiddle[self.currentStep.key])
            }
            
        }){_ in
            if (self.currentStep.act == "move"){
                self.arrayLabel[self.currentStep.j].backgroundColor = DEFAULT_COLOR
            }
            if (self.currentStep.act == "end"){
                self.arrayLabel[self.currentStep.j].backgroundColor = DEFAULT_COLOR
                self.arrayLabel[self.currentStep.key].backgroundColor = DEFAULT_COLOR
                
            }
            self.continueAnimationStep()
            
        }
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
    
    func swapLabel(i: Int, j: Int) {
        let temp = arrayLabel[i]
        arrayLabel[i] = arrayLabel[j]
        arrayLabel[j] = temp
    }
}
