//
//  EightQueen.swift
//  Chess
//
//  Created by Loc Tran on 3/10/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import Foundation
import UIKit
struct QStep {
    var rootPosition:Position!
    var position:Position!
    var isTrue: Bool
    var backtrack: Int
}
class EightQueen {
    var steps = [QStep]()
    var stepSolutions = [[QStep]]()
    var trace = [Int]()
    var queens = [[Position]]()
    var index = 0
    var totalCol = 0
    init(row: Int, col: Int) {
        self.totalCol = col
        trace = [Int](repeating: 0, count: row+1)
        nQueens(row: 1, col: col, rootCol: 0)
        detectSteps()
    }
    

    //Chia các solutions từ mảng steps

    func detectSteps()
    {
        var curretSolution = [QStep]()
        var previousStep = self.steps.first
        for step in self.steps
        {
            var backTrack: QStep!
            //Tìm ra step là backTrack, chỉ xảy ra khi row thay đổi
            if(previousStep?.position.row != step.position.row)
            {
                //Và previousStep.col là cuối cùng
                if(previousStep?.position.col == self.totalCol)
                {
                    //trường hợp step đó là sai thì đó chính là backTrack
                    if( previousStep?.isTrue == false)
                    {
                        backTrack = previousStep
                        backTrack.backtrack = abs((previousStep?.position.row)! - step.position.row)
                    }//Trường hợp step đó đúng và row là cuối cùng thì đó là backTrack
                    else if(previousStep?.position.row == self.totalCol){
                        
                        backTrack = previousStep
                        backTrack.backtrack = abs((previousStep?.position.row)! - step.position.row)
                    }
                    if(backTrack != nil){
                        curretSolution.append(backTrack)
                    }
                }
                
            }
            //Khi step ở vị trí row 1 thì nó chính ra solution tiếp theo
            if(step.position.row == 1 && step.position.col != 1)
            {
                self.stepSolutions.append(curretSolution)
                curretSolution = [QStep]()
            }
           
            curretSolution.append(step)
            previousStep = step
        }
        self.stepSolutions.append(curretSolution)
        curretSolution = [QStep]()
    }
    func nQueens(row: Int, col: Int, rootCol: Int)
    {
        for checkCol in 1...col
        {
            if(isSafePlace(newRow: row, newCol: checkCol, rootPosition: Position(row: row-1, col: rootCol)))
            {
                trace[row] = checkCol
                if(row != col)
                {
                    nQueens(row: row+1, col: col, rootCol: checkCol)
                }
            }
        }
    }
    
    func isSafePlace(newRow: Int, newCol: Int, rootPosition: Position) -> Bool
    {
        var step = QStep(rootPosition: rootPosition, position: Position(row: newRow, col: newCol), isTrue: true, backtrack: 0)
        for checkRow in 1..<newRow
        {
            if(trace[checkRow] == newCol || abs(checkRow - newRow) == abs(trace[checkRow]-newCol))
            {
                step.isTrue = false
                self.steps.append(step)
                return false
            }
        }
        self.steps.append(step)
        return true
        
    }
}
