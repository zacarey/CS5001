//
//  GraphBreadthDepth.swift
//  Algorithms
//
//  Created by Loc Tran on 5/15/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import UIKit

class GraphBreadthDepth: UIView {
    
    var arrayLabel: [SortingLabel]!
    var arrayArrow: [CAShapeLayer]!
    var spacing: CGFloat!
    var rectSize: CGFloat!
    override init(frame: CGRect){
        super.init(frame: frame)
        arrayLabel = [SortingLabel]()
        arrayArrow = [CAShapeLayer]()
        spacing = frame.width/10
        rectSize = spacing*2
        
        drawBoard()
        drawArrow()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawBoard(){
        
        let labelMiner = SortingLabel(frame: CGRect(x: 2*spacing + rectSize, y: 0, width: rectSize, height: rectSize/2))
        let attachmentMiner = NSTextAttachment()
        attachmentMiner.image = UIImage(named: "knight")
        attachmentMiner.bounds = CGRect(x: 0, y: 0, width: rectSize, height: rectSize/2)
        let attachmentMinerString = NSAttributedString(attachment: attachmentMiner)
        labelMiner.attributedText = attachmentMinerString
        labelMiner.textAlignment = .center
        labelMiner.layer.masksToBounds = true
        labelMiner.layer.cornerRadius = rectSize/4
        labelMiner.clipsToBounds = true
        labelMiner.layer.borderWidth = 2
        labelMiner.layer.borderColor = UIColor.black.cgColor
        arrayLabel.append(labelMiner)
        self.addSubview(labelMiner)
        
        
        //0 
        
        for i in 1...3{
            
            let label = SortingLabel(frame: CGRect(x: 2*spacing + rectSize, y: frame.height/5*CGFloat(i), width: rectSize, height: rectSize/2))
            
            let attachment = NSTextAttachment()
            attachment.image = UIImage(named: "monster2")
            attachment.bounds = CGRect(x: 0, y: 0, width: rectSize, height: rectSize/2)
            let attachmentString = NSAttributedString(attachment: attachment)
            label.attributedText = attachmentString
            label.textAlignment = .center
            label.layer.masksToBounds = true
            label.layer.cornerRadius = rectSize/4
            label.clipsToBounds = true
            label.layer.borderWidth = 2
            label.layer.borderColor = UIColor.black.cgColor
            arrayLabel.append(label)
            self.addSubview(label)
            
        }
        
        // 1,2,3
        for i in 0...1{
            let labelBG = SortingLabel(frame: CGRect(x: spacing, y: CGFloat(2+i)*frame.height/5, width: rectSize, height: rectSize/2))
            let attachmentChest = NSTextAttachment()
            attachmentChest.image = UIImage(named: "stop")
            attachmentChest.bounds = CGRect(x: 0, y: 0, width: rectSize, height: rectSize/2)
            let attachmentChestString = NSAttributedString(attachment: attachmentChest)
            labelBG.attributedText = attachmentChestString
            labelBG.textAlignment = .center
            labelBG.layer.masksToBounds = true
            labelBG.layer.cornerRadius = rectSize/4
            labelBG.clipsToBounds = true
            labelBG.layer.borderWidth = 2
            labelBG.layer.borderColor = UIColor.black.cgColor
            arrayLabel.append(labelBG)
            self.addSubview(labelBG)
        }
        
        //4,5
        
        let labelC = SortingLabel(frame: CGRect(x: frame.width-spacing-rectSize, y:frame.height*2/5, width: rectSize, height: rectSize/2))
        let attachmentC = NSTextAttachment()
        attachmentC.image = UIImage(named: "stop")
        attachmentC.bounds = CGRect(x: 0, y: 0, width: rectSize, height: rectSize/2)
        let attachmentCString = NSAttributedString(attachment: attachmentC)
        labelC.attributedText = attachmentCString
        labelC.textAlignment = .center
        labelC.layer.masksToBounds = true
        labelC.layer.cornerRadius = rectSize/4
        labelC.clipsToBounds = true
        labelC.layer.borderWidth = 2
        labelC.layer.borderColor = UIColor.black.cgColor
        arrayLabel.append(labelC)
        self.addSubview(labelC)
        
        //6
        
        let labelE = SortingLabel(frame: CGRect(x: 2*spacing+rectSize, y:frame.height*4/5, width: rectSize, height: rectSize/2))
        let attachmentChest = NSTextAttachment()
        attachmentChest.image = UIImage(named: "chest")
        attachmentChest.bounds = CGRect(x: 0, y: 0, width: rectSize, height: rectSize/2)
        let attachmentChestString = NSAttributedString(attachment: attachmentChest)
        labelE.attributedText = attachmentChestString
        labelE.textAlignment = .center
        labelE.layer.masksToBounds = true
        labelE.layer.cornerRadius = rectSize/4
        labelE.clipsToBounds = true
        labelE.layer.borderWidth = 2
        labelE.layer.borderColor = UIColor.black.cgColor
        arrayLabel.append(labelE)
        self.addSubview(labelE)
        
        //7
    }
    
    func drawArrow(){
        
        let arrowPath1 = UIBezierPath.bezierPathWithArrowFromPoint(startPoint: CGPoint(x: spacing*5, y: rectSize/2), endPoint: CGPoint(x: spacing*5, y: frame.height/5 - 5), tailWidth: 4, headWidth: 15, headLength: 6)
        let arrow1 = CAShapeLayer()
        
        arrow1.path = arrowPath1.cgPath
        self.layer.addSublayer(arrow1)
        arrayArrow.append(arrow1)
        // 0
        
        for i in 1...3{
            let arrowPath = UIBezierPath.bezierPathWithArrowFromPoint(startPoint: CGPoint(x: spacing*5, y: CGFloat(i)*frame.height/5 + rectSize/2 + 2), endPoint: CGPoint(x: spacing*5, y: CGFloat(i+1)*frame.height/5), tailWidth: 4, headWidth: 15, headLength: 6)
            let arrow = CAShapeLayer()
            
            arrow.path = arrowPath.cgPath
            self.layer.addSublayer(arrow)
            arrayArrow.append(arrow)
        }
        
        // 1,2,3
        
        for i in 1..<3{
            let arrowPath = UIBezierPath.bezierPathWithArrowFromPoint(startPoint: CGPoint(x: 4*spacing, y: CGFloat(i)*frame.height/5 + rectSize/2 + 2), endPoint: CGPoint(x: 3*spacing, y: CGFloat(i+1)*frame.height/5), tailWidth: 4, headWidth: 15, headLength: 6)
            let arrow = CAShapeLayer()
            
            arrow.path = arrowPath.cgPath
            self.layer.addSublayer(arrow)
            arrayArrow.append(arrow)
        }
        // 4,5
        
        let arrowPathC = UIBezierPath.bezierPathWithArrowFromPoint(startPoint: CGPoint(x: 6*spacing, y: frame.height/5 + rectSize/2 + 2), endPoint: CGPoint(x: 7*spacing, y: frame.height*2/5), tailWidth: 4, headWidth: 15, headLength: 6)
        let arrowC = CAShapeLayer()
        
        arrowC.path = arrowPathC.cgPath
        self.layer.addSublayer(arrowC)
        arrayArrow.append(arrowC)
        
        //6
    }
    
    func arrowCorresponding(value: Int) -> Int{
        
        if value == 1{
            return 0
        }
        else if value == 2{
            return 1
        }
        else if value == 3{
            return 2
        }
        else if value == 4{
            return 4
        }
        else if value == 5{
            return 5
        }
        else if value == 6{
            return 6
        }
        else{
            return 3
        }
    }
    
}


