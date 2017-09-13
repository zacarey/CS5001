//
//  MergeSort.swift
//  Algorithms
//
//  Created by Admin on 3/30/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import UIKit
import Foundation

class MergeSort{
    var arrayAction: [MergeStep]!
    var arrayElement: [MergeStep]!
    var eleInitital: [Int]!
    
    init(arrayInput:[Int] ) {
        
        arrayAction = [MergeStep]()
        arrayElement = [MergeStep]()
        eleInitital = [Int]()
        for i in 0..<arrayInput.count{
            eleInitital.append(i)
        }
        mergeSort(array: arrayInput, eleArray: eleInitital, level: 2, isLeft: true)
        
    }
    
    
    func merge(leftArray: [Int], rightArray: [Int],currentLevel: Int) -> [Int] {
        let _stepSplit = getStepSplit()
        var _eleArray = [Int]()
        
        var leftIndex = 0
        var rightIndex = 0
        
        var sortedArray = [Int]()
        
        // Compare the elements and add them to the sorted array *in order*
        // so sanh 2 phan tu trong left and right neu phan tu nao be hon thi xep truoc
        
        self.arrayElement.append(MergeStep(act: "eleMerge", root: leftArray + rightArray, left: leftArray, right: rightArray, level: currentLevel,stepSplit: _stepSplit,relation: nil, merge: nil))
        
        
        while leftIndex < leftArray.count && rightIndex < rightArray.count {
            if leftArray[leftIndex] < rightArray[rightIndex] {
                sortedArray.append(leftArray[leftIndex])
                leftIndex += 1
            } else if leftArray[leftIndex] > rightArray[rightIndex] {
                sortedArray.append(rightArray[rightIndex])
                rightIndex += 1
            } else {
                
                
                sortedArray.append(leftArray[leftIndex])
                leftIndex += 1
                sortedArray.append(rightArray[rightIndex])
                rightIndex += 1
                
            }
        }
        // At this point, the elements were compared and sorted properly,
        // so we just need to append the rest of the items to the array
        // doan code nay la xep lai nhung phan tu du thua
        while leftIndex < leftArray.count {
            sortedArray.append(leftArray[leftIndex])
            _eleArray.append(self.arrayElement[_stepSplit].left[leftIndex])
            leftIndex += 1
        }
        while rightIndex < rightArray.count {
            sortedArray.append(rightArray[rightIndex])
            _eleArray.append(self.arrayElement[_stepSplit].right[rightIndex])
            rightIndex += 1
        }
        
        _eleArray = [Int]()
        _eleArray = self.sortElement(arr: self.arrayAction[_stepSplit].left + self.arrayAction[_stepSplit].right, _stepSplit: _stepSplit)
        self.arrayElement[self.arrayElement.count-1].merge = _eleArray
        self.arrayAction.append(MergeStep(act: "Merge", root: leftArray + rightArray, left: leftArray, right: rightArray, level: currentLevel,stepSplit: _stepSplit,relation: nil, merge: sortedArray))
        
        return sortedArray
    }
    
    func sortElement(arr: [Int],_stepSplit: Int)->[Int]{
        var sortEle = [Int]()
        var arrMerge: [Int] = self.arrayElement[_stepSplit].merge
        sortEle = arr
        for i in (0..<sortEle.count-1){
            var minAt = i
            for j in (i+1)..<sortEle.count{
                if(sortEle[minAt]>sortEle[j]){
                    minAt = j
                }
            }
            var temp = sortEle[i]
            sortEle[i] = sortEle[minAt]
            sortEle[minAt] = temp
            
            temp = arrMerge[i]
            arrMerge[i] = arrMerge[minAt]
            arrMerge[minAt] = temp
        }
        
        return arrMerge
        
    }
    
    
    func getStepSplit()->Int{
        var _step: Int!
        
        for ele in (0..<self.arrayAction.count).reversed(){
            if(self.arrayAction[ele].act=="Split" && self.arrayAction[ele].relation == false){
                self.arrayAction[ele].relation = true
                _step = ele
                break
            }
        }
        return _step
    }
    func getElement(eL: Int,eR: Int,eleArray: [Int])->[Int]{
        
        var arr = [Int]()
        for ele in eL..<eR{
            arr.append(eleArray[ele])
        }
        return arr
        
    }
    
    
    func mergeSort(array: [Int],eleArray: [Int],level: Int,isLeft: Bool) -> [Int] {
        let currentLevel = level
        
        guard array.count > 1 else {
            
            return array
        }
        
        let middleIndex = Int(ceil(Double(array.count)/2))
        
        
        
        // Recursively sort the left and right parts of the array
        
        
        
        self.arrayAction.append(MergeStep(act: "Split", root: array, left: Array(array[0..<middleIndex]), right: Array(array[middleIndex..<array.count]), level: currentLevel,stepSplit: nil,relation: false, merge: nil))
        self.arrayElement.append(MergeStep(act: "eleSplit", root: nil, left: Array(eleArray[0..<middleIndex]), right: Array(eleArray[middleIndex..<array.count]), level: currentLevel,stepSplit: nil,relation: nil, merge: self.getElement(eL: 0, eR: array.count,eleArray: eleArray)))
        
        
        let leftArray = mergeSort(array: Array(array[0..<middleIndex]),eleArray: Array(eleArray[0..<middleIndex]),level: currentLevel+1,isLeft: true)
        
        
        let rightArray = mergeSort(array: Array(array[middleIndex..<array.count]),eleArray: Array(eleArray[middleIndex..<array.count]),level:currentLevel+1,isLeft: false)
        
        let sort = merge(leftArray: leftArray, rightArray: rightArray,currentLevel: currentLevel-1)
        
        
        return sort
    }
    
}
