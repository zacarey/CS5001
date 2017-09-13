//
//  GameManager.swift
//  Chess
//
//  Created by Tuuu on 3/8/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import Foundation
import UIKit
import KDPulseButton


class GameManager: UIView
{
    
    var boardView: Board!
    var playedMoves: [Move]!
    var turn: PieceColor!
    var pieceSets:[PieceSet]! // 1-->2
    var pieceSetOnTop: PieceColor!
    var delegate: PieceSetDelegate!
    var mainView: UIView!
    var fromPosition: UITextField!
    var toPosition: UITextField!
    var nQueens:EightQueen!
    var queens = [[Position]]()
    var stepSolutions = [[QStep]]()
    var rowTotal = 4
    var colTotal = 4
    var dem = 0
    var lblSolutionFound:UILabel!
    var lblSolutionText:UILabel!
    
    var spacing:CGFloat!
    var widthRatio = 3
    var btnSizeWidth:CGFloat!
    var btnSizeHeight:CGFloat!
    var x:CGFloat!
    var count = 0
    var countM: Int!
    var end = false
    var isPause: Bool!
    var pause: Bool = false{
        didSet {
            if pause == false{
                autoAnimation()
            }
        }
    }
    
    
    func initGameWith(viewcontroller: UIViewController, size: CGFloat)
    {
        spacing = viewcontroller.view.bounds.size.width/CGFloat(widthRatio*3 + 4)
        btnSizeWidth = spacing*CGFloat(widthRatio)
        btnSizeHeight = btnSizeWidth*3/5
        x = 2*spacing + btnSizeWidth
        
        
        boardView = Board(frame: CGRect(x: 0,
                                        y: viewcontroller.view.bounds.size.height / 2 - size*5/8,
                                        width: size, height: size),
                          rowTotal: rowTotal,
                          colTotal: colTotal)
        viewcontroller.view.addSubview(boardView)
        self.mainView = boardView
        
        let width = self.mainView.frame.width/CGFloat(colTotal)
        self.addPieceSet(rowTotal: rowTotal, colTotal: colTotal, width: width)
        
//        self.addBtnMove(toView: viewcontroller.view)
        self.addSolutionText(toView: viewcontroller.view)
        self.addSolutionFound(toView: viewcontroller.view)
//        self.addBtnNext(toView: viewcontroller.view)
        //        self.addBtnPrevious(toView: viewcontroller.view)
//        self.addReset(toView: viewcontroller.view)
//        self.btnPause(toView: viewcontroller.view)
        isPause = false
        btnPauseActionTmp.isHidden = true
        lblSolutionText.isHidden = false
        lblSolutionFound.isHidden = false
        //      self.addTextField(toView: viewcontroller.view)
        
    }
    
    
    
    func addSolutionText(toView view: UIView){
         lblSolutionText = UILabel(frame: CGRect(x: view.bounds.size.width/2-120, y: view.bounds.size.height / 2 + view.bounds.size.width/2, width: 120, height: 30))
        lblSolutionText.text = "Solution Found: "
        view.addSubview(lblSolutionText)
        
    }
    func addSolutionFound(toView view: UIView){
        lblSolutionFound = UILabel(frame: CGRect(x: view.bounds.size.width/2 + 20, y: view.bounds.size.height / 2 + view.bounds.size.width/2, width: 50, height: 30))
        lblSolutionFound.text = "0"
        view.addSubview(lblSolutionFound)
    }
    
       
    
    @objc func move(sender: UIButton)
    {
        
        btnNextTmp.isUserInteractionEnabled = false
        btnResetTmp.isUserInteractionEnabled = false
        btnStartTmp.isHidden = true
        btnPauseActionTmp.isHidden = false
        btnNextTmp.layer.backgroundColor = UIColor.gray.cgColor
        btnNextTmp.setNeedsDisplay()
        btnResetTmp.layer.backgroundColor = UIColor.gray.cgColor
        btnResetTmp.setNeedsDisplay()

        if isPause == true{
            pause = !pause
        }
        moveQueen()
        
        
        
        
    }

    @objc func reset(sender: UIButton){
        lblNoteStartTmp.isHidden = false
        textInPutBoard.isHidden = false
        btnSizeBoardTmp.isHidden = false
        lblSolutionText.isHidden = true
        lblSolutionFound.isHidden = true
        btnNextTmp.isUserInteractionEnabled = false
        btnPauseActionTmp.isUserInteractionEnabled = true
        btnPauseActionTmp.isHidden = true
        removeAllPieces()
        btnStartTmp.isHidden = false
        btnStartTmp.isUserInteractionEnabled = false
        btnResetTmp.layer.backgroundColor = LIME_COLOR.cgColor
        btnNextTmp.layer.backgroundColor = LIME_COLOR.cgColor
        btnStartTmp.layer.backgroundColor = LIME_COLOR.cgColor
        btnSizeBoardTmp.layer.backgroundColor = LIME_COLOR.cgColor
        btnSizeBoardTmp.setNeedsDisplay()
        btnResetTmp.setNeedsDisplay()
        btnNextTmp.setNeedsDisplay()
        btnStartTmp.setNeedsDisplay()
        boardView.removeFromSuperview()
        self.currentIndexQueen = 0
        self.rowSolution = 0
        self.colSolution = 0
        self.dem = 0
        if end == false {
        count = 1
        }
        self.lblSolutionFound.text = "0"
        end = false
        
    }
    
    
    
    @IBAction func action_Pause(_ sender: UIButton) {
        pause = !pause
        if count == 0{
            btnPauseActionTmp.setTitle("\u{f144}", for: .normal)
            btnResetTmp.isUserInteractionEnabled = true
            btnResetTmp.layer.backgroundColor = LIME_COLOR.cgColor
            btnResetTmp.setNeedsDisplay()
            count = 1
            isPause = true
        }else{
            btnPauseActionTmp.setTitle("\u{f04c}", for: .normal)
            btnResetTmp.layer.backgroundColor = UIColor.gray.cgColor
            btnResetTmp.setNeedsDisplay()
            btnResetTmp.isUserInteractionEnabled = false
            btnNextTmp.isUserInteractionEnabled = false
            count = 0
            isPause = false
        }
    }
    
    
    @objc func next(sender: UIButton){
        btnStartTmp.isUserInteractionEnabled = false
        btnStartTmp.layer.backgroundColor = UIColor.gray.cgColor
        btnStartTmp.setNeedsDisplay()
        
        nextAction()
    }
    
    
    
    //vong lap animation
    
    var currentIndexQueen = 0
    var rowSolution = 0
    var colSolution = 0
    var currentSolition = [QStep]()
    func removeAllPieces()
    {
        self.pieceSets.first?.removeAllPieceControllers()
    }
    func removeBacktrackedPieces(backtrackStep: QStep)
    {
        if(self.colSolution > 0)
        {
            self.pieceSets.first?.removeBacktrackedPieceControllers(backtrack: backtrackStep)
        }
    }
    func loop()
    {
        removeAllPieces()
        currentSolition = self.stepSolutions[self.rowSolution]
        autoAnimation()
    }
    
    func nextAction(){
        currentSolition = self.stepSolutions[self.rowSolution]
        nextAnimation()
        
    }
    
    func previousAction(){
        
        currentSolition = self.stepSolutions[self.rowSolution]
        previousAnimation()
    }
    
    func nextAnimation(){
        
        
        UIView.setAnimationsEnabled(true)
        UIView.animate(withDuration: 0.005, animations: {
            //Nếu bước đi mà là backtrack thì sẽ xoá các dòng và quay lại root của piece hiện tại
            if(self.currentSolition[self.colSolution].backtrack > 0)
            {
                self.removeBacktrackedPieces(backtrackStep: self.currentSolition[self.colSolution])
            }
            else
            {
                //Nếu vị trí đúng thì add piece
                if(self.currentSolition[self.colSolution].isTrue == true)
                {
                    self.pieceSets.first?.addnewQueenAt(position: Position(row: self.currentSolition[self.colSolution].position.row-1, col: self.currentSolition[self.colSolution].position.col-1), isTrue: true)
                }
                else
                {   //ngược lại add dấu X
                    self.pieceSets.first?.addnewQueenAt(position: Position(row: self.currentSolition[self.colSolution].position.row-1, col: self.currentSolition[self.colSolution].position.col-1), isTrue: false)
                }
            }
            
        }) { (finished) in
            //Kiem tra dau la buoc dung
            if(self.currentSolition[self.colSolution].position.row == self.rowTotal && self.currentSolition[self.colSolution].isTrue == true){
                self.dem = self.dem + 1
                self.lblSolutionFound.text = String(self.dem)
            }
            if (self.currentSolition[self.colSolution].position.row == 2 && self.currentSolition[self.colSolution].position.col == self.colTotal && self.currentSolition[self.colSolution].isTrue == false){
                
                btnNextTmp.isUserInteractionEnabled = false
                self.count = 0
            }
            
            self.colSolution = self.colSolution + 1
            
            // Neu col la dong cuoi thi solution do tang row len 1
            if (self.colSolution == self.currentSolition.count)
            {
                if(self.rowSolution == self.stepSolutions.count-1)
                {
                    return
                }
                self.colSolution = 0
                self.rowSolution = self.rowSolution + 1
                //              self.pieceSets.first?.savePreviousControllers()
            }
        }
    }
    func previousAnimation(){
        self.colSolution = self.colSolution - 1
        let checkBackTrackSolution = self.currentSolition[self.colSolution]
        
        if(checkBackTrackSolution.backtrack > 0){
            for index in 1 ... checkBackTrackSolution.backtrack {
                self.colSolution = self.colSolution - index*self.colTotal - 1
            }
        }
        
        UIView.setAnimationsEnabled(true)
        UIView.animate(withDuration: 0.005, animations: {
            
            let currentPiece = self.pieceSets.first?.getPieceControllerAt(position: Position(row: self.currentSolition[self.colSolution].position.row-1, col: self.currentSolition[self.colSolution].position.col-1))
            self.removeAllPieces()
            
            self.removeAllPieces()
            
            for i in (currentPiece?.pieceModel.prePiece.state)!
            {
                var isQueen: Bool!
                if i.type == .Queen{
                    isQueen = true
                }
                else if i.type == .None{
                    isQueen = false
                }
                self.pieceSets.first?.addnewQueenAt(position: i.position, isTrue: isQueen)
            }
            
            
        }) { (finished) in
            
            _ = self.pieceSets.first?.getPieceControllerAt(position: Position(row: self.currentSolition[self.colSolution].position.row-1, col: self.currentSolition[self.colSolution].position.col-1))
        }
    }
    
    func autoAnimation()
    {
        guard !pause else {
            return
        }
        
        UIView.setAnimationsEnabled(true)
        UIView.animate(withDuration: 0.3, animations: {
            //Nếu bước đi mà là backtrack thì sẽ xoá các dòng và quay lại root của piece hiện tại
            if(self.currentSolition[self.colSolution].backtrack > 0)
            {
                self.removeBacktrackedPieces(backtrackStep: self.currentSolition[self.colSolution])
            }
            else
            {
                //Nếu vị trí đúng thì add piece
                if(self.currentSolition[self.colSolution].isTrue == true)
                {
                    self.pieceSets.first?.addnewQueenAt(position: Position(row: self.currentSolition[self.colSolution].position.row-1, col: self.currentSolition[self.colSolution].position.col-1), isTrue: true)
                }
                else
                {   //ngược lại add dấu X
                    
                    self.pieceSets.first?.addnewQueenAt(position: Position(row: self.currentSolition[self.colSolution].position.row-1, col: self.currentSolition[self.colSolution].position.col-1), isTrue: false)
                }
            }
        }) { (finished) in
            //Kiem tra dau la buoc dung
            if(self.currentSolition[self.colSolution].position.row == self.rowTotal && self.currentSolition[self.colSolution].isTrue == true){
                self.dem = self.dem + 1
                self.lblSolutionFound.text = String(self.dem)
            }
            if ( (self.currentSolition[self.colSolution].position.row == 2 && self.currentSolition[self.colSolution].position.col == self.colTotal && self.currentSolition[self.colSolution].isTrue == false)){
                if self.colTotal == 4{
                btnNextTmp.isUserInteractionEnabled = false
                btnResetTmp.isUserInteractionEnabled = true
                btnPauseActionTmp.isUserInteractionEnabled = false
                btnResetTmp.layer.backgroundColor = LIME_COLOR.cgColor
                btnResetTmp.setNeedsDisplay()
                self.end = true
                }
            }
            
            
            //Khi kết thúc animation thì tăng col lên 1
            self.colSolution = self.colSolution + 1
            
            // Neu col la dong cuoi thi solution do tang row len 1
            
            if (self.colSolution == self.currentSolition.count)
            {
                if(self.rowSolution == self.stepSolutions.count-1)
                {
                    return
                }
                self.colSolution = 0
                self.rowSolution = self.rowSolution + 1
                self.loop()
                return
            }
            
            self.autoAnimation()
        }
    }
    func moveQueen(){
        loop()
        
    }
    func addTextField(toView view: UIView)
    {
        fromPosition = UITextField(frame: CGRect(x: 80, y: 50, width: 60, height: 30))
        fromPosition.backgroundColor = UIColor.gray
        fromPosition.textColor = UIColor.white
        fromPosition.placeholder = "row-col"
        
        toPosition = UITextField(frame: CGRect(x: 150, y: 50, width: 60, height: 30))
        toPosition.backgroundColor = UIColor.gray
        toPosition.textColor = UIColor.white
        toPosition.placeholder = "row-col"
        
        view.addSubview(fromPosition)
        view.addSubview(toPosition)
    }
    
    
    private func addPieceSet(rowTotal: Int, colTotal: Int, width: CGFloat)
    {
        nQueens = EightQueen(row: self.rowTotal, col: self.rowTotal)
        self.stepSolutions = nQueens.stepSolutions
        self.pieceSets = [PieceSet]()
        
        let whitePieceSet = PieceSet(color: .White,
                                     rowTotal: rowTotal,
                                     colTotal: colTotal,
                                     width: width)
        whitePieceSet.delegate = self
        //        whitePieceSet.addPieces()
        
        self.pieceSetOnTop = PieceColor.White
        
        self.pieceSets.append(whitePieceSet)
        //        self.pieceSets.append(blackPieceSet)
    }
    
    func addMove()
    {}
    func create()
    {}
    func isEnded()
    {}
    func isChecked()
    {}
    func operation()
    {}
    func isCheckMated()
    {}
    
}
extension GameManager: PieceSetDelegate
{
    func didRemovePieceController(pieceView: PieceView)
    {
        pieceView.removeFromSuperview()
    }
    func didFinishInitPieceSet(pieceControllers: [PieceController]) {
        for pieceController in pieceControllers
        {
            self.mainView.addSubview(pieceController.pieceView)
        }
    }
    func didFinishAddNewPiece(pieceController: PieceController){
        self.mainView.addSubview(pieceController.pieceView)
    }
}
