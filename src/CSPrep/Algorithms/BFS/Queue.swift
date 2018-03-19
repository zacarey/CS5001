//
//  Queue.swift
//  DsLienKe
//
//  Created by Loc Tran on 5/18/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation
public struct Queue<T> {
    
    // 2
    fileprivate var list = LinkedList<T>()
    
    public var isEmpty: Bool {
        return list.isEmpty
    }
    
    // 3
    public mutating func enqueue(_ element: T) {
        list.append(value: element)
    }
    
    // 4
    public mutating func dequeue() -> T? {
        guard !list.isEmpty, let element = list.first else { return nil }
        
        list.remove(node: element)
        
        return element.value
    }
    
    // 5
    public func peek() -> T? {
        return list.first?.value
    }
}
extension Queue: CustomStringConvertible {
    // 2
    public var description: String {
        // 3
        return list.description
    }
    public var dequeueString: String{
        return list.firstNode
    }
}
