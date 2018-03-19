//
//  DepthFirstSearch.swift
//  Algorithms
//
//  Created by Loc Tran on 5/17/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
struct DFS_Step{
    var act: String!
    var to: String!
}
class DepthFirstSearch{
    var arrayAction: [DFS_Step]!
    init() {
        self.arrayAction = [DFS_Step]()

        let adjacencyList = AdjacencyList<String>()



        let s = adjacencyList.createVertex(data: "S")
        let a = adjacencyList.createVertex(data: "A")
        let b = adjacencyList.createVertex(data: "B")
        let c = adjacencyList.createVertex(data: "C")
        let d = adjacencyList.createVertex(data: "D")
        let f = adjacencyList.createVertex(data: "F")
        let g = adjacencyList.createVertex(data: "G")
        let e = adjacencyList.createVertex(data: "E")
        let i = adjacencyList.createVertex(data: "I")

        adjacencyList.add(.undirected, from: s, to: a)
        adjacencyList.add(.undirected, from: a, to: b)
        adjacencyList.add(.undirected, from: a, to: d)
        adjacencyList.add(.undirected, from: a, to: c)
        adjacencyList.add(.undirected, from: c, to: i)
        //        adjacencyList.add(.undirected, from: b, to: d)
        adjacencyList.add(.undirected, from: c, to: i)
        adjacencyList.add(.undirected, from: d, to: g)
        adjacencyList.add(.undirected, from: d, to: f)
        adjacencyList.add(.undirected, from: f, to: e)
    }
    func depthFirstSearch(from start: Vertex<String>, to end: Vertex<String>, graph: AdjacencyList<String>) -> Stack<Vertex<String>> {
        var visited = Set<Vertex<String>>()
        var stack = Stack<Vertex<String>>()

        stack.push(start)
        visited.insert(start)

        outer: while let vertex = stack.peek(), vertex != end {

            guard let neighbours = graph.edges(from: vertex), neighbours.count > 0 else {
                stack.pop()
                self.arrayAction.append(DFS_Step(act: "back", to: stack.peekString))
                continue
            }

            for edge in neighbours {
                if !visited.contains(edge.destination) {
                    visited.insert(edge.destination)
                    stack.push(edge.destination)
                    self.arrayAction.append(DFS_Step(act: "push", to: stack.peekString))
                    stack.description


                    continue outer
                }
            }

            stack.pop()
            self.arrayAction.append(DFS_Step(act: "back", to: stack.peekString))
            
        }
        return stack
    }

}
