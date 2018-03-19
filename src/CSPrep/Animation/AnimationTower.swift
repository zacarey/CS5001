//
//  AnimationTower.swift
//  Algorithms
//
//  Created by Loc Tran on 5/3/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
import UIKit

enum Tower: Int{
    case A = 1
    case B = 2
    case C = 3
}

class AnimationTower {
    
    var arrayAction: [TowerStep]!
    var arrayCenter: [CGPoint]!
    var arrayLabel: [SortingLabel]!
    var colSolution = 0
    var currentStep = TowerStep()
    var countA = 3
    var countB = 0
    var countC = 0
    var graph: Graph_Tower!
    
    
    
    init(arrayLabel:[SortingLabel] , arrayCenter: [CGPoint],  arrayAction: [TowerStep],graph: Graph_Tower){
        
        self.arrayAction = arrayAction
        self.arrayLabel = arrayLabel
        self.arrayCenter = arrayCenter
        self.graph = graph
        
    }
    
    func animationFirst(step: Int){
        self.graph.resetGraph()
        if(step==5){
            self.arrayLabel[0].center = CGPoint(x: self.arrayCenter[1].x, y: self.arrayCenter[1].y)
        }
        
        UIView.setAnimationsEnabled(true)
        UIView.animate(withDuration: 0.5, animations: {
            if(step==1){
                // di chuyen tu A->B
                self.moveUp(lable: self.arrayLabel[0],valueTower: 0)
                
            }else if(step==2){
                self.arrayLabel[0].center = CGPoint(x: self.arrayCenter[0].x, y: yEnd_Tower-CGFloat(1.5)*Spacing_Center)
                self.arrayLabel[1].center = CGPoint(x: self.arrayCenter[0].x, y: yEnd_Tower-CGFloat(0.5)*Spacing_Center)
                
            }else if (step == 4){
                self.moveUp(lable: self.arrayLabel[0], valueTower: 0)
                
            }
            
        }){_ in
            if(step==1){
                UIView.animate(withDuration: 0.5, animations: {
                    self.moveCross(lable: self.arrayLabel[0],valueTower: 1)
                }){_ in
                    UIView.animate(withDuration: 0.5, animations: {
                        self.moveDown(lable: self.arrayLabel[0], valueTower: 1, count: self.countB)
                    }){ _ in
                        btnStepTmp.isUserInteractionEnabled = true
                        
                        
                    }
                }
            }else if(step==2){
                UIView.animate(withDuration: 0.5, animations: {
                    self.arrayLabel[0].center.x = self.arrayCenter[1].x
                    self.arrayLabel[1].center.x = self.arrayCenter[1].x
                    
                }){_ in
                    UIView.animate(withDuration: 0.5, animations: {
                        self.moveDown(lable: self.arrayLabel[0], valueTower: 1, count: 1)
                        self.moveDown(lable: self.arrayLabel[1], valueTower: 1, count: 0)
                    }){ _ in
                        
                        let img = UIImage(named: "nhan_32")
                        let imgView = UIImageView(image: img)
                        
                        imgView.frame = CGRect(x: 0, y: 0, width: self.graph.spacing, height: self.graph.frame.height/20)
                        
                        self.arrayLabel[0].text = "\u{f00d}"
                        self.arrayLabel[0].font = UIFont.fontAwesome(ofSize: 12)
                        self.arrayLabel[1].text = "\u{f00d}"
                        self.arrayLabel[1].font = UIFont.fontAwesome(ofSize: 12)
                        btnStepTmp.isUserInteractionEnabled = true
                        
                        
                    }
                }
                
            }
            else if(step == 4){
                UIView.animate(withDuration: 0.5, animations: {
                    self.moveCross(lable: self.arrayLabel[0], valueTower: 1)
                }){_ in
                    UIView.animate(withDuration: 0.5, animations: {
                        self.moveDown(lable: self.arrayLabel[0], valueTower: 1, count: 0)
                    }){_ in
                        UIView.animate(withDuration: 0.5, animations: {
                            self.moveUp(lable: self.arrayLabel[1], valueTower: 0)
                        }){_ in
                            UIView.animate(withDuration: 0.5, animations: {
                                self.moveCross(lable: self.arrayLabel[1], valueTower: 1)
                            }){_ in
                                UIView.animate(withDuration: 0.5, animations: {
                                    self.moveDown(lable: self.arrayLabel[1], valueTower: 1, count: 1)
                                }){_ in
                                    self.arrayLabel[0].isHidden = true
                                    self.graph.breakLabel.isHidden = false
                                    btnStepTmp.isUserInteractionEnabled = true
                                }
                            }
                        }
                    }
                    
                }
            }
        }
    }
    
    
    func animation(){
        UIView.setAnimationsEnabled(true)
        UIView.animate(withDuration: 0.5, animations: {
            // di chuyen len tren
            if self.currentStep.from == "A"{
                self.moveUp(lable: self.arrayLabel[self.currentStep.disk-1],valueTower: 0)
                self.countA -= 1
            }else if self.currentStep.from == "B"{
                self.moveUp(lable: self.arrayLabel[self.currentStep.disk-1],valueTower: 1)
                self.countB -= 1
            }else{
                self.moveUp(lable: self.arrayLabel[self.currentStep.disk-1],valueTower: 2)
                self.countC -= 1
            }
            
            
        }){_ in
            UIView.animate(withDuration: 0.5, animations: {
                // di chuyen ngang
                if self.currentStep.to == "A"{
                    self.moveCross(lable: self.arrayLabel[self.currentStep.disk-1],valueTower:0)
                }else if self.currentStep.to == "B"{
                    self.moveCross(lable: self.arrayLabel[self.currentStep.disk-1],valueTower:1)
                }else{
                    self.moveCross(lable: self.arrayLabel[self.currentStep.disk-1],valueTower:2)
                }
                
            }){_ in
                UIView.animate(withDuration: 0.5, animations: {
                    if self.currentStep.to == "A"{
                        self.moveDown(lable: self.arrayLabel[self.currentStep.disk-1], valueTower: 0, count: self.countA)
                        self.countA += 1
                    }else if self.currentStep.to == "B"{
                        self.moveDown(lable: self.arrayLabel[self.currentStep.disk-1], valueTower: 1, count: self.countB)
                        self.countB += 1
                    }else{
                        self.moveDown(lable: self.arrayLabel[self.currentStep.disk-1], valueTower: 2, count: self.countC)
                        self.countC += 1
                    }
                    
                }){_ in
                    self.colSolution += 1
                    
                    if (self.colSolution == self.arrayAction.count) {
                        return
                    }
                    self.currentStep = self.arrayAction[self.colSolution]
                    self.animation()
                }
            }
        }
        
    }
    
    func animationStep(){
        UIView.setAnimationsEnabled(true)
        UIView.animate(withDuration: 0.5, animations: {
            // di chuyen len tren
            if self.currentStep.from == "A"{
                self.moveUp(lable: self.arrayLabel[self.currentStep.disk-1],valueTower: 0)
                self.countA -= 1
            }else if self.currentStep.from == "B"{
                self.moveUp(lable: self.arrayLabel[self.currentStep.disk-1],valueTower: 1)
                self.countB -= 1
            }else{
                self.moveUp(lable: self.arrayLabel[self.currentStep.disk-1],valueTower: 2)
                self.countC -= 1
            }
            
            
        }){_ in
            UIView.animate(withDuration: 0.5, animations: {
                // di chuyen ngang
                if self.currentStep.to == "A"{
                    self.moveCross(lable: self.arrayLabel[self.currentStep.disk-1],valueTower:0)
                }else if self.currentStep.to == "B"{
                    self.moveCross(lable: self.arrayLabel[self.currentStep.disk-1],valueTower:1)
                }else{
                    self.moveCross(lable: self.arrayLabel[self.currentStep.disk-1],valueTower:2)
                }
                
            }){_ in
                UIView.animate(withDuration: 0.5, animations: {
                    if self.currentStep.to == "A"{
                        self.moveDown(lable: self.arrayLabel[self.currentStep.disk-1], valueTower: 0, count: self.countA)
                        self.countA += 1
                    }else if self.currentStep.to == "B"{
                        self.moveDown(lable: self.arrayLabel[self.currentStep.disk-1], valueTower: 1, count: self.countB)
                        self.countB += 1
                    }else{
                        self.moveDown(lable: self.arrayLabel[self.currentStep.disk-1], valueTower: 2, count: self.countC)
                        self.countC += 1
                    }
                    
                }){_ in
                    self.colSolution += 1
                    btnStepTmp.isUserInteractionEnabled = true
                    
                }
            }
        }
        
    }
    func moveCross(lable: SortingLabel,valueTower: Int){
        lable.center = CGPoint(x: self.arrayCenter[valueTower].x, y: yEnd_Tower-Spacing_Center/2)
    }
    
    func moveUp(lable: SortingLabel,valueTower: Int){
        
        lable.center = CGPoint(x: self.arrayCenter[valueTower].x, y: yEnd_Tower-Spacing_Center/2)
    }
    func moveDown(lable: SortingLabel,valueTower: Int,count: Int){
        lable.center = CGPoint(x: self.arrayCenter[valueTower].x, y: self.arrayCenter[valueTower].y-CGFloat(count)*Spacing_Center)
        
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
