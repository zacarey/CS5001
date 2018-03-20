//
//  Edge.swift
//  DsLienKe
//
//  Created by Loc Tran on 5/10/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation
import UIKit

public enum EdgeType {
    case directed, undirected
}

public struct Edge<T: Hashable> {
    public var source: Vertex<T> // 1
    public var destination: Vertex<T>
    
}
extension Edge: Hashable {
    
    public var hashValue: Int {
        return "\(source)\(destination)".hashValue
    }
    
    static public func ==(lhs: Edge<T>, rhs: Edge<T>) -> Bool {
        return lhs.source == rhs.source &&
            lhs.destination == rhs.destination 
        //            lhs.weight == rhs.weight
    }
}
