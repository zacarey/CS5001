//
//  GraphStacks.swift
//  Algorithms
//
//  Created by Loc Tran on 5/4/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import UIKit

class GraphStacks: UIView {
    
    var arrayLabel: [SortingLabel]!
    var bearingcenterPoint: [CGPoint]!
    var labelObject: SortingLabel!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(".....")
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.arrayLabel = [SortingLabel]()
        self.bearingcenterPoint = [CGPoint]()
        
        xEndMove_Stacks = frame.width/3 + CGFloat(8)
        yEndMove_Stacks = frame.height/10
        
        
        drawLineThroughPoint(start: CGPoint(x: frame.width/3, y: frame.height*2/5-CGFloat(8)),
                             throughPoint: [CGPoint(x: frame.width/3, y: frame.height-CGFloat(8)),
                                            CGPoint(x: frame.width*2/3, y: frame.height-CGFloat(8))],
                             endPoint: CGPoint(x: frame.width*2/3, y: frame.height*2/5-CGFloat(8)),
                             ofColor: UIColor.black)
        
        drawLabel()
        
    }
    
    func drawLineThroughPoint(start : CGPoint, throughPoint through: [CGPoint], endPoint end:CGPoint, ofColor lineColor: UIColor) {
        
        //design the path
        let path = UIBezierPath()
        path.move(to: start)
        for (_, point) in through.enumerated() {
            path.addLine(to: point)
            path.move(to: point)
        }
        path.addLine(to: end)
        
        //design path in layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineCap = kCALineCapRound
        
        shapeLayer.lineWidth = 6.0
        
        self.layer.addSublayer(shapeLayer)
    }
    
    
    func drawLabel(){
        var labelColor: [UIColor] = [UIColor.green, UIColor.blue, UIColor.red, UIColor.brown, UIColor.purple, UIColor.orange]
        let labelText: [String] = ["Green", "Blue", "Red", "Brown", "Purple", "Orange"]
        
        for i in 0...4{
            labelObject = SortingLabel(frame: CGRect(x: frame.width/3 + CGFloat(8), y: frame.height*9/10 - (frame.height/10)*CGFloat(i) - CGFloat(12)*CGFloat(i+1) + CGFloat(4)*CGFloat(i), width: frame.width/3 - CGFloat(16), height: frame.height/10))
            labelObject.layer.masksToBounds = true
            labelObject.layer.cornerRadius = 10
            labelObject.backgroundColor = labelColor[i]
            labelObject.text = labelText[i]
            labelObject.textColor = UIColor.white
            arrayLabel.append(labelObject)
            self.addSubview(labelObject)
            // 4
        }
        
        labelObject.isHidden = true
        
        for i in (3...5).reversed(){
            let label = SortingLabel(frame: CGRect(x: -200, y: 0, width: frame.width/3 - CGFloat(16), height: frame.height/10))
            label.textColor = UIColor.black
            label.layer.masksToBounds = true
            label.layer.cornerRadius = 10
            label.backgroundColor = labelColor[i]
            label.textColor = UIColor.white
            label.text = labelText[i]
            arrayLabel.append(label)
            self.addSubview(label)
            
            // 7
        }
        let labelMedial = SortingLabel(frame: CGRect(x: frame.width/3 + CGFloat(8), y: 0, width: frame.width/3 - CGFloat(16), height: frame.height/10))
        arrayLabel.append(labelMedial)
        self.addSubview(labelMedial)
        
        // 8
        
        let labelOut = SortingLabel(frame: CGRect(x: frame.width + CGFloat(20), y: 0, width: frame.width/3 - CGFloat(16), height: frame.height/10))
        arrayLabel.append(labelOut)
        self.addSubview(labelOut)
        
        // 9
        
        for i in 0...3 {
            let labelTop = SortingLabel(frame: CGRect(x:frame.width/10, y: yEndMove_Stacks*CGFloat(6+i)+CGFloat(12), width: 70, height: 30))
            arrayLabel.append(labelTop)
            self.addSubview(labelTop)
            
            // 13
        }
        
        let labelMedialThird = SortingLabel(frame: CGRect(x: frame.width/3 + CGFloat(8), y: frame.height*9/10 - (frame.height/10)*CGFloat(2) - CGFloat(12)*CGFloat(3) + CGFloat(4)*CGFloat(2), width: frame.width/3 - CGFloat(16), height: frame.height/10))
        arrayLabel.append(labelMedialThird)
        self.addSubview(labelMedialThird)
        
        let labelMadiaFourth = SortingLabel(frame: CGRect(x: frame.width/3 + CGFloat(8), y: frame.height*9/10 - (frame.height/10)*CGFloat(3) - CGFloat(12)*CGFloat(4) + CGFloat(4)*CGFloat(3), width: frame.width/3 - CGFloat(16), height: frame.height/10))
        arrayLabel.append(labelMadiaFourth)
        self.addSubview(labelMadiaFourth)
        
    }
    
    
}
