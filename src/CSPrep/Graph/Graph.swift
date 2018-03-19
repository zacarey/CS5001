//
//  Graph.swift
//  Algorithms
//
//  Created by Loc Tran on 3/21/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
import UIKit


//Used by BubbleSort, SelectionSort, InsertionSort

class Graph: UIView {
    
    let widthRatio = 2
    var arrayLabel: [SortingLabel]!
    var arrayLabelAbove: [SortingLabel]!
    var arrayLabelMiddle: [SortingLabel]!
    var arrayLabelBelow: [SortingLabel]!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(".....")
    }
    
    init(frame: CGRect, arrayDisplay: [Int], colors: [UIColor]) {
        super.init(frame: frame)
        
        self.arrayLabel = [SortingLabel]()
        self.arrayLabelAbove = [SortingLabel]()
        self.arrayLabelMiddle = [SortingLabel]()
        self.arrayLabelBelow = [SortingLabel]()
        self.drawGraph(arrayDisplay: arrayDisplay, colors: colors)
    }
    
    private func drawGraph(arrayDisplay: [Int], colors: [UIColor]) {
        
        let spacing = frame.width/CGFloat(self.widthRatio * arrayDisplay.count + arrayDisplay.count + 1)
        let rectSize = CGFloat(widthRatio) * spacing
        var x = spacing
        
        for index in 0..<arrayDisplay.count {
            
            let sortingLabel = SortingLabel(frame: CGRect(x: x, y: 0 + rectSize + spacing,
                                                          width: rectSize, height: rectSize),
                                            color: colors[index],
                                            value: String(arrayDisplay[index]))
            
            let labelMiddle = SortingLabel(frame: CGRect(x: x, y: 0 + rectSize + spacing,
                                                         width: rectSize, height: rectSize),
                                           color: DEFAULT_COLOR,
                                           value: "0")
            labelMiddle.isHidden = true
            let labelAbove = SortingLabel(frame: CGRect(x: x, y: 0,
                                                        width: rectSize, height: rectSize),
                                          color: DEFAULT_COLOR,
                                          value: "0")
            labelAbove.isHidden = true
            let labelBelow = SortingLabel(frame: CGRect(x: x, y: 0 + 2*rectSize + 2*spacing,
                                                        width: rectSize, height: rectSize),
                                          color: colors[index],
                                          value: String(arrayDisplay[index]))
            labelBelow.isHidden = true
            
            self.arrayLabel.append(sortingLabel)
            self.arrayLabelMiddle.append(labelMiddle)
            self.arrayLabelAbove.append(labelAbove)
            self.arrayLabelBelow.append(labelBelow)
            
            self.addSubview(sortingLabel)
            self.addSubview(labelMiddle)
            self.addSubview(labelAbove)
            self.addSubview(labelBelow)
            
            x = x + spacing + rectSize
        }
    }
}

