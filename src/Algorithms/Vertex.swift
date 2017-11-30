//
//  Vertex.swift
//  DsLienKe
//
//  Created by Ledung95d on 5/10/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation
public struct Vertex<T: Hashable> {
    var data: T
}
extension Vertex: Hashable {
    public var hashValue: Int { // 1
        return "\(data)".hashValue
    }

    static public func ==(lhs: Vertex, rhs: Vertex) -> Bool { // 2
        return lhs.data == rhs.data
    }
    
}
extension Vertex: CustomStringConvertible {
    public var description: String {
        return "\(data)"
    }
}

