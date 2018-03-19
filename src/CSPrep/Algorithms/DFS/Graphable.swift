//
//  Graphable.swift
//  DsLienKe
//
//  Created by Loc Tran on 5/10/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation
enum Visit<Element: Hashable> {
    case source
    case edge(Edge<Element>)
}
protocol Graphable {
    associatedtype Element: Hashable // 1
    var description: CustomStringConvertible { get } // 2

    func createVertex(data: Element) -> Vertex<Element> // 3
    func add(_ type: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>) // 4
   
    func edges(from source: Vertex<Element>) -> [Edge<Element>]? // 6
}
//extension Graphable {
//    public func breadthFirstSearch(from source: Vertex<Element>, to destination: Vertex<Element>)
//        -> [Edge<Element>]? {
//            var queue = Queue<Vertex<Element>>()
//            queue.enqueue(source) // 1
//
//            while let visitedVertex = queue.dequeue() { // 2
//                if visitedVertex == destination { // 3
//                    return []
//                }
//                // TODO...
//            }
//            return nil // 
//            
//    }
//}
