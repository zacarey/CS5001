//
//  BinarySearch.swift
//  Algorithms
//
//  Created by TTung on 5/10/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation

class BinarySearch {
    var arrayAction = [BinaryStep]()
    var arrayInput = [Int]()
    
    init(arrayInput: [Int], search: Int){
        self.arrayInput = arrayInput
        self.arrayAction.append(BinaryStep(act: "Start", midIndex: 0))

        binarySearch(arrayInput, key: search, range: 0 ..< arrayInput.count)
    }
    
    func binarySearch<T: Comparable>(_ a: [T], key: T, range: Range<Int>) -> Int? {
        if range.lowerBound >= range.upperBound {
            // If we get here, then the search key is not present in the array.
            self.arrayAction.append(BinaryStep(act: "NotFound", midIndex: 0))
            return nil
            
        } else {
            // Calculate where to split the array.
            let midIndex = range.lowerBound + (range.upperBound - range.lowerBound) / 2
            
            // Is the search key in the left half?
            if a[midIndex] > key {
                self.arrayAction.append(BinaryStep(act: "DivideSmall", midIndex: midIndex))
                return binarySearch(a, key: key, range: range.lowerBound ..< midIndex)
                
                
                // Is the search key in the right half?
            } else if a[midIndex] < key {
                self.arrayAction.append(BinaryStep(act: "DivideBig", midIndex: midIndex))
                return binarySearch(a, key: key, range: midIndex + 1 ..< range.upperBound)
                
                // If we get here, then we've found the search key!
            } else {
                self.arrayAction.append(BinaryStep(act: "Done", midIndex: midIndex))    
                return midIndex
            }
        }
    }
}
