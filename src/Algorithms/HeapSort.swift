//
//  HeapSort.swift
//  Algorithms
//
//  Created by Loc Tran on 4/6/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
import UIKit

class HeapSort {
    
    var actionArray = [HeapStep]()
    var arrayInput: [Int]!
    
    init(arrayInput: [Int]){
        self.arrayInput = arrayInput
        var arr = arrayInput
        
        
        self.actionArray.append(HeapStep(act: "start", i: nil, j: nil, end: nil))
        self.heapSort(array: &arr, size: arr.count)
        
    }
    
    func heapSort(array: inout [Int], size: Int) {
        var temp: Int
        
        for i in (0...Int(ceil(Double(size)/2)-1)).reversed(){
            heapify(&array, size, i)
        }
        
        for j in (0...(size-1)).reversed(){
            temp = array[0]
            array[0] = array[j]
            array[j] = temp
            
            actionArray.append(HeapStep(act: "swap", i: 0, j: j, end: j))
            actionArray.append(HeapStep(act: "moveEndUp", i: 0, j: j, end: j))
            
            heapify(&array, j, 0)
        }
    }
    
    func heapify(_ array: inout [Int], _ size: Int, _ root: Int) {
        
        var largest = root
        let left = 2 * root + 1
        let right = 2 * root + 2
        var temp: Int
        
        if (left < size && array[left] > array[largest]){
            largest = left
        }
        
        if (right < size && array[right] > array[largest]){
            largest = right
        }
        
        if (largest != root){
            temp = array[root]
            array[root] = array[largest]
            array[largest] = temp
            
            actionArray.append(HeapStep(act: "swap", i: root, j: largest, end: size-1))
            
            heapify(&array, size, largest)
        }
    }
}
