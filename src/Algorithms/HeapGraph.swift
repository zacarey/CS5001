//
//  HeapGraph.swift
//  Algorithms
//
//  Created by Loc Tran on 4/6/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
import UIKit

class HeapGraph: UIView {
    
    let widthRatio = 2
    var arrayLabel: [SortingLabel]!
    var arrayLabelBehind: [SortingLabel]!
    var arrayLabelOne: [SortingLabel]!
    var arrayLabelTwo: [SortingLabel]!
    var arrayLabelThree: [SortingLabel]!
    
    var sortingLabel: SortingLabel!
    var FloorBehind: SortingLabel!
    var FloorOne: SortingLabel!
    var FloorTwo: SortingLabel!
    var FloorThree: SortingLabel!
    
    var arrayPosition: [SortingLabel]!
    
    var arrayLine: [CAShapeLayer]!
    
    var spacingFrame: CGFloat!
    var rectSizeFrame: CGFloat!
    
    var spacing: CGFloat!
    var rectSize: CGFloat!
    
    var yFloor: CGFloat!
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(".....")
    }
    
    init(frame: CGRect, arrayDisplay: [Int], colors: [UIColor]) {
        super.init(frame: frame)
        
        spacing = frame.width/CGFloat(self.widthRatio * arrayDisplay.count + arrayDisplay.count + 1)
        
        rectSize = CGFloat(widthRatio) * spacing
        
        spacingFrame = frame.width/CGFloat(self.widthRatio * 7 + 8)
        rectSizeFrame = CGFloat(widthRatio) * spacingFrame
        
        self.arrayLabel = [SortingLabel]()
        self.arrayLabelBehind = [SortingLabel]()
        self.arrayLabelOne = [SortingLabel]()
        self.arrayLabelTwo = [SortingLabel]()
        self.arrayLabelThree = [SortingLabel]()
        self.arrayPosition = [SortingLabel]()
        self.arrayLine = [CAShapeLayer]()
        
        self.drawGraph(arrayDisplay: arrayDisplay, colors: colors)
        self.drawFrame()
        
        self.arrayPosition.append(self.arrayLabelOne[3])
        self.arrayPosition.append(self.arrayLabelTwo[1])
        self.arrayPosition.append(self.arrayLabelTwo[5])
        self.arrayPosition.append(self.arrayLabelThree[0])
        self.arrayPosition.append(self.arrayLabelThree[2])
        self.arrayPosition.append(self.arrayLabelThree[4])
        self.arrayPosition.append(self.arrayLabelThree[6])
        
    }
    
    private func drawFrame(){
        
        var xFrame = spacingFrame
        
        for _ in 0..<7{
            
            FloorOne = SortingLabel(frame: CGRect(x: xFrame!, y: rectSize*2 + spacing,
                                                  width: rectSizeFrame, height: rectSizeFrame),
                                    color: DEFAULT_COLOR,
                                    value: "0")
            
            FloorOne.isHidden = true
            
            FloorTwo = SortingLabel(frame: CGRect(x: xFrame!, y: rectSize*3 + spacing*2,
                                                  width: rectSizeFrame, height: rectSizeFrame),
                                    color: DEFAULT_COLOR,
                                    value: "0")
            FloorTwo.isHidden = true
            
            FloorThree = SortingLabel(frame: CGRect(x: xFrame!, y: rectSize*4 + spacing*3,
                                                    width: rectSizeFrame, height: rectSizeFrame),
                                      color: DEFAULT_COLOR,
                                      value: "0")
            FloorThree.isHidden = true
            
            
            self.arrayLabelOne.append(FloorOne)
            self.arrayLabelTwo.append(FloorTwo)
            self.arrayLabelThree.append(FloorThree)
            
            self.addSubview(FloorOne)
            self.addSubview(FloorTwo)
            self.addSubview(FloorThree)
            
            xFrame = xFrame! + spacingFrame + rectSizeFrame
            
        }
        
        
    }
    
    private func drawGraph(arrayDisplay: [Int], colors: [UIColor]) {
        
        var x = spacing
        
        
        for index in 0..<arrayDisplay.count {
            
            sortingLabel = SortingLabel(frame: CGRect(x: x!, y: rectSize,
                                                      width: rectSize, height: rectSize),
                                        color: colors[index],
                                        value: String(arrayDisplay[index]))
            
            FloorBehind = SortingLabel(frame: CGRect(x: x!, y: rectSize,
                                                     width: rectSize, height: rectSize),
                                       color: DEFAULT_COLOR,
                                       value: "0")
            
            FloorBehind.isHidden = true
            
            self.arrayLabel.append(sortingLabel)
            self.arrayLabelBehind.append(FloorBehind)
            
            self.insertSubview(sortingLabel, at: 2)
            self.addSubview(FloorBehind)
            
            x = x! + spacing + rectSize
            
        }
        
    }
    
    func drawLine(start: Int, arrayPosition: [SortingLabel]){
        
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        var end: Int!
        
        if start == 0 {
            end = start
        }else if (start % 2 != 0){
            end = (start-1)/2
        }else if (start % 2 == 0){
            end = (start-2)/2
        }
        
        linePath.move(to: self.arrayPosition[start].center)
        linePath.addLine(to: self.arrayPosition[end].center)
        line.path = linePath.cgPath
        line.strokeColor = GRAY_COLOR.cgColor
        line.lineWidth = 4
        self.layer.insertSublayer(line, at: 0)
        
        self.arrayLine.append(line)
    }
    
    func removeLine(){
        self.arrayLine.last?.removeFromSuperlayer()
        self.arrayLine.removeLast()
        
    }
    
    
    
}
