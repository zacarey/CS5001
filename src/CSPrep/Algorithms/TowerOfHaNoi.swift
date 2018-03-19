//
//  TowerOfHaNoi.swift
//  Algorithms
//
//  Created by Loc Tran on 5/3/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation

class TowerOfHaNoi {
    
    var arrayAction: [TowerStep]!
    var moveCount = 0
    
    init(disk: Int!) {
        arrayAction = [TowerStep]()
        hanoi(n: disk, a: "A", b: "B", c: "C")
    }
    
    
    func hanoi(n:Int, a:String, b:String, c:String) {
        if (n > 0) {
            hanoi(n: n - 1, a: a, b: c, c: b)
            arrayAction.append(TowerStep(disk: n, from: a, to: c ))
            
            hanoi(n: n - 1, a: b, b: a, c: c)
        }
}
}
