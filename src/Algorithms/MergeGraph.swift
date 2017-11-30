//
//  MergeGraph.swift
//  Algorithms
//
//  Created by Loc Tran on 3/21/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
import UIKit

class MergeGraph: UIView {
    
    let widthRatio = 2
    var arrayLabel: [SortingLabel]!
    var arrayLabelOne: [SortingLabel]!
    var arrayLabelTwo: [SortingLabel]!
    var arrayLabelThree: [SortingLabel]!
    var arrayLabelFour: [SortingLabel]!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(".....")
    }
    
    init(frame: CGRect, arrayDisplay: [Int], colors: [UIColor]) {
        super.init(frame: frame)
        
        self.arrayLabel = [SortingLabel]()
        self.arrayLabelOne = [SortingLabel]()
        self.arrayLabelTwo = [SortingLabel]()
        self.arrayLabelThree = [SortingLabel]()
        self.arrayLabelFour = [SortingLabel]()
        self.drawGraph(arrayDisplay: arrayDisplay, colors: colors)
    }
    
    private func drawGraph(arrayDisplay: [Int], colors: [UIColor]) {
        
        let spacing = frame.width/CGFloat(self.widthRatio * arrayDisplay.count + arrayDisplay.count + 1)
        let rectSize = CGFloat(widthRatio) * spacing
        var x = spacing
        
        SPACING = spacing
        
        var yFloor: CGFloat
        
        for index in 0..<arrayDisplay.count {
            
            let sortingLabel = SortingLabel(frame: CGRect(x: x, y: 0,
                                                          width: rectSize, height: rectSize),
                                            color: colors[index],
                                            value: String(arrayDisplay[index]))
            
            let FloorOne = SortingLabel(frame: CGRect(x: x, y: 0,
                                                      width: rectSize, height: rectSize),
                                        color: DEFAULT_COLOR,
                                        value: "0")
            
            FloorOne.isHidden = true
            yFloor = FloorOne.frame.origin.y + rectSize + spacing
            
            let FloorTwo = SortingLabel(frame: CGRect(x: x, y: yFloor,
                                                      width: rectSize, height: rectSize),
                                        color: DEFAULT_COLOR,
                                        value: "0")
            
            FloorTwo.isHidden = true
            yFloor = FloorTwo.frame.origin.y + rectSize + spacing
            
            let FloorThree = SortingLabel(frame: CGRect(x: x, y: yFloor,
                                                        width: rectSize, height: rectSize),
                                          color: colors[index],
                                          value: String(arrayDisplay[index]))
            FloorThree.isHidden = true
            
            yFloor = FloorThree.frame.origin.y + rectSize + spacing
            
            let FloorFour = SortingLabel(frame: CGRect(x: x, y: yFloor,
                                                       width: rectSize, height: rectSize),
                                         color: colors[index],
                                         value: String(arrayDisplay[index]))
            FloorFour.isHidden = true
            
            
            self.arrayLabel.append(sortingLabel)
            self.arrayLabelOne.append(FloorOne)
            self.arrayLabelTwo.append(FloorTwo)
            self.arrayLabelThree.append(FloorThree)
            self.arrayLabelFour.append(FloorFour)
            
            self.addSubview(FloorOne)
            self.addSubview(FloorTwo)
            self.addSubview(FloorThree)
            self.addSubview(FloorFour)
            self.insertSubview(sortingLabel, at: 3)
            
            x = x + spacing + rectSize
            
        }
    }
}
