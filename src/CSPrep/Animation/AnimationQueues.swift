//
//  AnimationQueues.swift
//  Algorithms
//
//  Created by Loc Tran on 5/6/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
import UIKit

class AnimationQueues {
    
    var arrLabel: [SortingLabel]!
    var colSolution = 0
    var graph: GraphQueues!
    
    init(arrayLabel: [SortingLabel], graph: GraphQueues) {
        self.arrLabel = arrayLabel
        self.graph  = graph
    }
    
    func animation(){
        UIView.setAnimationsEnabled(true)
        UIView.animate(withDuration: 1, animations: {
            if self.colSolution == 0 {
                self.graph.lineStart.isHidden = true
                self.graph.label1.isHidden = true
                self.graph.label2.isHidden = true
            }
            else if self.colSolution == 1{
                labelEnqueuesTmp.isHidden = false
                self.moveLabel(from: self.arrLabel[2], to: self.arrLabel[6])
                
            }
            else if self.colSolution == 2{
                self.moveLabel(from: self.arrLabel[3], to: self.arrLabel[7])
                
            }
            else if self.colSolution == 3{
                self.moveLabel(from: self.arrLabel[4], to: self.arrLabel[8])
                
            }
            else if self.colSolution == 4{
                self.moveLabel(from: self.arrLabel[5], to: self.arrLabel[9])
            }
            else if self.colSolution == 5 {
                labelEnqueuesTmp.isHidden = true
                labelDequeuesTmp.isHidden = false
                self.moveLabel(from: self.arrLabel[2], to: self.arrLabel[10])
                self.moveLabel(from: self.arrLabel[3], to: self.arrLabel[6])
                self.moveLabel(from: self.arrLabel[4], to: self.arrLabel[7])
                self.moveLabel(from: self.arrLabel[5], to: self.arrLabel[8])
            }
            else if self.colSolution == 6 {
                
                self.moveLabel(from: self.arrLabel[3], to: self.arrLabel[10])
                self.moveLabel(from: self.arrLabel[4], to: self.arrLabel[6])
                self.moveLabel(from: self.arrLabel[5], to: self.arrLabel[7])
            }
            else if self.colSolution == 7 {
                
                self.moveLabel(from: self.arrLabel[4], to: self.arrLabel[10])
                self.moveLabel(from: self.arrLabel[5], to: self.arrLabel[6])
            }
            else if self.colSolution == 8 {
                labelFrontTmp.isHidden = true
            }
        }) {_ in
            if self.colSolution == 0{
                self.graph.line.isHidden = false
            }
            else if self.colSolution == 1{
                self.moveLabel(from: labelFrontTmp, to: self.arrLabel[11])
                self.moveLabel(from: labelRearTmp, to: self.arrLabel[12])
            }
            else if self.colSolution == 2{
                labelRearTmp.isHidden = false
                labelFrontTmp.isHidden = false
            }
            else if self.colSolution == 3{
                self.moveLabel(from: labelRearTmp, to: self.arrLabel[13])
                
            }
            else if self.colSolution == 4{
                self.moveLabel(from: labelRearTmp, to: self.arrLabel[14])
                
            }
            else if self.colSolution == 5{
                self.moveLabel(from: labelRearTmp, to: self.arrLabel[13])
            }
            else if self.colSolution == 6{
                self.moveLabel(from: labelRearTmp, to: self.arrLabel[12])
            }
            else if self.colSolution == 7{
                labelRearTmp.isHidden = true
            }
            else if self.colSolution == 8{
                labelDequeuesTmp.isHidden = true
            }
            
            self.colSolution = self.colSolution + 1
            btnStepBigTmp.isUserInteractionEnabled = true
            
        }
    }
    func moveLabel(from: SortingLabel, to: SortingLabel) {
        from.center = to.center
    }
    
    func loop(){
        animation()
        
    }
}
