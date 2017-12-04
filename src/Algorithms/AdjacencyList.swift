//
//  AdjacencyList.swift
//  DsLienKe
//
//  Created by Loc Tran on 5/10/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation
open class AdjacencyList<T: Hashable> {
    public var adjacencyDict : [Vertex<T>: [Edge<T>]] = [:]
    public init() {}
    fileprivate func addDirectedEdge(from source: Vertex<Element>, to destination: Vertex<Element>) {
        let edge = Edge(source: source, destination: destination) // 1
        adjacencyDict[source]?.append(edge) // 2
    }
    fileprivate func addUndirectedEdge(vertices: (Vertex<Element>, Vertex<Element>)) {
        let (source, destination) = vertices
        addDirectedEdge(from: source, to: destination)
        addDirectedEdge(from: destination, to: source)
    }
}
extension AdjacencyList: Graphable {
    public typealias Element = T
    public func createVertex(data: Element) -> Vertex<Element> {
        let vertex = Vertex(data: data)

        if adjacencyDict[vertex] == nil {
            adjacencyDict[vertex] = []
        }
//        Vertex<Element>
        return vertex
    }
    public func add(_ type: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>) {
        switch type {
        case .directed:
            addDirectedEdge(from: source, to: destination)
        case .undirected:
            addUndirectedEdge(vertices: (source, destination))
        }
    }
    /*
    public func weight(from source: Vertex<Element>, to destination: Vertex<Element>) -> Double? {
        guard let edges = adjacencyDict[source] else { // 1
            return nil
        }

        for edge in edges { // 2
            if edge.destination == destination { // 3
                return edge.weight
            }
        }
        
        return nil // 4
    }
 */
    public func edges(from source: Vertex<Element>) -> [Edge<Element>]? {
        return adjacencyDict[source]
    }
    public var description: CustomStringConvertible {
        var result = ""
        for (vertex, edges) in adjacencyDict {
            var edgeString = ""
            for (index, edge) in edges.enumerated() {
                if index != edges.count - 1 {
                    edgeString.append("\(edge.destination), ")
                } else {
                    edgeString.append("\(edge.destination)")
                }
            }
            result.append("\(vertex) ---> [ \(edgeString) ] \n ")
        }
        return result
    }

}
