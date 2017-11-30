//
//  Step.swift
//  Algorithms
//
//  Created by Loc Tran on 3/28/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
import UIKit

// Used by BubbleSort and SelectionSort
struct Step {
    var act: String!
    var i: Int!
    var j: Int!
}

// Used by InsertionSort
struct InsertStep {
    var act: String!
    var i: Int!
    var j: Int!
    var key: Int!
    
}

// Used by MergeSort
struct MergeStep {
    var act: String!
    var root: [Int]!
    var left: [Int]!
    var right: [Int]!
    var level:Int!
    var stepSplit: Int!
    var relation: Bool!
    var merge: [Int]!
    
}

// Used by QuickSort
struct QuickStep {
    var act: String!
    var left: Int!
    var right: Int!
    var pivot: Int!
    var array:[Int]!
    
}

//Used by HeapSort
struct HeapStep {
    var act: String!
    var i: Int!
    var j: Int!
    var end: Int!
}

struct TowerStep {
    var disk: Int!
    var from: String!
    var to: String!
}

struct LinearStep {
    var act: String!
}

struct BinaryStep {
    var act: String!
    var midIndex: Int!
}









