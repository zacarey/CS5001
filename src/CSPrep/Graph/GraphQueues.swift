//
//  GraphQueues.swift
//  Algorithms
//
//  Created by Loc Tran on 5/6/17.
//  Copyright © 2017 LocTran. All rights reserved.
//


import UIKit

class GraphQueues: UIView {
    
    var arrayLabel: [SortingLabel]!
    let lineStart = CAShapeLayer()
    let linePathStart = UIBezierPath()
    let line = CAShapeLayer()
    let linePath = UIBezierPath()
    var spacing : CGFloat!
    var label1: UILabel!
    var label2: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(".....")
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.arrayLabel = [SortingLabel]()
        self.spacing = frame.width/21
        y_Queues = frame.height/5
        drawFrameStart()
        drawFrame()
        drawLabel()
        drawObject()
        drawPosObject()
        posRearFront()
        line.isHidden = true
    }
    
    func drawFrameStart(){
        linePathStart.move(to: CGPoint(x: frame.width/3, y: frame.height*4/5))
        linePathStart.addLine(to: CGPoint(x: frame.width/3, y: frame.height/5))
        linePathStart.move(to: CGPoint(x: frame.width*2/3, y: frame.height*4/5))
        linePathStart.addLine(to: CGPoint(x: frame.width*2/3, y: frame.height/5))
        lineStart.path = linePathStart.cgPath
        lineStart.lineWidth = 6
        lineStart.strokeColor = UIColor.black.cgColor
        self.layer.addSublayer(lineStart)
    }
    
    func drawFrame(){
        linePath.move(to: CGPoint(x: spacing*2, y: frame.height*2/5))
        linePath.addLine(to: CGPoint(x: frame.width-2*spacing, y: frame.height*2/5))
        linePath.move(to: CGPoint(x: spacing*2, y: frame.height*4/5))
        linePath.addLine(to: CGPoint(x: frame.width-2*spacing, y: frame.height*4/5))
        line.path = linePath.cgPath
        line.lineWidth = 6
        line.strokeColor = UIColor.black.cgColor
        self.layer.addSublayer(line)
    }
    
    func drawLabel(){
        let labelColors: [UIColor] = [UIColor.green, UIColor.blue]
        let labelText: [String] = ["Green", "Blue"]
        
        label1 = SortingLabel(frame: CGRect(x: frame.width/3 + CGFloat(8), y: frame.height*7/10  - CGFloat(12) , width: frame.width/3 - CGFloat(16), height: frame.height/10))
        label1.layer.masksToBounds = true
        label1.layer.cornerRadius = 10
        label1.backgroundColor = labelColors[0]
        label1.text = labelText[0]
        label1.textColor = UIColor.black
        arrayLabel.append(label1 as! SortingLabel)
        self.addSubview(label1)
        
        label2 = SortingLabel(frame: CGRect(x: frame.width/3 + CGFloat(8), y: frame.height*7/10 - (frame.height/10) - CGFloat(12)*CGFloat(2) + CGFloat(4), width: frame.width/3 - CGFloat(16), height: frame.height/10))
        label2.layer.masksToBounds = true
        label2.layer.cornerRadius = 10
        label2.backgroundColor = labelColors[1]
        label2.text = labelText[1]
        label2.textColor = UIColor.black
        arrayLabel.append(label2 as! SortingLabel)
        self.addSubview(label2)
        
        
        //1
        
    }
    
    func drawObject(){
        let labelColor : [String] = ["carBlue", "carRed", "motor", "truck"]
        
        for i in 0...3{
            let label = SortingLabel(frame: CGRect(x: -200, y: frame.height*5/10 , width: 3*spacing , height: frame.height/5))
            let attachment = NSTextAttachment()
            attachment.image = UIImage(named: labelColor[i])!
            attachment.bounds = CGRect(x: 0, y: 0, width: frame.width*3/21, height: frame.height/5)
            let attachmentString = NSAttributedString(attachment: attachment)
            
            label.attributedText = attachmentString
            label.textAlignment = .center
            arrayLabel.append(label)
            self.addSubview(label)
            
        }
        // 5
    }
    
    func drawPosObject(){
        
        for i in 0...3{
            let label = SortingLabel(frame: CGRect(x: frame.width - (6*spacing + 4*spacing*CGFloat(i)), y: frame.height*5/10 , width: 3*spacing , height: frame.height/5))
            arrayLabel.append(label)
            self.addSubview(label)
        }
        // 9
        
        let labelOut = SortingLabel(frame: CGRect(x: frame.width + 100, y: frame.height*5/10 , width: 3*spacing , height: frame.height/5))
        arrayLabel.append(labelOut)
        self.addSubview(labelOut)
        // 10

    }
    
    func posRearFront(){
        for i in 0...3{
        let label = SortingLabel(frame: CGRect(x: frame.width - 6*spacing - 4*spacing*CGFloat(i), y: frame.height*9/10 , width: 3*spacing , height: frame.height/10))
            arrayLabel.append(label)
            self.addSubview(label)
    }
        // 14
    }
    
}
