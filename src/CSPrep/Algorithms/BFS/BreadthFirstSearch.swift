//
//  Breadth_Search.swift
//  Algorithms
//
//  Created by Loc Tran on 5/18/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
struct BFS_Step{
    var act: String!
    var point: String!
}
class BreadthFirstSearch{
    var arrayAction: [BFS_Step]!
    init() {
        
        
        var adjacencyList = AdjacencyList<String>()
        
        
        
        let s = adjacencyList.createVertex(data: "S")
        let a = adjacencyList.createVertex(data: "A")
        let b = adjacencyList.createVertex(data: "B")
        let c = adjacencyList.createVertex(data: "C")
        let d = adjacencyList.createVertex(data: "D")
        let f = adjacencyList.createVertex(data: "F")
        let g = adjacencyList.createVertex(data: "G")
        let e = adjacencyList.createVertex(data: "E")
        
        adjacencyList.add(.undirected, from: s, to: a)
        adjacencyList.add(.undirected, from: a, to: b)
        adjacencyList.add(.undirected, from: a, to: d)
        adjacencyList.add(.undirected, from: a, to: c)
        //        adjacencyList.add(.undirected, from: b, to: d)
        adjacencyList.add(.undirected, from: d, to: g)
        adjacencyList.add(.undirected, from: d, to: f)
        adjacencyList.add(.undirected, from: f, to: e)
        //        adjacencyList.breadthFirstSearch(from: s, to: e)
        self.arrayAction = adjacencyList.breadthFirstSearch(from: s, to: e)
    }
    
    
}
extension Graphable {
    
    public mutating func breadthFirstSearch(from source: Vertex<Element>, to destination: Vertex<Element>)
        -> [BFS_Step] {
            var arrayAction = [BFS_Step]()
            var queue = Queue<Vertex<Element>>()
            queue.enqueue(source)
            var visits : [Vertex<Element> : Visit<Element>] = [source: .source] // 1
            while let visitedVertex = queue.dequeue() {
                //                var a = visitedVertex as! String
                
                
                arrayAction.append(BFS_Step(act: "putOut", point: "\(visitedVertex)"))
                // TODO: Replace this...
                if visitedVertex == destination {
                    var vertex = destination // 1
                    var route : [Edge<Element>] = [] // 2
                    
                    while let visit = visits[vertex],
                        case .edge(let edge) = visit { // 3
                            
                            route = [edge] + route
                            vertex = edge.source // 4
                            
                            
                    }
                    
                    //                    return route // 5
                    return arrayAction
                }
                let neighbourEdges = edges(from: visitedVertex) ?? []
                for edge in neighbourEdges {
                    if visits[edge.destination] == nil { // 2
                        queue.enqueue(edge.destination)
                        arrayAction.append(BFS_Step(act: "destination", point: "\(edge.destination)"))
                        
                        visits[edge.destination] = .edge(edge) // 3
                    }
                }
            }
            
            return arrayAction
    }
    
    
}
