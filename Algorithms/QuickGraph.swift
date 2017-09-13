//
//  QuickGraph.swift
//  Algorithms
//
//  Created by Loc Tran on 3/21/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
import UIKit

class QuickGraph: UIView {
    
    let widthRatio = 2
    var arrayLabel: [SortingLabel]!
    var arrayLabelAbove: [SortingLabel]!
    var arrayLabelMiddle: [SortingLabel]!
    var arrayLabelMark: [SortingLabel]!
    var ptu: Int!
    init(frame: CGRect, arrayDisplay: [Int], colors: [UIColor]) {
        super.init(frame: frame)
        ptu = arrayDisplay.count + 2
        self.arrayLabel = [SortingLabel]()
        self.arrayLabelAbove = [SortingLabel]()
        self.arrayLabelMiddle = [SortingLabel]()
        self.arrayLabelMark = [SortingLabel]()
        self.drawGraph(arrayDisplay: arrayDisplay, colors: colors)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(".....")
        
    }
    
    private func drawGraph(arrayDisplay: [Int], colors: [UIColor]) {
        
        let spacing = frame.width/CGFloat(self.widthRatio * ptu + ptu + 1)
        let rectSize = CGFloat(widthRatio) * spacing
        RECTSIZE = rectSize
        SPACING = spacing
        var x = spacing
        
        
        for index in 0..<ptu {
            
            if(index > 0 && index < ptu-1){
                let sortingLabel = SortingLabel(frame: CGRect(x: x, y: rectSize + spacing,
                                                              width: rectSize, height: rectSize),
                                                color: colors[index-1],
                                                value: String(arrayDisplay[index-1]))
                self.arrayLabel.append(sortingLabel)
                self.addSubview(sortingLabel)
                
            }
            
            
            let labelMiddle = SortingLabel(frame: CGRect(x: x, y: rectSize + spacing,
                                                         width: rectSize, height: rectSize),
                                           color: SWAP_COLOR,
                                           value: "0")
            labelMiddle.isHidden = true
            
            let labelAbove = SortingLabel(frame: CGRect(x: x, y: 0,
                                                        width: rectSize, height: rectSize),
                                          color: DEFAULT_COLOR,
                                          value: "0")
            labelAbove.isHidden = true
            
            let labelMark = SortingLabel(frame: CGRect(x: x, y: 2*rectSize+spacing + 6,
                                                       width: rectSize, height: rectSize),
                                         color: DEFAULT_COLOR,
                                         value: "0")
            labelMark.isHidden = true
            
            self.arrayLabelMiddle.append(labelMiddle)
            self.arrayLabelAbove.append(labelAbove)
            self.arrayLabelMark.append(labelMark)
            
            self.addSubview(labelMiddle)
            self.addSubview(labelAbove)
            self.addSubview(labelMark)
            
            x = x + spacing + rectSize
        }
    }
    
    func drawBrace(bearing: Int,countCell: Int)->CALayer{
        
        let bearingPoin = CGPoint(x: self.arrayLabelMark[bearing].frame.origin.x, y: self.arrayLabelMark[bearing].frame.origin.y+RECTSIZE+10)
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        let lengthLine = CGFloat(countCell)*RECTSIZE + CGFloat(countCell-1)*SPACING
        linePath.move(to: CGPoint(x: bearingPoin.x-10, y: bearingPoin.y-10))
        linePath.addLine(to: CGPoint(x: bearingPoin.x, y: bearingPoin.y))
        linePath.move(to: CGPoint(x: bearingPoin.x, y: bearingPoin.y))
        linePath.addLine(to: CGPoint(x: bearingPoin.x+lengthLine, y: bearingPoin.y))
        linePath.move(to: CGPoint(x: bearingPoin.x+lengthLine, y: bearingPoin.y))
        linePath.addLine(to: CGPoint(x: bearingPoin.x+lengthLine+10, y: bearingPoin.y-10))
        
        line.path = linePath.cgPath
        line.lineWidth = 2
        line.strokeColor = UIColor.gray.cgColor
        self.layer.addSublayer(line)
        
        return line
        
    }
    func drawMark(textLR: String)->UILabel{
        
        let widthMark = RECTSIZE - 2*5
        let heightMark = RECTSIZE - 5
        let label = SortingLabel(frame: CGRect(x: 0, y: 0, width: widthMark, height: heightMark))
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: widthMark/2, y: 0))
        linePath.addLine(to: CGPoint(x: 0, y: 1/3*heightMark))
        linePath.addLine(to: CGPoint(x: 0, y: heightMark))
        linePath.addLine(to: CGPoint(x: widthMark, y: heightMark))
        linePath.addLine(to: CGPoint(x: widthMark, y: 1/3*heightMark))
        linePath.addLine(to: CGPoint(x: widthMark/2, y: 0))
        line.path = linePath.cgPath
        if(textLR=="P"){
            line.frame = label.frame
            let radians = CGFloat(Double.pi)
            line.transform = CATransform3DMakeRotation(radians, 0.0, 0.0, -1.0)
        }
        if(textLR=="L"){
            label.backgroundColor = UIColor.blue
            
        }else if(textLR=="R"){
            label.backgroundColor = UIColor.red
            
        }else{
            label.backgroundColor = UIColor.green
            
        }
        
        label.text = textLR
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.layer.mask = line
        return label
        
    }
}
