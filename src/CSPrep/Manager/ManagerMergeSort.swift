//
//  ManagerSort.swift
//  Algorithms
//
//  Created by Loc Tran on 3/22/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
import UIKit

class ManagerMergeSort {
    var animationStep: AnimationMerge!
    var animate: AnimationMerge!
    var viewcontroller: UIViewController!
    
    var arrayInput: [Int]!
    var arrayAction: [MergeStep]!
    var arrayDisplay: [Int]!
    var arrayColor: [UIColor]!
    
    var arrayLabel: [SortingLabel]!
    var arrayLabelOne: [SortingLabel]!
    var arrayLabelTwo: [SortingLabel]!
    var arrayLabelThree: [SortingLabel]!
    var arrayLabelFour: [SortingLabel]!
    
    var graph: MergeGraph!
    var sort: MergeSort!
    
    var ptu:Int!
    
    var textStudy: DetailTxtView!
    var dictData = NSDictionary()
    var arrayKeys = [String]()
    var ele: Int!
    
    
    func initSortWith(viewcontroller: UIViewController, arrayInput: [Int]) {
        
        self.viewcontroller = viewcontroller
        
        self.arrayInput = arrayInput
        self.arrayAction = getArrayAction(array: arrayInput)
        
        self.arrayDisplay = []
        self.arrayLabelOne = []
        self.arrayLabelTwo = []
        self.arrayLabelThree = []
        self.arrayLabelFour = []
        
        self.arrayColor = []
        if arrayInput.count%2 != 0  {
            ptu = arrayInput.count + 1
            
        }
        //hgjhg
        for index in 0..<self.arrayInput.count {
            self.arrayDisplay.append(arrayInput[index])
            self.arrayColor.append(DEFAULT_COLOR)
        }
        
        graph = MergeGraph(frame: CGRect(x: 0,
                                         y:(viewcontroller.navigationController?.navigationBar.frame.maxY)! + 20,
                                         width: viewcontroller.view.bounds.size.width,
                                         height: viewcontroller.view.bounds.size.height/2),
                           arrayDisplay: self.arrayDisplay,
                           colors: self.arrayColor)
        
        
        
        viewcontroller.view.addSubview(graph)
        
        
        self.arrayLabel = self.graph.arrayLabel
        self.arrayLabelOne = self.graph.arrayLabelOne
        self.arrayLabelTwo = self.graph.arrayLabelTwo
        self.arrayLabelThree = self.graph.arrayLabelThree
        self.arrayLabelFour = self.graph.arrayLabelFour
        
        animationStep = AnimationMerge(arrayLabel: self.arrayLabel, arrayLabelOne: self.arrayLabelOne, arrayLabelTwo: self.arrayLabelTwo, arrayLabelThree: self.arrayLabelThree, arrayLabelFour: self.arrayLabelFour, arrayAction: self.arrayAction, graphMerge: graph)
        
        ele = 0
        for _ in arrayAction{
            ele = ele + 1
        }
        textStudy = DetailTxtView(frame: CGRect(x: graph.frame.origin.x + 20,
                                                y: graph.frame.maxY + 20,
                                                width: graph.frame.width - 40,
                                                height: yMax-(graph.frame.origin.y+graph.frame.height)),
                                  textContainer: nil)
        
        viewcontroller.view.addSubview(textStudy)
        
        textStudy.text = "Merge Sort is a Divide and Conquer algorithm. It divides input array in two halves, calls itself for the two halves and then merges the two sorted halves."
        updateTextFont()
        
        var path: String = ""
        path = Bundle.main.path(forResource:"MergeSort", ofType: "plist")!
        dictData = NSDictionary(contentsOfFile: path)!
        arrayKeys = dictData.allKeys as! [String]
        ele = 0
        arrayKeys = arrayKeys.sorted()
        
        
    }
    
    func getArrayAction(array: [Int]) -> [MergeStep] {
        
        sort = MergeSort(arrayInput: array)
        return sort.arrayElement
        
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
        
        animate = AnimationMerge(arrayLabel: self.arrayLabel, arrayLabelOne: self.arrayLabelOne, arrayLabelTwo: self.arrayLabelTwo, arrayLabelThree: self.arrayLabelThree, arrayLabelFour: self.arrayLabelFour, arrayAction: self.arrayAction, graphMerge: graph)
        btnRunTmp.isUserInteractionEnabled = false
        btnStepTmp.isUserInteractionEnabled = false
        
        animate.loop()
        
    }
    @objc func step(sender: UIButton) {
        
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
            textStudy.text = "The list is fully sorted."
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
        
        
    }
}
