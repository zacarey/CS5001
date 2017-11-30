//
//  PieceSet.swift
//  Chess
//
//  Created by Tuuu on 3/8/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import Foundation
import UIKit
protocol PieceSetDelegate {
    func didFinishInitPieceSet(pieceControllers: [PieceController])
    func didFinishAddNewPiece(pieceController: PieceController)
    func didRemovePieceController(pieceView: PieceView)
}

struct VisibleOnBoard {
    var type:PieceType!
    var position:Position!
}
class PieceSet
{
    var delegate: PieceSetDelegate!
    var pieceOrder = [PieceType]()
    var pieceControllers = Array<PieceController>()
    var color: PieceColor!
    var rowTotal: Int!
    var colTotal: Int!
    var width: CGFloat!
    var rootPiece: Piece!
    var previousControllers = Array<PieceController>()
    var prePiece: Piece!
    
    init(color: PieceColor, rowTotal: Int, colTotal: Int, width: CGFloat) {
        pieceOrder.append(contentsOf: [.Rook, .Knight, .Bishop, .Queen, .King, .Bishop, .Knight, .Rook])
        self.color = color
        self.rowTotal = rowTotal
        self.colTotal = colTotal
        self.width = width
    }
    
    func getAllVisible() -> [VisibleOnBoard]{
        var visibleOnBoards = [VisibleOnBoard]()
        for pieceController in pieceControllers{
            let  visibleOnBoard = VisibleOnBoard(type: pieceController.pieceModel.type, position: pieceController.pieceModel.placeAt)
            visibleOnBoards.append(visibleOnBoard)
        }
        return visibleOnBoards
    }
    
    func savePreviousControllers(){
        self.previousControllers = self.pieceControllers
    }
    
    func setPreviousControllers(){
        self.pieceControllers = self.previousControllers
    }
    
    func removePieceModel(piece: Piece)
    {
        for pieceController in self.pieceControllers
        {
            if(pieceController.pieceModel.placeAt == piece.placeAt)
            {
                self.removePieceController(pieceController: pieceController)
            }
        }
    }
    func removePieceController(pieceController: PieceController)
    {
        self.pieceControllers.remove(object: pieceController)
        self.delegate.didRemovePieceController(pieceView: pieceController.pieceView)
    }
    func removeAllPieceControllers()
    {
        for pieceController in self.pieceControllers
        {
            self.removePieceController(pieceController: pieceController)
        }
    }
    func removeBacktrackedPieceControllers(backtrack: QStep)
    {
        var currentPieceControllers = self.pieceControllers
        let numberOfPieceControllers = self.pieceControllers.count-1
        let rootBacktrack = Position(row: backtrack.rootPosition.row-1, col: backtrack.rootPosition.col-1)
        for index in 0..<backtrack.backtrack*(self.colTotal)
        {
            if(currentPieceControllers[numberOfPieceControllers - index].pieceModel.placeAt != rootBacktrack)
            {
                self.removePieceController(pieceController: currentPieceControllers[numberOfPieceControllers - index])
            }
            
        }
        self.setUnSafePlaceForRootPosition(pieceController: self.getPieceControllerAt(position: rootBacktrack)!)
    }
    func getPieceAt(position: Position) -> Piece?
    {
        for pieceController in self.pieceControllers
        {
            if(pieceController.pieceModel.placeAt.row == position.row &&
                pieceController.pieceModel.placeAt.col == position.col)
            {
                return pieceController.pieceModel
            }
        }
        return nil
    }
    func getPieceViewAt(position: Position) -> PieceView?
    {
        for pieceController in self.pieceControllers
        {
            if(pieceController.pieceModel.placeAt.row == position.row &&
                pieceController.pieceModel.placeAt.col == position.col)
            {
                return pieceController.pieceView
            }
        }
        return nil
    }
    func getPieceControllerAt(position: Position) -> PieceController?
    {
        for pieceController in self.pieceControllers
        {
            if(pieceController.pieceModel.placeAt.row == position.row &&
                pieceController.pieceModel.placeAt.col == position.col)
            {
                return pieceController
            }
        }
        return nil
    }
    func addPieces()
    {
        addPieceQueen(color: color, rowTotal: rowTotal-1, colTotal: colTotal-1, width: width)
        self.delegate?.didFinishInitPieceSet(pieceControllers:self.pieceControllers)
    }
    func addPieces(color: PieceColor, rowTotal: Int, colTotal: Int, width: CGFloat)
    {
        switch color {
        case .White:
            let startCoordinates = Position(row: 0, col: 0)
            let endCoordinates = Position(row: 1, col: colTotal-1)
            self.addPiecesWith(startCoordinates: startCoordinates,
                               endCoordinates: endCoordinates,
                               color: color,
                               width: width)
            break
        default:
            let startCoordinates = Position(row: rowTotal - 1, col: 0)
            let endCoordinates = Position(row: rowTotal - 2, col: colTotal - 1)
            self.addPiecesWith(startCoordinates: startCoordinates,
                               endCoordinates: endCoordinates,
                               color: color,
                               width: width)
            break
        }
        
    }
    
    func setUnSafePlaceForRootPosition(pieceController: PieceController)
    {
        var piece = pieceController.pieceModel
        while true {
            self.getPieceViewAt(position: (Position(row: ((piece?.placeAt.row)!),
                                                    col: (piece?.placeAt.col)!)))?.image = UIImage(named: "False")
            piece?.type = .None
            self.rootPiece = piece?.root
            if(piece?.root == nil || piece?.placeAt.col != self.colTotal-1)
            {
                return
            }
            self.removePieceModel(piece: piece!)
            piece = piece?.root
        }
    }
    func addnewQueenAt(position: Position, isTrue: Bool)
    {
        let cellInfo = CellInfo(margin: 0, squareWidth: width)
        let currentPiece: Piece!
        if(isTrue == false)
        {
            currentPiece = Piece(pieceColor: .None, at: position, type: .None)
        }
        else
        {
            currentPiece = Queen(pieceColor: color, at: position)
        }
        
        currentPiece.prePiece = prePiece
        currentPiece.state = self.getAllVisible()
        prePiece = currentPiece
        
        currentPiece.root = self.rootPiece
        //Khi piece ở dòng mới thì mới đổi rootPiece
        if(currentPiece.type != .None)
        {
            self.rootPiece = currentPiece
        }
        let pieceController = PieceController(pieceModel: currentPiece, cellInfo: cellInfo)
        self.pieceControllers.append(pieceController)
        self.delegate?.didFinishAddNewPiece(pieceController: pieceController)
    }
    func addPieceQueen(color: PieceColor, rowTotal: Int, colTotal: Int, width: CGFloat){
        
        let startCoordinates = Position(row: 0, col: 0)
        let endCoordinates = Position(row: 1, col: colTotal)
        self.addPieceQueenWith(startCoordinates: startCoordinates,
                               endCoordinates: endCoordinates,
                               color: color,
                               width: width)
    }
    
    func addPieceQueenWith(startCoordinates: Position, endCoordinates: Position, color: PieceColor, width: CGFloat){
        _ = true // when isFirst == false, we just add pawns to the board
        var startRow = 0
        var endRow = 0
        let startCol = startCoordinates.col!
        let endCol = endCoordinates.col!
        startRow = startCoordinates.row
        endRow = endCoordinates.row
        for col in startCol...endCol {
            let position = Position(row: 0, col: col)
            self.addnewQueenAt(position: position, isTrue: true)
        }
    }
    func addPiecesWith(startCoordinates: Position, endCoordinates: Position, color: PieceColor, width: CGFloat)
    {
        var isFirst = true // when isFirst == false, we just add pawns to the board
        var startRow = 0, endRow = 0
        let startCol = startCoordinates.col!
        let endCol = endCoordinates.col!
        startRow = startCoordinates.row
        endRow = endCoordinates.row
        let stepUp = startRow > endRow ? -1 : 1
        
        for row in stride(from: startRow, through: endRow, by: stepUp) {
            for col in startCol...endCol {
                let position = Position(row: row, col: col)
                let cellInfo = CellInfo(margin: 0, squareWidth: width)
                let currentPiece: Piece!
                if(isFirst == false)
                {
                    currentPiece = Queen(pieceColor: color, at: position)
                    
                }
                else
                {
                    currentPiece = createPieceWith(type: self.pieceOrder[col] , color: color, at: position)
                }
                let pieceController = PieceController(pieceModel: currentPiece, cellInfo: cellInfo)
                self.pieceControllers.append(pieceController)
            }
            isFirst = false
        }
    }
    func createPieceWith(type: PieceType, color: PieceColor, at position: Position) -> Piece
    {
        let currentPiece: Piece!
        switch type {
            
        case .Queen:
            currentPiece = Queen(pieceColor: color, at: position)
            break
        default:
            currentPiece = Queen(pieceColor: color, at: position)
            
            break
        }
        return currentPiece
    }
    func movePieceAt(fromPosition: Position, toPosition: Position)
    {
        
    }
}

extension Array where Element: AnyObject {
    mutating func remove(object: Element) {
        if let index = index(where: { $0 === object }) {
            remove(at: index)
        }
    }
}
