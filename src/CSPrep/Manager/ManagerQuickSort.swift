//
//  ManagerQuickSort.swift
//  Algorithms
//
//  Created by Loc Tran on 3/22/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
import UIKit

class ManagerQuickSort{
    var animationStep: AnimationQuick!
    var animate: AnimationQuick!
    var viewcontroller: UIViewController!
    
    var arrayInput: [Int]!
    var arrayAction: [QuickStep]!
    var arrayDisplay: [Int]!
    var arrayColor: [UIColor]!
    
    var arrayLabel: [SortingLabel]!
    var arrayLabelAbove: [SortingLabel]!
    var arrayLabelMiddle: [SortingLabel]!
    var arrayLabelMark: [SortingLabel]!
    
    var graph: Graph!
    var sort: QuickSort!
    var quickGraph: QuickGraph!
    
    var textStudy: DetailTxtView!
    var dictData = NSDictionary()
    var arrayKeys = [String]()
    var ele: Int!

    
    
    func initSortWith(viewcontroller: UIViewController, arrayInput: [Int]) {
        
        self.viewcontroller = viewcontroller
        
        self.arrayInput = arrayInput
        self.arrayAction = getArrayAction(array: arrayInput)
        
        
        self.arrayDisplay = []
        self.arrayLabelAbove = []
        self.arrayLabelMiddle = []
        self.arrayLabelMark = []
        
        self.arrayColor = []
        
        for index in 0..<arrayInput.count {
            self.arrayDisplay.append(arrayInput[index])
            self.arrayColor.append(DEFAULT_COLOR)
        }
        
        let spacing = 20
        
        quickGraph = QuickGraph(frame: CGRect(x: 0,
                                              y:(viewcontroller.navigationController?.navigationBar.frame.height)! + CGFloat(spacing) * 10
            ,
                                              width: viewcontroller.view.bounds.size.width,
                                              height: viewcontroller.view.bounds.size.height*0.25),
                                arrayDisplay: self.arrayDisplay,
                                colors: self.arrayColor)

        viewcontroller.view.addSubview(quickGraph)
        
        
        self.arrayLabel = self.quickGraph.arrayLabel
        self.arrayLabelMiddle = self.quickGraph.arrayLabelMiddle
        self.arrayLabelMark = self.quickGraph.arrayLabelMark
        self.arrayLabelAbove = self.quickGraph.arrayLabelAbove
        
        animationStep = AnimationQuick(arrayLabel: self.arrayLabel, arrayLabelMiddle: self.arrayLabelMiddle, arrayLabelAbove: self.arrayLabelAbove, arrayLabelMark: self.arrayLabelMark, arrayAction: self.arrayAction, graph: self.quickGraph)
//        if(VIEW_CHOSEN=="study"){
            ele = 0
            for _ in arrayAction{
                ele = ele + 1
            }
            textStudy = DetailTxtView(frame: CGRect(x: quickGraph.frame.origin.x + 20,
                                                y: quickGraph.frame.maxY + 20,
                                                width: quickGraph.frame.width - 40 ,
                                                height: yMax-(quickGraph.frame.origin.y+quickGraph.frame.height)),
                                      textContainer: nil)
            
            viewcontroller.view.addSubview(textStudy)
        
            textStudy.text = "Quicksort is a popular sorting algorithm that is often faster in practice compared to other sorting algorithms. It utilizes a divide-and-conquer strategy to quickly sort data items by dividing a large array into two smaller arrays."
            
            updateTextFont()
            var path: String = ""
            path = Bundle.main.path(forResource:"QuickSort", ofType: "plist")!
            dictData = NSDictionary(contentsOfFile: path)!
            arrayKeys = dictData.allKeys as! [String]
            ele = 0
            arrayKeys = arrayKeys.sorted()
//        }
        
    }

    
    func getArrayAction(array: [Int]) -> [QuickStep] {
        
        sort = QuickSort(arrayInput: array)
        
        return sort.actionArray
        
        
    }
    
    func updateTextFont() {
        if (textStudy.text.isEmpty || textStudy.bounds.size.equalTo(CGSize.zero)) {
            return;
        }
        
        let textViewSize = textStudy.frame.size;
        let fixedWidth = textViewSize.width;
        let expectSize = textStudy.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT)))
        
        var expectFont = textStudy.font
        if (expectSize.height > textViewSize.height) {
            while (textStudy.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT))).height > textViewSize.height) {
                expectFont = textStudy.font!.withSize(textStudy.font!.pointSize - 1)
                textStudy.font = expectFont
            }
        }
        else {
            return
        }
    }
    
    @objc func run(sender: UIButton) {
        
        animate = AnimationQuick(arrayLabel: self.arrayLabel, arrayLabelMiddle: self.arrayLabelMiddle, arrayLabelAbove: self.arrayLabelAbove, arrayLabelMark: self.arrayLabelMark, arrayAction: self.arrayAction, graph: self.quickGraph)
        btnRunTmp.isUserInteractionEnabled = false
        btnStepTmp.isUserInteractionEnabled = false
        
        animate.loop()

        
    }
    
    @objc func step(sender: UIButton) {
        
//        if(VIEW_CHOSEN=="study"){
            if(ele==arrayKeys.count){
                textStudy.text = ""
                updateTextFont()
                return
            }
            btnRunTmp.isUserInteractionEnabled = false
            btnRunTmp.layer.backgroundColor = UIColor.gray.cgColor
            btnRunTmp.setNeedsDisplay()
            
            if(arrayKeys[ele].isNumber){
                btnStepTmp.isUserInteractionEnabled = false
                let data = dictData[arrayKeys[ele]]
                textStudy.text = data as! String?
                updateTextFont()
                animationStep.next()
            }else if(arrayKeys[ele]=="end"){
                textStudy.text = "The list is fully sorted"
                updateTextFont()
                btnStepTmp.layer.backgroundColor = UIColor.gray.cgColor
                btnStepTmp.setNeedsDisplay()
                btnStepTmp.isUserInteractionEnabled = false
                
            }else{
                let data = dictData[arrayKeys[ele]]
                textStudy.text = data as! String?
                updateTextFont()
                btnStepTmp.isUserInteractionEnabled = true
                
            }
            ele = ele + 1
            
//        }else{
//            btnStepTmp.isUserInteractionEnabled = false
//            btnRunTmp.isUserInteractionEnabled = false
//            animationStep.next()
//        }
    }
    
}
