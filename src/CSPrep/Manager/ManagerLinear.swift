//
//  ManagerLinear.swift
//  Algorithms
//
//  Created by Loc Tran on 5/8/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
import UIKit

class ManagerLinear {
    
    var animate: AnimationLiear!
    var graph: GraphLinearBinary!
    var viewcontroller: UIViewController!
    var arrayLabel: [SortingLabel]!
    var arrayAction: [LinearStep]!
    var linear: LinearSearch!
    
    var textStudy: DetailTxtView!
    var dictData = NSDictionary()
    var arrayKey = [String]()
    var ele = 0
    var search: Int!
    
    func initLinear(viewcontroller: UIViewController, search: Int){
        
        
        graph = GraphLinearBinary(frame: CGRect(x: 32, y: (viewcontroller.navigationController?.navigationBar.frame.maxY)! + 20, width: viewcontroller.view.bounds.size.width - CGFloat(64), height: viewcontroller.view.bounds.size.width - CGFloat(64)))
        
        viewcontroller.view.addSubview(graph)
        
        self.search = search
        self.arrayAction = getAction(arr: graph.arrayFind)
        
        animate = AnimationLiear(arrayLabel: graph.arrayLabel, graph: graph, arrayAction: arrayAction)
        
        ele = 0
        for _ in arrayAction{
            ele = ele + 1
        }
        textStudy = DetailTxtView(frame: CGRect(x: graph.frame.origin.x,
                                                y: graph.frame.maxY + 20,
                                                width: graph.frame.width,
                                                height: yMax-(graph.frame.origin.y+graph.frame.height)),
                                  textContainer: nil)
        
        viewcontroller.view.addSubview(textStudy)
        
        textStudy.text = "Linear Search is an algorithm for searching through elements of an array."
        
        updateTextFont()
        var path: String = ""
        path = Bundle.main.path(forResource:"Linear", ofType: "plist")!
        dictData = NSDictionary(contentsOfFile: path)!
        arrayKey = dictData.allKeys as! [String]            
        ele = 0
        arrayKey = arrayKey.sorted()
        
        
        
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
    
    
    func getAction(arr: [Int]) -> [LinearStep] {
        linear = LinearSearch(arrayInput: arr, search: search)
        return linear.arrayAction
    }
    @objc func run(sender: UIButton){
        
        textStudy.text = "Search: \(String(search))"
        
        animate.loop()
        btnRunTmp.isUserInteractionEnabled = false
        btnStepTmp.isUserInteractionEnabled = false
        btnRunTmp.layer.backgroundColor = UIColor.gray.cgColor
        btnStepTmp.layer.backgroundColor = UIColor.gray.cgColor
        btnRunTmp.setNeedsDisplay()
        btnStepTmp.setNeedsDisplay()
    }
    @objc func step(sender: UIButton){
        textStudy.text = "Search: \(String(search)) \nWe compare \(String(search)) to each number in the list. This operation will repeat through the list until \(String(search)) is found."
        animate.next()
        btnRunTmp.isUserInteractionEnabled = false
        btnStepTmp.isUserInteractionEnabled = false
        btnRunTmp.layer.backgroundColor = UIColor.gray.cgColor
        btnRunTmp.setNeedsDisplay()
        btnStepTmp.setNeedsDisplay()
    }
    
}
