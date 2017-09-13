//
//  InsertionSort.swift
//  Algorithms
//
//  Created by Loc Tran on 3/22/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
import UIKit

class InsertionSort {
    
    var arrayAction = [InsertStep]()
    var arrayInput = [Int]()
    
    init(arrayInput: [Int]){
        self.arrayInput = arrayInput
        insertionSort(array: arrayInput)
    }
    
    func insertionSort(array: [Int]) {
        let n = array.count
        for i in 1..<n{
            let valueKey = self.arrayInput[i]
            var j = i - 1
            self.arrayAction.append(InsertStep(act: "start", i: i, j: j, key: i))
            while(j >= 0 && self.arrayInput[j] > valueKey){
                self.arrayAction.append(InsertStep(act: "swap", i: j+1, j: j, key: j+1))
                self.arrayInput[j+1] = self.arrayInput[j]
                // thuc hien swap
                self.arrayAction.append(InsertStep(act: "move", i: j, j: j+1, key: j))
                
                if(j == 0){
                    self.arrayAction.append(InsertStep(act: "end", i: nil, j: j, key: j))
                }
                
                j = j - 1
            }
            if(j != -1){
                self.arrayAction.append(InsertStep(act: "end", i: nil, j: self.arrayAction.last?.j, key: self.arrayAction.last?.key))
            }
            self.arrayInput[j+1] = valueKey
        }
    }
    
    
    func swap(i: Int, j: Int) {
        let temp = self.arrayInput[i];
        self.arrayInput[i] = self.arrayInput[j]
        self.arrayInput[j] = temp
    }
}
