
//
//  AnimationQuick.swift
//  Algorithms
//
//  Created by Loc Tran on 3/21/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
import UIKit

class AnimationQuick {
    
    var arrayLabel: [SortingLabel]!
    var arrayLabelAbove: [SortingLabel]!
    var arrayLabelMiddle: [SortingLabel]!
    var arrayLabelMark: [SortingLabel]!
    var graph: QuickGraph!
    
    var arrayAction: [QuickStep]!
    var colSolution = 0
    var currentStep = QuickStep()
    var _layer: CALayer!
    var traceLeft: UILabel!
    var traceRight: UILabel!
    var tracePivot: UILabel!
    var traceCoinCide: UILabel!
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(arrayLabel:[SortingLabel] , arrayLabelMiddle: [SortingLabel], arrayLabelAbove: [SortingLabel], arrayLabelMark: [SortingLabel], arrayAction: [QuickStep],graph: QuickGraph){
        
        self.arrayAction = arrayAction
        self.arrayLabel = arrayLabel
        self.arrayLabelAbove = arrayLabelAbove
        self.arrayLabelMark = arrayLabelMark
        self.arrayLabelMiddle = arrayLabelMiddle
        self.graph = graph
        iniTrace()
        
    }
    
    func iniTrace(){
        traceLeft = self.graph.drawMark(textLR: "L")
        traceRight = self.graph.drawMark(textLR: "R")
        tracePivot = self.graph.drawMark(textLR: "P")
        
        _layer = CALayer()// khoi tao cai nay de remove step newPivot luc dau
        
        self.graph.addSubview(traceLeft)
        self.graph.addSubview(traceRight)
        self.graph.addSubview(tracePivot)
        
        
        traceLeft.isHidden = true
        traceRight.isHidden = true
        tracePivot.isHidden = true
        
        
    }
    
    
    func iniPosition_Mark(currentStep: QuickStep){
        let point = CGPoint(x: self.arrayLabelMiddle[self.currentStep.pivot+1].frame.origin.x, y: self.arrayLabelMiddle[self.currentStep.pivot+1].frame.origin.y - CGFloat(10) - RECTSIZE)
        tracePivot.frame.origin = CGPoint(x: point.x+5, y: point.y)
        traceLeft.center = self.arrayLabelMark[self.currentStep.left+1].center
        traceRight.center = self.arrayLabelMark[self.currentStep.right+1].center
        
    }
    
    func animation() {
        
        UIView.animate(withDuration: 1, animations: {
            if(self.currentStep.act=="newPivot"){
                
                if(self.colSolution>0){
                    self.arrayLabel[self.arrayAction[self.colSolution-1].pivot].alpha = DEFAULT_ALPHA
                    self.removeSuperTrace()
                }
                
                self._layer = self.graph.drawBrace(bearing: self.currentStep.left+1, countCell: (self.currentStep.right-self.currentStep.left+1))
                self.iniPosition_Mark(currentStep: self.currentStep)
            }else if(self.currentStep.act=="pauseLeft"){
                self.setPosition(traceLabel: self.traceLeft, _setPosition: self.currentStep.left)
                
            }else if(self.currentStep.act=="moveRight"){
                self.setPosition(traceLabel: self.traceRight, _setPosition: self.currentStep.right)
            }else if(self.currentStep.act=="pauseRight"){
                self.setPosition(traceLabel: self.traceRight, _setPosition: self.currentStep.right)
                
            }else if(self.currentStep.act=="moveLeft"){
                self.setPosition(traceLabel: self.traceLeft, _setPosition: self.currentStep.left)
            }else if(self.currentStep.act=="swap"){
                
                self.arrayLabel[self.currentStep.left].backgroundColor = SWAP_COLOR
                self.arrayLabel[self.currentStep.right].backgroundColor = SWAP_COLOR
                self.arrayLabel[self.currentStep.left].center = CGPoint(x: self.arrayLabelAbove[self.currentStep.left+1].center.x, y: self.arrayLabelAbove[self.currentStep.left+1].frame.origin.y-RECTSIZE)
                self.arrayLabel[self.currentStep.right].center = CGPoint(x: self.arrayLabelAbove[self.currentStep.right+1].center.x, y: self.arrayLabelAbove[self.currentStep.right+1].frame.origin.y-RECTSIZE)
                
            }else if(self.currentStep.act=="moveBoth"){
                self.setPosition(traceLabel: self.traceLeft, _setPosition: self.currentStep.left)
                self.setPosition(traceLabel: self.traceRight, _setPosition: self.currentStep.right)
            }else if(self.currentStep.act=="outLeft"){
                self.setPosition(traceLabel: self.traceRight, _setPosition: self.currentStep.right)
                
            }else if(self.currentStep.act=="outRight"){
                self.setPosition(traceLabel: self.traceLeft, _setPosition: self.currentStep.left)
                
            }
            
            
        }){_ in // ket thuc
            if(self.currentStep.act=="newPivot"){
                UIView.animate(withDuration: 0.5, animations: {
                    
                    self.arrayLabel[self.currentStep.pivot].alpha = ANIMATION_ALPHA
                    self.tracePivot.isHidden = false
                    
                }){_ in
                    UIView.animate(withDuration: 0.2, animations: {
                        self.traceLeft.isHidden = false
                        self.traceRight.isHidden = false
                        
                    }){_ in
                        
                        self.continueAnimation()
                    }
                    
                }
            }else if(self.currentStep.act=="pauseLeft"){
                UIView.animate(withDuration: 1, animations: {
                    self.traceLeft.backgroundColor = SLATEGRAY_COLOR
                    
                }){_ in
                    self.continueAnimation()
                    
                }
            }else if(self.currentStep.act=="moveRight"){
                self.continueAnimation()
            }else if(self.currentStep.act=="pauseRight"){
                UIView.animate(withDuration: 1, animations: {
                    self.traceRight.backgroundColor = SLATEGRAY_COLOR
                }){_ in
                    self.continueAnimation()
                }
            }else if(self.currentStep.act=="moveLeft"){
                self.continueAnimation()
            }else if(self.currentStep.act=="swap"){
                UIView.animate(withDuration: 0.5, animations: {
                    self.setPivot(traceLabel: self.tracePivot, _setPivot: self.currentStep.pivot)
                    self.swapLabel(i: self.currentStep.left, j: self.currentStep.right)
                    
                }){_ in
                    UIView.animate(withDuration: 1, animations: {
                        self.arrayLabel[self.currentStep.left].center = self.arrayLabelMiddle[self.currentStep.left+1].center
                        self.arrayLabel[self.currentStep.right].center = self.arrayLabelMiddle[self.currentStep.right+1].center
                    }){_ in
                        self.arrayLabel[self.currentStep.left].backgroundColor = DEFAULT_COLOR
                        self.arrayLabel[self.currentStep.right].backgroundColor = DEFAULT_COLOR
                        self.traceRight.backgroundColor = UIColor.red
                        self.traceLeft.backgroundColor = UIColor.blue
                        self.continueAnimation()
                    }
                    
                }
            }else if(self.currentStep.act=="moveBoth"){
                self.continueAnimation()
                
            }else if(self.currentStep.act=="outLeft"){
                self.continueAnimation()
            }else if(self.currentStep.act=="outRight"){
                self.continueAnimation()
            }
            
        }
        
        
    }
    
    func animationStep() {
        
        UIView.animate(withDuration: 1, animations: {
            if(self.currentStep.act=="newPivot"){
                
                if(self.colSolution>0){
                    self.arrayLabel[self.arrayAction[self.colSolution-1].pivot].alpha = DEFAULT_ALPHA
                    self.removeSuperTrace()
                }
                
                self._layer = self.graph.drawBrace(bearing: self.currentStep.left+1, countCell: (self.currentStep.right-self.currentStep.left+1))
                self.iniPosition_Mark(currentStep: self.currentStep)
            }else if(self.currentStep.act=="pauseLeft"){
                self.setPosition(traceLabel: self.traceLeft, _setPosition: self.currentStep.left)
                
            }else if(self.currentStep.act=="moveRight"){
                self.setPosition(traceLabel: self.traceRight, _setPosition: self.currentStep.right)
            }else if(self.currentStep.act=="pauseRight"){
                self.setPosition(traceLabel: self.traceRight, _setPosition: self.currentStep.right)
                
            }else if(self.currentStep.act=="moveLeft"){
                self.setPosition(traceLabel: self.traceLeft, _setPosition: self.currentStep.left)
            }else if(self.currentStep.act=="swap"){
                
                self.arrayLabel[self.currentStep.left].backgroundColor = SWAP_COLOR
                self.arrayLabel[self.currentStep.right].backgroundColor = SWAP_COLOR
                self.arrayLabel[self.currentStep.left].center = CGPoint(x: self.arrayLabelAbove[self.currentStep.left+1].center.x, y: self.arrayLabelAbove[self.currentStep.left+1].frame.origin.y-RECTSIZE)
                self.arrayLabel[self.currentStep.right].center = CGPoint(x: self.arrayLabelAbove[self.currentStep.right+1].center.x, y: self.arrayLabelAbove[self.currentStep.right+1].frame.origin.y-RECTSIZE)
                
            }else if(self.currentStep.act=="moveBoth"){
                self.setPosition(traceLabel: self.traceLeft, _setPosition: self.currentStep.left)
                self.setPosition(traceLabel: self.traceRight, _setPosition: self.currentStep.right)
            }else if(self.currentStep.act=="outLeft"){
                self.setPosition(traceLabel: self.traceRight, _setPosition: self.currentStep.right)
                
            }else if(self.currentStep.act=="outRight"){
                self.setPosition(traceLabel: self.traceLeft, _setPosition: self.currentStep.left)
                
            }
            
            
        }){_ in // ket thuc
            if(self.currentStep.act=="newPivot"){
                UIView.animate(withDuration: 0.5, animations: {
                    
                    self.arrayLabel[self.currentStep.pivot].alpha = ANIMATION_ALPHA
                    self.tracePivot.isHidden = false
                    
                }){_ in
                    UIView.animate(withDuration: 0.2, animations: {
                        self.traceLeft.isHidden = false
                        self.traceRight.isHidden = false
                        
                    }){_ in
                        
                        self.continueAnimationStep()
                    }
                    
                }
            }else if(self.currentStep.act=="pauseLeft"){
                UIView.animate(withDuration: 1, animations: {
                    self.traceLeft.backgroundColor = SLATEGRAY_COLOR
                    
                }){_ in
                    self.continueAnimationStep()
                    
                }
            }else if(self.currentStep.act=="moveRight"){
                self.continueAnimationStep()
            }else if(self.currentStep.act=="pauseRight"){
                UIView.animate(withDuration: 1, animations: {
                    self.traceRight.backgroundColor = SLATEGRAY_COLOR
                }){_ in
                    self.continueAnimationStep()
                }
            }else if(self.currentStep.act=="moveLeft"){
                self.continueAnimationStep()
            }else if(self.currentStep.act=="swap"){
                UIView.animate(withDuration: 0.5, animations: {
                    self.setPivot(traceLabel: self.tracePivot, _setPivot: self.currentStep.pivot)
                    self.swapLabel(i: self.currentStep.left, j: self.currentStep.right)
                    
                }){_ in
                    UIView.animate(withDuration: 1, animations: {
                        self.arrayLabel[self.currentStep.left].center = self.arrayLabelMiddle[self.currentStep.left+1].center
                        self.arrayLabel[self.currentStep.right].center = self.arrayLabelMiddle[self.currentStep.right+1].center
                    }){_ in
                        self.arrayLabel[self.currentStep.left].backgroundColor = DEFAULT_COLOR
                        self.arrayLabel[self.currentStep.right].backgroundColor = DEFAULT_COLOR
                        self.traceRight.backgroundColor = UIColor.red
                        self.traceLeft.backgroundColor = UIColor.blue
                        self.continueAnimationStep()
                    }
                    
                }
            }else if(self.currentStep.act=="moveBoth"){
                self.continueAnimationStep()
                
            }else if(self.currentStep.act=="outLeft"){
                self.continueAnimationStep()
            }else if(self.currentStep.act=="outRight"){
                self.continueAnimationStep()
            }
            
        }
        
        
    }
    
    
    func swapLabel(i: Int, j: Int){
        let temp = self.arrayLabel[i].center
        self.arrayLabel[i].center = self.arrayLabel[j].center
        self.arrayLabel[j].center = temp
        let _temp = self.arrayLabel[i]
        self.arrayLabel[i] = self.arrayLabel[j]
        self.arrayLabel[j] = _temp
        
    }
    
    
    func setPivot(traceLabel: UILabel,_setPivot: Int){
        let point = CGPoint(x: self.arrayLabelMiddle[self.currentStep.pivot+1].frame.origin.x+5, y: self.arrayLabelMiddle[self.currentStep.pivot+1].frame.origin.y - CGFloat(10) - RECTSIZE)
        tracePivot.frame.origin = CGPoint(x: point.x, y: point.y)
    }
    func setPosition(traceLabel: UILabel,_setPosition: Int){
        
        traceLabel.center = self.arrayLabelMark[_setPosition+1].center
        
    }
    
    func continueAnimation(){
        self.colSolution += 1
        
        if (self.colSolution == self.arrayAction.count) {
            removeSuperTrace()
            return
        }
        self.currentStep = self.arrayAction[self.colSolution]
        self.animation()
    }
    
    func continueAnimationStep(){
        self.colSolution += 1
        
        if (self.colSolution == self.arrayAction.count) {
            btnStepTmp.isUserInteractionEnabled = true
            removeSuperTrace()
            return
            
        }else{
            btnStepTmp.isUserInteractionEnabled = true
            
        }
        self.currentStep = self.arrayAction[self.colSolution]
    }
    
    func removeSuperTrace(){
        let label = self.arrayLabel[self.arrayAction[self.colSolution-1].pivot]
        label.alpha = DEFAULT_ALPHA
        self.traceLeft.isHidden = true
        self.traceRight.isHidden = true
        self.tracePivot.isHidden = true
        self._layer.removeFromSuperlayer()
    }
    
    
    func loop(){
        currentStep = self.arrayAction[self.colSolution]
        animation()
        
    }
    
    func next(){
        currentStep = self.arrayAction[self.colSolution]
        animationStep()
        
    }
    
}
