//
//  AnimationStacks.swift
//  Algorithms
//
//  Created by Loc Tran on 5/5/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
import UIKit

class AnimationStacks {
    
    var arrayCenter: [CGPoint]!
    var arrLabel: [SortingLabel]!
    var colSolution = 0
    var graph: GraphStacks!
    
    init(arrayLabel: [SortingLabel],  graph: GraphStacks) {
        
        self.arrLabel = arrayLabel
//        self.arrayCenter = arrayCenter
        self.graph = graph
    }
    
    func animation(){
        UIView.setAnimationsEnabled(true)
        UIView.animate(withDuration: 1, animations: {
            if self.colSolution == 0{
            labelPushTmp.isHidden = false
            self.moveLabel(from: self.arrLabel[5], to: self.arrLabel[8])
            }
            else if self.colSolution == 1{
               
                labelPushTmp.isHidden = true
                labelPopTmp.isHidden = false
                self.moveLabel(from: self.arrLabel[5], to: self.arrLabel[8])
                
            }
            else if self.colSolution == 2 {
                self.moveLabel(from: self.arrLabel[3], to: self.arrLabel[8])
            }
            else if self.colSolution == 3{
                self.moveLabel(from: self.arrLabel[2], to: self.arrLabel[8])
            }
            else if self.colSolution == 4 {
                labelPushTmp.isHidden = false
                labelPopTmp.isHidden = true
                self.moveLabel(from: self.arrLabel[6], to: self.arrLabel[8])
            }
            else if self.colSolution == 5{
                self.moveLabel(from: self.arrLabel[7], to: self.arrLabel[8])

            }
            else if self.colSolution == 6 {
                labelTopTmp.isHidden = true
            }
        }) {_ in
            UIView.setAnimationsEnabled(true)
            UIView.animate(withDuration: 1, animations: {
                if self.colSolution == 0{
                self.moveLabel(from: self.arrLabel[5], to: self.arrLabel[4])
                self.moveLabel(from: labelTopTmp as! SortingLabel , to: self.arrLabel[10])
                }
                
                else if self.colSolution == 1{
                    self.moveLabel(from: self.arrLabel[5], to: self.arrLabel[9])
                     self.moveLabel(from: labelTopTmp as! SortingLabel , to: self.arrLabel[11])
                }
                
                else if self.colSolution == 2{
                    self.moveLabel(from: self.arrLabel[3], to: self.arrLabel[9])
                    self.moveLabel(from: labelTopTmp as! SortingLabel, to: self.arrLabel[12])
                }
                    
                else if self.colSolution == 3{
                    self.moveLabel(from: self.arrLabel[2], to: self.arrLabel[9])
                    self.moveLabel(from: labelTopTmp as! SortingLabel, to: self.arrLabel[13])
                }
                else if self.colSolution == 4 {
                    self.moveLabel(from: self.arrLabel[6], to: self.arrLabel[14])
                    self.moveLabel(from: labelTopTmp as! SortingLabel, to: self.arrLabel[12])
                }
                else if self.colSolution == 5{
                    self.moveLabel(from: self.arrLabel[7], to: self.arrLabel[15])
                    self.moveLabel(from: labelTopTmp as! SortingLabel, to: self.arrLabel[11])
                    labelPushTmp.isHidden = true
                }
                self.colSolution = self.colSolution + 1
                btnStepBigTmp.isUserInteractionEnabled = true
            })
        }
    }
    
    func moveLabel(from: SortingLabel, to: SortingLabel) {
        from.center = to.center
    }
    func loop(){
        animation()
        
    }
}
