//
//  ManagerHeapSort.swift
//  Algorithms
//
//  Created by Loc Tran on 4/6/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
import UIKit

class ManagerHeapSort {
    var animationStep: AnimationHeap!
    var animate: AnimationHeap!
    var viewcontroller: UIViewController!
    
    var arrayInput: [Int]!
    var arrayAction: [HeapStep]!
    var arrayDisplay: [Int]!
    var arrayColor: [UIColor]!
    
    var arrayLabel: [SortingLabel]!
    var arrayLabelBehind: [SortingLabel]!
    var arrayPosition: [SortingLabel]!
    
    var graph: HeapGraph!
    var sort: HeapSort!
    
    var textStudy: DetailTxtView!
    var dictData = NSDictionary()
    var arrayKeys = [String]()
    var ele: Int!
    
    
    func initSortWith(viewcontroller: UIViewController, arrayInput: [Int]) {
        
        self.viewcontroller = viewcontroller
        
        self.arrayInput = arrayInput
        self.arrayAction = getArrayAction(array: arrayInput)
        
        self.arrayDisplay = []
        self.arrayLabelBehind = []
        
        self.arrayColor = []
        
        for index in 0..<self.arrayInput.count {
            self.arrayDisplay.append(arrayInput[index])
            self.arrayColor.append(DEFAULT_COLOR)
        }
        
        graph = HeapGraph(frame: CGRect(x: 0,
                                        y:(viewcontroller.navigationController?.navigationBar.frame.maxY)! + 20,
                                        width: viewcontroller.view.bounds.size.width,
                                        height: viewcontroller.view.bounds.size.height/2),
                          arrayDisplay: self.arrayDisplay,
                          colors: self.arrayColor)
        
        viewcontroller.view.addSubview(graph)
        
        
        self.arrayLabel = self.graph.arrayLabel
        self.arrayLabelBehind = self.graph.arrayLabelBehind
        self.arrayPosition = self.graph.arrayPosition
        
        animationStep = AnimationHeap(arrayLabel: self.arrayLabel,  arrayLabelBehind: self.arrayLabelBehind, arrayPosition: self.arrayPosition, arrayAction: self.arrayAction, graphHeap: graph)
        
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
        
        textStudy.text = "Heapsort divides its input into a sorted and an unsorted region, and it iteratively shrinks the unsorted region by extracting the largest element and moving that to the sorted region."
        updateTextFont()
        var path: String = ""
        path = Bundle.main.path(forResource:"HeapSort", ofType: "plist")!
        dictData = NSDictionary(contentsOfFile: path)!
        arrayKeys = dictData.allKeys as! [String]
        ele = 0
        arrayKeys = arrayKeys.sorted()
        
    }
    
    func getArrayAction(array: [Int]) -> [HeapStep] {
        
        sort = HeapSort(arrayInput: array)
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
        
        animate = AnimationHeap(arrayLabel: self.arrayLabel,  arrayLabelBehind: self.arrayLabelBehind, arrayPosition: self.arrayPosition, arrayAction: self.arrayAction, graphHeap: graph)
        
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
