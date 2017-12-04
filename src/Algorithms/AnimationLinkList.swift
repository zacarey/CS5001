//
//  AnimationLinkList.swift
//  Algorithms
//
//  Created by Loc Tran on 5/6/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
class AnimationLinkList{
    var colSolution = 0
    var graph: Graph_LinkList!

    init(graph: Graph_LinkList){
        self.graph = graph
        
    }
    func animationStep(step: Int){
        UIView.animate(withDuration: 0.5, animations: {
            if(step==1){
                self.graph.arrow1.isHidden = false
                self.graph.labelValue.isHidden = false
                self.graph.arrNodes[1].layer.borderColor = UIColor.red.cgColor
            }else if(step==2){
                self.graph.arrow2.isHidden = false
                self.graph.labelNext.isHidden = false
                self.graph.arrNodes[1].layer.borderColor = UIColor.red.cgColor

            }else if(step==3){
                self.graph.arrow1.isHidden = true
                self.graph.labelValue.isHidden = true
                self.graph.arrow2.isHidden = true
                self.graph.labelNext.isHidden = true
                self.graph.arrDots[0].isHidden = true
                self.graph.arrArrows[0].isHidden = true
                self.graph.addLable.isHidden = false
                self.graph.arrNodes[1].layer.borderColor = UIColor.gray.cgColor
                self.graph.printNameNode()
            }else if(step==4){
                self.graph.arrowDown.isHidden = false
                self.graph.dotDown.isHidden = false
                let label = self.graph.arrNodes[0].viewWithTag(12) as! UILabel
                label.text = "0x35"
                
            }else if(step==5){
                self.graph.arrDots[3].isHidden = false
                self.graph.arrowCurved[0].isHidden = false
                self.graph.arrowCurved[1].isHidden = false
                let label = self.graph.addLable.viewWithTag(42) as! UILabel
                label.text = "0x15"

            
            }
        }){_ in
            btnStepTmp.isUserInteractionEnabled = true
        }
        
    }
}
