
//  ViewController.swift
//  testingAlgorithms
//
//  Created by Loc Tran on 3/22/17.
//  Copyright © 2017 LocTran. All rights reserved.
//
import UIKit
import Foundation

class QuickSort {
    
    var actionArray = [QuickStep]()
    var arrayInput: [Int]!
    
    init(arrayInput:[Int]) {
        self.arrayInput = arrayInput
        var arr = arrayInput
        // kieu inout la kieu tro doi tuong nen phai de kieu var arr chu khong de let arr
        quicksort(arr:&arr, left: 0, right: arr.count-1)
        
    }
    
    func random(min: Int, max: Int)->Int{
        
        assert(min < max)
        var ele = 0
        var random: Int!
        while(ele<3){
            random = Int(arc4random_uniform(UInt32(max-min+1))) + min
            ele+=1
            
        }
        return random
    }
    
    
    func partition(arr: inout [Int], left: Int, right: Int)-> Int{
        var i = left
        var j = right
        var tmp: Int
        
        var pivotLocation = (left + right)/2
        let pivot = arr[pivotLocation]
        
        actionArray.append(QuickStep(act: "newPivot", left: i, right: j, pivot: pivotLocation, array: arr))
        
        while (i <= j){
            while (arr[i] < pivot){
                
                actionArray.append(QuickStep(act: "moveLeft", left: i, right: j, pivot: pivotLocation, array: arr))
                i = i + 1
            }
            
            actionArray.append(QuickStep(act: "pauseLeft", left: i, right: j, pivot: pivotLocation, array: arr))
            
            while (arr[j] > pivot){
                actionArray.append(QuickStep(act: "moveRight", left: i, right: j, pivot: pivotLocation, array: arr))
                j = j - 1
            }
            
            actionArray.append(QuickStep(act: "pauseRight", left: i, right: j, pivot: pivotLocation, array: arr))
            
            
            if (i <= j){
                
                if(i==pivotLocation ){
                    pivotLocation = j
                    actionArray.append(QuickStep(act: "swap", left: i, right: j, pivot: pivotLocation, array: arr))
                    
                }else if(j==pivotLocation){
                    pivotLocation = i
                    actionArray.append(QuickStep(act: "swap", left: i, right: j, pivot: pivotLocation, array: arr))
                    
                }else{
                    actionArray.append(QuickStep(act: "swap", left: i, right: j, pivot: pivotLocation, array: arr))
                    
                }
                
                tmp = arr[i]
                arr[i] = arr[j]
                arr[j] = tmp
                
                i = i+1
                j = j-1
                
                if(j<0){
                    actionArray.append(QuickStep(act: "outLeft", left: i, right: j, pivot: pivotLocation, array: arr))
                }else if(i>self.arrayInput.count-1){
                    actionArray.append(QuickStep(act: "outRight", left: i, right: j, pivot: pivotLocation, array: arr))
                }else{
                    actionArray.append(QuickStep(act: "moveBoth", left: i, right: j, pivot: pivotLocation, array: arr))
                }
                
            }
        }
        
        return i
    }
    
    func quicksort(arr: inout [Int], left: Int, right: Int) {
        let index = partition(arr: &arr, left: left, right: right)
        
        if (left < index - 1){
            quicksort(arr: &arr, left: left, right: index - 1)
        }
        if (index < right){
            quicksort(arr: &arr, left: index, right: right)
        }
    }
    
}
