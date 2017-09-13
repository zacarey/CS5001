//
//  Graph_Tower.swift
//  Algorithms
//
//  Created by TTung on 5/3/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
import UIKit

class Graph_Tower: UIView {
    var spacing : CGFloat!
    var bearingPoint: CGPoint!
    var rectSize: CGFloat!
    var arrayLabel: [SortingLabel]!
    var bearingCenterPoint: [CGPoint]!
    var nameTower: [String] = ["A","B","C"]
    var breakLabel: SortingLabel!
    required init?(coder aDecoder: NSCoder) {
        fatalError(".....")
    }
    
        override init(frame: CGRect) {
        super.init(frame: frame)
             spacing = self.frame.width/16
             bearingPoint = CGPoint(x: spacing, y: self.frame.height*4/5)
             rectSize = spacing*4
            bearingCenterPoint = [CGPoint]()
            self.arrayLabel = [SortingLabel]()

            draw_Tower()
            drawPlate()
    }
   
         func draw_Tower(){
                let line = CAShapeLayer()
        let linePath = UIBezierPath()
        var a = 3
        
            for i in 1...3 {
                linePath.move(to: CGPoint(x: bearingPoint.x*CGFloat(i) + rectSize*CGFloat(i-1), y: bearingPoint.y))
                linePath.addLine(to: CGPoint(x: bearingPoint.x*CGFloat(i) + rectSize*CGFloat(i), y: bearingPoint.y))
                linePath.move(to: CGPoint(x: bearingPoint.x*CGFloat(a), y: bearingPoint.y))
                linePath.addLine(to: CGPoint(x: bearingPoint.x*CGFloat(a), y: bearingPoint.y*3/5))
                yEnd_Tower = bearingPoint.y*3/5
                bearingCenterPoint.append(CGPoint(x: bearingPoint.x*CGFloat(a), y: bearingPoint.y - (frame.height/20)))
                let name_Tower = SortingLabel(frame: CGRect(x: bearingPoint.x*CGFloat(i) + rectSize*CGFloat(i-1), y: bearingPoint.y, width: rectSize, height: self.frame.height/10))
                name_Tower.text = nameTower[i-1]
                
                a = a + 5
                self.addSubview(name_Tower)
            }
            line.path = linePath.cgPath
            line.lineWidth = 4
            line.strokeColor = UIColor.black.cgColor
            self.layer.addSublayer(line)
    }
    
    func drawPlate(){
        
        let colors: [UIColor] = [UIColor.blue, UIColor.orange, UIColor.green]
        for i in 0...2{
            let label = SortingLabel(frame: CGRect(x: spacing*1 + (spacing*0.5*CGFloat(i+1) - spacing*0.25), y: frame.height*CGFloat(7-i)/10, width: spacing*CGFloat(3-i) + spacing*0.5, height: frame.height/10))
            label.layer.masksToBounds = true

            label.backgroundColor = colors[i]
            label.text = String(3-i)
            label.textColor = UIColor.white
            label.layer.cornerRadius = 10
            arrayLabel.append(label)
            self.addSubview(label)
// 0,1,2
        }

        breakLabel = SortingLabel(frame:CGRect(x: 0, y: 0, width: spacing*CGFloat(1) + spacing*0.5, height: frame.height/10))
        breakLabel.layer.masksToBounds = true
        breakLabel.layer.cornerRadius = 10
        Spacing_Center = frame.height/10
        breakLabel.center = CGPoint(x: self.bearingCenterPoint[1].x, y: self.bearingCenterPoint[1].y)
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "bolt")
        attachment.bounds = CGRect(x: 0, y: 0, width: frame.width/10, height: frame.height/10)
        let attachmentString = NSAttributedString(attachment: attachment)
        breakLabel.backgroundColor = UIColor.green
        breakLabel.attributedText = attachmentString
        breakLabel.textAlignment = .center
        breakLabel.isHidden = true
        self.addSubview(breakLabel)
        arrayLabel.reverse()
        
    }
    
    func resetGraph(){
        breakLabel.isHidden = true
        arrayLabel[0].isHidden = false
        arrayLabel.reverse()

        for i in 0...2{
            self.arrayLabel[i].frame.origin = CGPoint(x: spacing*1 + (spacing*0.5*CGFloat(i+1) - spacing*0.25), y: frame.height*CGFloat(7-i)/10)
            self.arrayLabel[i].text = String(3-i)
        }
        arrayLabel.reverse()

    }
    
}
