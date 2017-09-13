//
//  ManagerSort.swift
//  Algorithms
//
//  Created by Loc Tran on 3/22/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
import UIKit



class ManagerBubbleSort {
    
    
    var animate: AnimationBubble!
    var animateStep: AnimationBubble!
    var animateBack: AnimationBubble!
    var viewcontroller: UIViewController!
    
    var arrayInput: [Int]!
    var arrayAction: [Step]!
    var arrayDisplay: [Int]!
    var arrayColor: [UIColor]!
    
    var arrayLabel: [SortingLabel]!
    var arrayLabelAbove: [SortingLabel]!
    var arrayLabelMiddle: [SortingLabel]!
    var arrayLabelBelow: [SortingLabel]!
    
    var graph: Graph!
    var sort: BubbleSort!
    
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
        self.arrayLabelBelow = []
        self.arrayColor = []
        
        for index in 0..<arrayInput.count {
            self.arrayDisplay.append(arrayInput[index])
            self.arrayColor.append(DEFAULT_COLOR)
        }
        
        
        
        graph = Graph(frame: CGRect(x: 0,
                                    y:(viewcontroller.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height * 2,
                                    width: viewcontroller.view.bounds.size.width,
                                    height: viewcontroller.view.bounds.size.height/2),
                      arrayDisplay: self.arrayDisplay,
                      colors: self.arrayColor)
        
        
        viewcontroller.view.addSubview(graph)
        
        self.arrayLabel = self.graph.arrayLabel
        self.arrayLabelMiddle = self.graph.arrayLabelMiddle
        self.arrayLabelBelow = self.graph.arrayLabelBelow
        self.arrayLabelAbove = self.graph.arrayLabelAbove
        
        animateStep = AnimationBubble(arrayLabel: self.arrayLabel, arrayLabelMiddle: self.arrayLabelMiddle, arrayLabelAbove: self.arrayLabelAbove, arrayLabelBelow: self.arrayLabelBelow, arrayAction: self.arrayAction)
        
        if(VIEW_CHOSEN=="study"){
            ele = 0
            
            textStudy = DetailTxtView(frame: CGRect(x: graph.frame.origin.x + UIApplication.shared.statusBarFrame.height,
                                                        y: graph.frame.origin.y+graph.frame.height,
                                                        width: graph.frame.width - 2*UIApplication.shared.statusBarFrame.height ,
                                                        height: yMax-(graph.frame.origin.y+graph.frame.height)), textContainer: nil)
            
            viewcontroller.view.addSubview(textStudy)
            
            textStudy.text = "Bubble sort is a simple sorting algorithm that repeatedly steps through the list to be sorted, compares each pair of adjacent items and swaps them if they are in the wrong order."

            var path: String = ""
            
            path = Bundle.main.path(forResource:"BubbleSort", ofType: "plist")!
            dictData = NSDictionary(contentsOfFile: path)!
            arrayKeys = dictData.allKeys as! [String]

            ele = 0
            arrayKeys = arrayKeys.sorted(by: {$0 < $1})
        }
        
        
    }
    
    func getArrayAction(array: [Int]) -> [Step] {
        
        sort = BubbleSort(arrayInput: array)
        return sort.arrayAction
        
    }
    
    @objc func run(sender: UIButton) {
        
        
        animate = AnimationBubble(arrayLabel: self.arrayLabel, arrayLabelMiddle: self.arrayLabelMiddle, arrayLabelAbove: self.arrayLabelAbove, arrayLabelBelow: self.arrayLabelBelow, arrayAction: self.arrayAction)
        
        
        btnRunTmp.isUserInteractionEnabled = false
        btnStepTmp.isUserInteractionEnabled = false
        
        animate.loop()
    }
    
    @objc func step(sender: UIButton) {
        
        if(VIEW_CHOSEN=="study"){
            if(ele==arrayKeys.count){
                textStudy.text = ""
                return
            }
            btnRunTmp.isUserInteractionEnabled = false
            btnRunTmp.layer.backgroundColor = UIColor.gray.cgColor
            btnRunTmp.setNeedsDisplay()
            
            if(arrayKeys[ele].isNumber){
                btnStepTmp.isUserInteractionEnabled = false
                let data = dictData[arrayKeys[ele]]
                textStudy.text = data as! String?
                
                animateStep.next()
            }else if(arrayKeys[ele]=="end"){
                textStudy.text = "The list is fully sorted"
                btnStepTmp.layer.backgroundColor = UIColor.gray.cgColor
                btnStepTmp.setNeedsDisplay()
                btnStepTmp.isUserInteractionEnabled = false
                
            }else{
                let data = dictData[arrayKeys[ele]]
                textStudy.text = data as! String?
                                
                btnStepTmp.isUserInteractionEnabled = true
                
            }
            ele = ele + 1
            
        }else{
            btnStepTmp.isUserInteractionEnabled = false
            btnRunTmp.isUserInteractionEnabled = false
            animateStep.next()
        }
        
        
        
    }
        
}

extension String {
    var isNumber:Bool{
        get{
            return !self.isEmpty && self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil

        }
    }
    struct NumberFormat {
        static let instance = NumberFormatter()
    }
    var floatValue:Float? {

        return NumberFormat.instance.number(from: self)?.floatValue
    }
    var integerValue:Int? {
        return NumberFormat.instance.number(from: self)?.intValue
    }

}
