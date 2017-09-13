//
//  AnimationHeap.swift
//  Algorithms
//
//  Created by Loc Tran on 4/6/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
import UIKit

class AnimationHeap {
    
    var arrayLabel: [SortingLabel]!
    var arrayLabelBehind: [SortingLabel]!
    
    var arrayPosition: [SortingLabel]!
    
    var arrayAction: [HeapStep]!
    var colSolution = 0
    
    var currentStep = HeapStep()
    var graphHeap: HeapGraph!
    
    var lineIndex = 0
    
    
    init(arrayLabel:[SortingLabel], arrayLabelBehind: [SortingLabel], arrayPosition: [SortingLabel], arrayAction: [HeapStep], graphHeap: HeapGraph){
        
        self.arrayLabel = arrayLabel
        self.arrayLabelBehind = arrayLabelBehind
        self.arrayPosition = arrayPosition
        
        self.arrayAction = arrayAction
        
        self.graphHeap = graphHeap
        
    }
    
    
    
    func animation() {
        
        //        UIView.setAnimationsEnabled(true)
        UIView.animate(withDuration: 1, animations: {
            if (self.currentStep.act == "start"){
                
                self.moveLabel(from: self.arrayLabel[self.lineIndex], to: self.arrayPosition[self.lineIndex])
                
                self.graphHeap.drawLine(start: self.lineIndex, arrayPosition: self.arrayPosition)
                
            }else if(self.currentStep.act=="swap"){
                self.moveLabel(from: self.arrayLabel[self.currentStep.i], to: self.arrayPosition[self.currentStep.j])
                self.moveLabel(from: self.arrayLabel[self.currentStep.j], to: self.arrayPosition[self.currentStep.i])
                
                self.arrayLabel[self.currentStep.i].backgroundColor = SWAP_COLOR
                self.arrayLabel[self.currentStep.j].backgroundColor = SWAP_COLOR
                
                
                self.swapLabel(i: self.currentStep.i, j: self.currentStep.j)
                
                
            }else if (self.currentStep.act == "moveEndUp"){
                
                self.arrayLabel[self.currentStep.end].backgroundColor = GOLD_COLOR
                
                self.moveLabel(from: self.arrayLabel[self.currentStep.end], to: self.arrayLabelBehind[self.currentStep.end])
                
                self.graphHeap.removeLine()
            }
            
        }){(finished) in
            if (self.currentStep.act == "start"){
                self.lineIndex += 1
                
                if (self.lineIndex == self.arrayLabel.count){
                    self.continueAnimation()
                }else{
                    self.animation()
                }
            }else if (self.currentStep.act == "swap"){
                
                self.arrayLabel[self.currentStep.i].backgroundColor = DEFAULT_COLOR
                self.arrayLabel[self.currentStep.j].backgroundColor = DEFAULT_COLOR
                
                self.continueAnimation()
            }else{
                
                self.continueAnimation()
            }
        }
    }
    
    func animationStep() {
        
        //        UIView.setAnimationsEnabled(true)
        UIView.animate(withDuration: 1, animations: {
            if (self.currentStep.act == "start"){
                
                self.moveLabel(from: self.arrayLabel[self.lineIndex], to: self.arrayPosition[self.lineIndex])
                
                self.graphHeap.drawLine(start: self.lineIndex, arrayPosition: self.arrayPosition)
                
            }else if(self.currentStep.act=="swap"){
                self.moveLabel(from: self.arrayLabel[self.currentStep.i], to: self.arrayPosition[self.currentStep.j])
                self.moveLabel(from: self.arrayLabel[self.currentStep.j], to: self.arrayPosition[self.currentStep.i])
                
                self.arrayLabel[self.currentStep.i].backgroundColor = SWAP_COLOR
                self.arrayLabel[self.currentStep.j].backgroundColor = SWAP_COLOR
                
                
                self.swapLabel(i: self.currentStep.i, j: self.currentStep.j)
                
                
            }else if (self.currentStep.act == "moveEndUp"){
                
                self.arrayLabel[self.currentStep.end].backgroundColor = GOLD_COLOR
                
                self.moveLabel(from: self.arrayLabel[self.currentStep.end], to: self.arrayLabelBehind[self.currentStep.end])
                
                self.graphHeap.removeLine()
            }
            
        }){(finished) in
            if (self.currentStep.act == "start"){
                self.lineIndex += 1
                
                if (self.lineIndex == self.arrayLabel.count){
                    self.continueAnimationStep()
                }else{
                    self.animationStep()
                }
            }else if (self.currentStep.act == "swap"){
                
                self.arrayLabel[self.currentStep.i].backgroundColor = DEFAULT_COLOR
                self.arrayLabel[self.currentStep.j].backgroundColor = DEFAULT_COLOR
                
                self.continueAnimationStep()
            }else{
                
                self.continueAnimationStep()
            }
        }
    }
    
    
    func swapLabel(i: Int, j: Int) {
        let temp = arrayLabel[i]
        arrayLabel[i] = arrayLabel[j]
        arrayLabel[j] = temp
    }
    
    func continueAnimationStep(){
        self.colSolution += 1
        
        if (self.colSolution == self.arrayAction.count) {
            if(VIEW_CHOSEN=="study"){
                btnStepTmp.isUserInteractionEnabled = true
            }else{
                btnStepTmp.isUserInteractionEnabled = false
            }
            return
        }else{
            btnStepTmp.isUserInteractionEnabled = true
            
        }
        self.currentStep = self.arrayAction[self.colSolution]
    }
    
    func continueAnimation(){
        self.colSolution += 1
        
        if (self.colSolution == self.arrayAction.count) {
            return
        }
        self.currentStep = self.arrayAction[self.colSolution]
        self.animation()
    }
    
    func loop(){
        currentStep = self.arrayAction[self.colSolution]
        animation()
    }
    
    func moveLabel(from: SortingLabel, to: SortingLabel) {
        from.center = to.center
    }
    func next(){
        currentStep = self.arrayAction[self.colSolution]
        animationStep()
    }
    
}
