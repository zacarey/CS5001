//
//  AnimationMerge.swift
//  Algorithms
//
//  Created by Admin on 3/31/17.
//  Copyright © 2017 LocTran. All rights reserved.
//
import UIKit
class AnimationMerge:NSObject {
    
    var color: UIColor!
    var colors: [UIColor]!
    var arrayLabel: [SortingLabel]!
    var arrayLabelOne: [SortingLabel]!
    var arrayLabelTwo: [SortingLabel]!
    var arrayLabelThree: [SortingLabel]!
    var arrayLabelFour: [SortingLabel]!
    var arrayAction: [MergeStep]!
    var colSolution = 0
    var currentStep: MergeStep!
    var graphMerge: MergeGraph!
    var traceLevelTwo = 0
    var traceLevelThree = 0
    var traceLevelFour = 0
    var traceMergeOne = 0
    var traceMergeTwo = 0
    var traceMergeThree = 0
    var eleMerge = 1
    var _countStep = 0
    var finishAnimation = false
    var fistDraw = false
    var bodyRect: [UIView]?
    var bodyLine: [CALayer]?
    var _stepBackSplit:MergeStep!
    var dem = 1
    
    init(arrayLabel:[SortingLabel] , arrayLabelOne: [SortingLabel], arrayLabelTwo: [SortingLabel], arrayLabelThree: [SortingLabel],arrayLabelFour: [SortingLabel], arrayAction: [MergeStep],graphMerge: MergeGraph){
        
        self.arrayLabel = arrayLabel
        self.arrayLabelOne = arrayLabelOne
        self.arrayLabelTwo = arrayLabelTwo
        self.arrayLabelThree = arrayLabelThree
        self.arrayLabelFour = arrayLabelFour
        self.arrayAction = arrayAction
        self.graphMerge = graphMerge
        _ = 0
        
        bodyRect = [UIView]()
        bodyLine = [CALayer]()
        fistDraw = false // khoi tao cai nay de chi ve lan dau duong line
    }
    func animation(){
        UIView.animate(withDuration: 1, animations: {
            if(self.currentStep.act=="eleSplit"){
                switch self.currentStep.level{
                case 2: self.traceLevelTwo = self.currentStep.left.count - 1 // danh dau vi tri in ra
                // ve khung trai
                for tran in 0..<self.currentStep.left.count{
                    self.moveLabel(from: self.arrayLabel[self.currentStep.left[tran]], to: self.arrayLabelTwo[self.currentStep.left[tran]])
                }
                self.borderRect(bearingPoint: (self.arrayLabel.first?.frame.origin)!, countCell: self.currentStep.left.count)
                // ve khung phai
                self.traceLevelTwo = self.traceLevelTwo + 1
                for tran in 0..<self.currentStep.right.count{
                    self.moveLabel(from: self.arrayLabel[self.currentStep.right[tran]], to: self.arrayLabelTwo[self.currentStep.right[tran]])
                }
                self.borderRect(bearingPoint: self.arrayLabel[self.traceLevelTwo].frame.origin, countCell: self.currentStep.right.count)
                case 3:
                    // ve khung trai
                    for tran in 0..<self.currentStep.left.count{
                        self.moveLabel(from: self.arrayLabel[self.currentStep.left[tran]], to: self.arrayLabelThree[self.currentStep.left[tran]])
                    }
                    self.borderRect(bearingPoint: (self.arrayLabel[self.traceLevelThree].frame.origin), countCell: self.currentStep.left.count)
                    // ve khung phai
                    self.traceLevelThree = self.traceLevelThree + self.currentStep.left.count
                    for tran in 0..<self.currentStep.right.count{
                        self.moveLabel(from: self.arrayLabel[self.currentStep.right[tran]], to: self.arrayLabelThree[self.currentStep.right[tran]])
                    }
                    self.borderRect(bearingPoint: (self.arrayLabel[self.traceLevelThree].frame.origin), countCell: self.currentStep.right.count)
                    // cong them do dai left ben trai de cho doi xung
                    
                    self.traceLevelThree = self.traceLevelThree + self.currentStep.right.count
                case 4:
                    // ve khung trai
                    for tran in 0..<self.currentStep.left.count{
                        self.moveLabel(from: self.arrayLabel[self.currentStep.left[tran]], to: self.arrayLabelFour[self.currentStep.left[tran]])
                    }
                    self.borderRect(bearingPoint: (self.arrayLabel[self.currentStep.left[0]].frame.origin), countCell: self.currentStep.left.count)
                    // ve khung phai
                    self.traceLevelFour = self.traceLevelFour + self.currentStep.left.count
                    for tran in 0..<self.currentStep.right.count{
                        self.moveLabel(from: self.arrayLabel[self.currentStep.right[tran]], to: self.arrayLabelFour[self.currentStep.right[tran]])
                    }
                    self.borderRect(bearingPoint: (self.arrayLabel[self.currentStep.right[0]].frame.origin), countCell: self.currentStep.right.count)
                    self.traceLevelFour = self.traceLevelFour + self.currentStep.right.count
                default: break
                }
            }
            else{
                switch self.currentStep.level{
                case 1:
                    self._countStep = 0
                    self.moveLabel(from: self.arrayLabel[self.currentStep.merge[0]], to: self.arrayLabelOne[self.traceMergeOne])
                    self.traceMergeOne = self.traceMergeOne + 1
                case 2:
                    self._countStep=0
                    self.moveLabel(from: self.arrayLabel[self.currentStep.merge[0]], to: self.arrayLabelTwo[self.traceMergeTwo])
                    self.traceMergeTwo = self.traceMergeTwo + 1
                case 3:
                    self._countStep=0
                    let eleMerge = self.currentStep.merge[0]
                    self._stepBackSplit = self.arrayAction[self.currentStep.stepSplit]
                    self.moveLabel(from: self.arrayLabel[eleMerge], to: self.arrayLabelThree[self._stepBackSplit.merge[self._countStep]])
                    // thuc hien ve label xong dung traceMergeThree de danh dau vi tri ve label tiep theo
                    self.traceMergeThree = self.traceMergeThree + 1
                default: break
                }
            }
        }){_ in
            if(self.currentStep.act=="eleMerge"){
                
                switch self.currentStep.level{
                case 1:
                    self._countStep = 1
                    self.animationMergetoLevel(_countStep: self._countStep, from: self.arrayLabel[self.currentStep.merge[self._countStep]], to: self.arrayLabelOne[self.traceMergeOne])
                case 2:
                    self._countStep = 1
                    self.animationMergetoLevel(_countStep: self._countStep, from: self.arrayLabel[self.currentStep.merge[self._countStep]], to: self.arrayLabelTwo[self.traceMergeTwo])
                case 3:
                    self._countStep = 1
                    self.animationMergetoLevel(_countStep: self._countStep, from: self.arrayLabel[self.currentStep.merge[self._countStep]], to: self.arrayLabelThree[self._stepBackSplit.merge[self._countStep]])
                default: break
                }
            }else{
                self.continueAnimation()
            }
        }
    }
    
    func animationStep(){
        UIView.animate(withDuration: 1, animations: {
            if(self.currentStep.act=="eleSplit"){
                switch self.currentStep.level{
                case 2: self.traceLevelTwo = self.currentStep.left.count - 1 // danh dau vi tri in ra
                // ve khung trai
                for tran in 0..<self.currentStep.left.count{
                    self.moveLabel(from: self.arrayLabel[self.currentStep.left[tran]], to: self.arrayLabelTwo[self.currentStep.left[tran]])
                }
                self.borderRect(bearingPoint: (self.arrayLabel.first?.frame.origin)!, countCell: self.currentStep.left.count)
                // ve khung phai
                self.traceLevelTwo = self.traceLevelTwo + 1
                for tran in 0..<self.currentStep.right.count{
                    self.moveLabel(from: self.arrayLabel[self.currentStep.right[tran]], to: self.arrayLabelTwo[self.currentStep.right[tran]])
                }
                self.borderRect(bearingPoint: self.arrayLabel[self.traceLevelTwo].frame.origin, countCell: self.currentStep.right.count)
                case 3:
                    // ve khung trai
                    for tran in 0..<self.currentStep.left.count{
                        self.moveLabel(from: self.arrayLabel[self.currentStep.left[tran]], to: self.arrayLabelThree[self.currentStep.left[tran]])
                    }
                    self.borderRect(bearingPoint: (self.arrayLabel[self.traceLevelThree].frame.origin), countCell: self.currentStep.left.count)
                    // ve khung phai
                    self.traceLevelThree = self.traceLevelThree + self.currentStep.left.count
                    for tran in 0..<self.currentStep.right.count{
                        self.moveLabel(from: self.arrayLabel[self.currentStep.right[tran]], to: self.arrayLabelThree[self.currentStep.right[tran]])
                    }
                    self.borderRect(bearingPoint: (self.arrayLabel[self.traceLevelThree].frame.origin), countCell: self.currentStep.right.count)
                    // cong them do dai left ben trai de cho doi xung
                    
                    self.traceLevelThree = self.traceLevelThree + self.currentStep.right.count
                case 4:
                    // ve khung trai
                    for tran in 0..<self.currentStep.left.count{
                        self.moveLabel(from: self.arrayLabel[self.currentStep.left[tran]], to: self.arrayLabelFour[self.currentStep.left[tran]])
                    }
                    self.borderRect(bearingPoint: (self.arrayLabel[self.currentStep.left[0]].frame.origin), countCell: self.currentStep.left.count)
                    // ve khung phai
                    self.traceLevelFour = self.traceLevelFour + self.currentStep.left.count
                    for tran in 0..<self.currentStep.right.count{
                        self.moveLabel(from: self.arrayLabel[self.currentStep.right[tran]], to: self.arrayLabelFour[self.currentStep.right[tran]])
                    }
                    self.borderRect(bearingPoint: (self.arrayLabel[self.currentStep.right[0]].frame.origin), countCell: self.currentStep.right.count)
                    self.traceLevelFour = self.traceLevelFour + self.currentStep.right.count
                default: break
                }
            }
            else{
                switch self.currentStep.level{
                case 1:
                    self._countStep = 0
                    self.moveLabel(from: self.arrayLabel[self.currentStep.merge[0]], to: self.arrayLabelOne[self.traceMergeOne])
                    self.traceMergeOne = self.traceMergeOne + 1
                case 2:
                    self._countStep=0
                    self.moveLabel(from: self.arrayLabel[self.currentStep.merge[0]], to: self.arrayLabelTwo[self.traceMergeTwo])
                    self.traceMergeTwo = self.traceMergeTwo + 1
                case 3:
                    self._countStep=0
                    let eleMerge = self.currentStep.merge[0]
                    self._stepBackSplit = self.arrayAction[self.currentStep.stepSplit]
                    self.moveLabel(from: self.arrayLabel[eleMerge], to: self.arrayLabelThree[self._stepBackSplit.merge[self._countStep]])
                    // thuc hien ve label xong dung traceMergeThree de danh dau vi tri ve label tiep theo
                    self.traceMergeThree = self.traceMergeThree + 1
                default: break
                }
            }
        }){_ in
            if(self.currentStep.act=="eleMerge"){
                
                switch self.currentStep.level{
                case 1:
                    self._countStep = 1
                    self.animationMergetoLevelStep(_countStep: self._countStep, from: self.arrayLabel[self.currentStep.merge[self._countStep]], to: self.arrayLabelOne[self.traceMergeOne])
                case 2:
                    self._countStep = 1
                    self.animationMergetoLevelStep(_countStep: self._countStep, from: self.arrayLabel[self.currentStep.merge[self._countStep]], to: self.arrayLabelTwo[self.traceMergeTwo])
                case 3:
                    self._countStep = 1
                    self.animationMergetoLevelStep(_countStep: self._countStep, from: self.arrayLabel[self.currentStep.merge[self._countStep]], to: self.arrayLabelThree[self._stepBackSplit.merge[self._countStep]])
                default: break
                }
            }else{
                self.continueAnimationStep()
            }
        }
    }
    
    
    func animationMergetoLevel(_countStep: Int,from: SortingLabel,to: SortingLabel){
        UIView.animate(withDuration: 1, animations: {
            self.moveLabel(from: from, to: to)
        }){_ in
            var _tranSortingLabel = UILabel()
            switch self.currentStep.level{
            case 1:
                self.traceMergeOne = self.traceMergeOne + 1
                // co dieu kien nay do thang traceMergeOne co the bi ra ngoai truoc khi co dieu kien kiem tra _countSTep
                if(self.traceMergeOne<self.arrayLabel.count){
                    _tranSortingLabel = self.arrayLabelOne[self.traceMergeOne]
                }
            case 2:
                self.traceMergeTwo  = self.traceMergeTwo + 1
                if(self.traceMergeTwo<self.arrayLabel.count){
                    _tranSortingLabel = self.arrayLabelTwo[self.traceMergeTwo]
                }
                break
            case 3:
                self.traceMergeThree = self.traceMergeThree + 1
                if(self.traceMergeThree<self.arrayLabel.count){
                    _tranSortingLabel = self.arrayLabelThree[self.traceMergeThree]
                }
            default:break
            }
            
            if(_countStep==self.currentStep.merge.count-1){
                self.continueAnimation()
                return
            }
            self._countStep+=1
            self.animationMergetoLevel(_countStep: _countStep+1, from: self.arrayLabel[self.currentStep.merge[_countStep+1]], to:_tranSortingLabel as! SortingLabel)
        }
    }
    
    func animationMergetoLevelStep(_countStep: Int,from: SortingLabel,to: SortingLabel){
        UIView.animate(withDuration: 1, animations: {
            self.moveLabel(from: from, to: to)
        }){_ in
            var _tranSortingLabel = UILabel()
            switch self.currentStep.level{
            case 1:
                self.traceMergeOne = self.traceMergeOne + 1
                // co dieu kien nay do thang traceMergeOne co the bi ra ngoai truoc khi co dieu kien kiem tra _countSTep
                if(self.traceMergeOne<self.arrayLabel.count){
                    _tranSortingLabel = self.arrayLabelOne[self.traceMergeOne]
                }
            case 2:
                self.traceMergeTwo  = self.traceMergeTwo + 1
                if(self.traceMergeTwo<self.arrayLabel.count){
                    _tranSortingLabel = self.arrayLabelTwo[self.traceMergeTwo]
                }
                break
            case 3:
                self.traceMergeThree = self.traceMergeThree + 1
                if(self.traceMergeThree<self.arrayLabel.count){
                    _tranSortingLabel = self.arrayLabelThree[self.traceMergeThree]
                }
            default:break
            }
            
            if(_countStep==self.currentStep.merge.count-1){
                self.continueAnimationStep()
                return
            }
            self._countStep+=1
            self.animationMergetoLevelStep(_countStep: _countStep+1, from: self.arrayLabel[self.currentStep.merge[_countStep+1]], to:_tranSortingLabel as! SortingLabel)
        }
    }
    
    
    func loop(){
        self.currentStep = self.arrayAction[self.colSolution]
        self.borderRect(bearingPoint: (self.arrayLabelOne.first?.frame.origin)!, countCell: self.arrayLabel.count)
        self.animation()
    }
    
    func next(){
        self.currentStep = self.arrayAction[self.colSolution]
        if(!fistDraw){

            self.borderRect(bearingPoint: (self.arrayLabelOne.first?.frame.origin)!, countCell: self.arrayLabel.count)
        }
        self.animationStep()
    }
    
    func swapLabel(i: Int, j: Int) {
        let temp = arrayLabel[i]
        arrayLabel[i] = arrayLabel[j]
        arrayLabel[j] = temp
    }
    func moveLabel(from: SortingLabel, to: SortingLabel) {
        from.center = to.center
    }
    
    func continueAnimation(){
        self.colSolution += 1
        if (self.colSolution == self.arrayAction.count) {
            deleteBody()
            return
        }
        self.currentStep = self.arrayAction[self.colSolution]
        self.animation()
    }
    
    func continueAnimationStep(){
        self.colSolution += 1
        if (self.colSolution == self.arrayAction.count) {
            deleteBody()
            btnStepTmp.isUserInteractionEnabled = false

            return
        }else{
            btnStepTmp.isUserInteractionEnabled = true
        }
        self.currentStep = self.arrayAction[self.colSolution]
    }
    
    func deleteBody(){
        for del in self.bodyLine!{
            del.removeFromSuperlayer()
        }
        for del in self.bodyRect!{
            del.removeFromSuperview()
        }
    }
    func borderRect(bearingPoint: CGPoint, countCell: Int){

        let originPoint = CGPoint(x: bearingPoint.x - PADDING/2, y: bearingPoint.y - PADDING/2)
        let widthRect: CGFloat = CGFloat(countCell)*2*SPACING + CGFloat((countCell-1))*SPACING + 2*PADDING/2
        let heightRect : CGFloat = 2*SPACING + 1*PADDING
        let drect = CGRect(origin: originPoint, size: CGSize(width: widthRect, height: heightRect))
        let Slayer = CAShapeLayer()
        Slayer.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: widthRect, height: heightRect)).cgPath
        Slayer.fillColor = UIColor.white.cgColor
        Slayer.strokeColor = GRAY_COLOR.cgColor
        Slayer.lineWidth = 4
        let view = UIView(frame: drect)
        view.layer.addSublayer(Slayer)

        self.graphMerge.insertSubview(view, at: 1)
        self.bodyRect?.append(view)

        if(fistDraw){
            self.bodyLine?.append(straightLine(bearingPoint: originPoint, widtRectangle: widthRect))
        }
        fistDraw = true
    }
    
    func straightLine(bearingPoint: CGPoint,widtRectangle: CGFloat)->CAShapeLayer{

        dem+=1
        DISTANCEROW = SPACING - PADDING
        let start = CGPoint(x: bearingPoint.x + widtRectangle/2, y: bearingPoint.y)
        let end = CGPoint(x: start.x, y: start.y-DISTANCEROW)
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)
        line.path = linePath.cgPath
        line.strokeColor = GRAY_COLOR.cgColor
        line.lineWidth = 4
        self.graphMerge.layer.insertSublayer(line, at: 10)
        return line
    }
}
