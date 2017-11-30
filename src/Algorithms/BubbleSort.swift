//
//  BubbleSort.swift
//  Algorithms
//
//  Created by Loc Tran on 3/22/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
import UIKit

class BubbleSort {
    
    var arrayAction = [Step]()
    var arrayInput = [Int]()
    
    init(arrayInput: [Int]) {
        self.arrayInput = arrayInput
        bubbleSort(array: arrayInput)
    }
    
    func bubbleSort(array: [Int]) {
        let n = array.count
        
        for i in 0..<n {
            for j in 0..<(n-i-1) {
                if (greaterThan(i: j, j: j+1) == true) {
                    swap(i: j, j: j+1)
                }
            }
        }
    }
    
    func compare(i: Int, j: Int) -> Int {
        self.arrayAction.append(Step(act: "compare", i: i, j: j))
        return arrayInput[i]-arrayInput[j]
    }
    
    func greaterThan(i: Int, j: Int) -> Bool {
        if compare(i: i, j: j) > 0{
            return true
        }
        return false
    }
    
    func swap(i: Int, j: Int) {
        self.arrayAction.append(Step(act: "swap", i: i, j: j))
        let temp = self.arrayInput[i];
        self.arrayInput[i] = self.arrayInput[j]
        self.arrayInput[j] = temp
    }
}
