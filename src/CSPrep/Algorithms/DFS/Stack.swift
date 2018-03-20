//
//  Stack.swift
//  DsLienKe
//
//  Created by Loc Tran on 5/10/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation
struct Stack<Element> {
    fileprivate var array: [Element] = []
    
    mutating func push(_ element: Element) {
        array.append(element)
    }
    
    mutating func pop() -> Element? {
        return array.popLast()
    }
    
    func peek() -> Element? {
        return array.last
    }
}
extension Stack: CustomStringConvertible {
    // 2
    var description: String {
        // 3
        let topDivider = "---Stack---"
        
        
        // 4
        let stackElements = array.map { "\($0)" }.reversed().joined(separator: "")
        // 5
        return topDivider + stackElements
    }
    var peekString: String{
        return array.map { "\($0)" }.last!
        //        return array.map { "\($0)" }.
        //        return array.last as! String
        
    }
}
