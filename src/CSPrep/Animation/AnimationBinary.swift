//
//  AnimationBinary.swift
//  Algorithms
//
//  Created by Loc Tran on 5/11/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
import UIKit


public class AnimarionBinary {
    
    var arrayLabel: [SortingLabel]!
    var binary: BinarySearch!
    var arraySort: [Int]!
    var countSolution = 0
    var graph: GraphLinearBinary!
    var currentStep = BinaryStep()
    var arrayAction = [BinaryStep]()
    
    init(arrayLabel: [SortingLabel], graph: GraphLinearBinary, arraySort: [Int], arrayAction: [BinaryStep]) {
        self.arrayLabel = arrayLabel
        self.arraySort = arraySort
        self.graph = graph
        self.arrayAction = arrayAction
        
        
    }
    
    
    func animation(){
        
        if self.currentStep.act != "Start" && self.currentStep.act != "NotFound"{
            self.arrayLabel[self.currentStep.midIndex].layer.backgroundColor = UIColor.red.cgColor
        }
        
        UIView.setAnimationsEnabled(true)
        UIView.animate(withDuration: 2, animations: {
            if self.currentStep.act == "Start"{
                for i in 0..<36 {
                    self.arrayLabel[i].layer.backgroundColor = LIME_COLOR.cgColor
                    self.arrayLabel[i].text = String(self.arraySort[i])
                }
            }
            else if  self.currentStep.act == "DivideSmall"{
                for i in self.currentStep.midIndex..<36{
                    self.arrayLabel[i].layer.backgroundColor = UIColor.lightGray.cgColor
                    self.arrayLabel[self.currentStep.midIndex].layer.backgroundColor = UIColor.red.cgColor
                }
            }
            else if  self.currentStep.act == "DivideBig"{
                for i in 0..<self.currentStep.midIndex{
                    self.arrayLabel[i].layer.backgroundColor = UIColor.lightGray.cgColor
                    self.arrayLabel[self.currentStep.midIndex].layer.backgroundColor = UIColor.red.cgColor
                }
            }
            else if  self.currentStep.act == "Done" || self.currentStep.act == "NotFound"{
                for i in 0..<36 {
                    self.arrayLabel[i].layer.backgroundColor = UIColor.lightGray.cgColor
                }
            }
            
            
        }) {_ in
            if self.currentStep.act == "DivideSmall" || self.currentStep.act == "DivideBig"{
                self.arrayLabel[self.currentStep.midIndex].layer.backgroundColor = UIColor.lightGray.cgColor
            }
                
            else if self.currentStep.act == "Done" {
                self.arrayLabel[self.currentStep.midIndex].layer.backgroundColor = LIME_COLOR.cgColor
                
                return
            }
            else if  self.currentStep.act == "NotFound"{
                return
            }
            
            
            self.countSolution += 1
            self.currentStep = self.arrayAction[self.countSolution]
            self.animation()
            
        }
    }
    
    func animationStep(){
        
        if self.currentStep.act != "Start" && self.currentStep.act != "NotFound"{
            self.arrayLabel[self.currentStep.midIndex].layer.backgroundColor = UIColor.red.cgColor
        }
        
        UIView.setAnimationsEnabled(true)
        UIView.animate(withDuration: 2, animations: {
            if self.currentStep.act == "Start"{
                for i in 0..<36 {
                    self.arrayLabel[i].layer.backgroundColor = LIME_COLOR.cgColor
                    self.arrayLabel[i].text = String(self.arraySort[i])
                }
            }
            else if  self.currentStep.act == "DivideSmall"{
                for i in self.currentStep.midIndex..<36{
                    self.arrayLabel[i].layer.backgroundColor = UIColor.lightGray.cgColor
                    self.arrayLabel[self.currentStep.midIndex].layer.backgroundColor = UIColor.red.cgColor
                }
            }
            else if  self.currentStep.act == "DivideBig"{
                for i in 0..<self.currentStep.midIndex{
                    self.arrayLabel[i].layer.backgroundColor = UIColor.lightGray.cgColor
                    self.arrayLabel[self.currentStep.midIndex].layer.backgroundColor = UIColor.red.cgColor
                }
            }
            else if  self.currentStep.act == "Done" || self.currentStep.act == "NotFound"{
                for i in 0..<36 {
                    self.arrayLabel[i].layer.backgroundColor = UIColor.lightGray.cgColor
                }
            }
            
            
        }) {_ in
            if self.currentStep.act == "DivideSmall" || self.currentStep.act == "DivideBig"{
                self.arrayLabel[self.currentStep.midIndex].layer.backgroundColor = UIColor.lightGray.cgColor
            }
                
            else if self.currentStep.act == "Done" {
                self.arrayLabel[self.currentStep.midIndex].layer.backgroundColor = LIME_COLOR.cgColor
                
                return
            }
            else if  self.currentStep.act == "NotFound"{
                return
            }
            
            btnStepTmp.isUserInteractionEnabled = true
            self.countSolution += 1
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
