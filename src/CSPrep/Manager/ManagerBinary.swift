//
//  ManagerBinary.swift
//  Algorithms
//
//  Created by Loc Tran on 5/11/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
import UIKit


class ManagerBinary{
    
    var viewcontroller: UIViewController!
    var graph: GraphLinearBinary!
    var arrayLabel: [SortingLabel]!
    var animate: AnimarionBinary!
    var arrayAction: [BinaryStep]!
    var binary: BinarySearch!
    
    var textStudy: DetailTxtView!
    var dictData = NSDictionary()
    var arayKey = [String]()
    var ele = 0
    var search: Int!
    
    func initBinary(viewcontroller: UIViewController, search: Int){
        
        graph = GraphLinearBinary(frame: CGRect(x: 32, y: (viewcontroller.navigationController?.navigationBar.frame.maxY)! + 20, width: viewcontroller.view.bounds.size.width - CGFloat(64), height: viewcontroller.view.bounds.size.width - CGFloat(64)))
        viewcontroller.view.addSubview(graph)
        
        self.search = search
        self.arrayAction = getAction(arr: graph.arraySort)
        
        
        animate = AnimarionBinary(arrayLabel: graph.arrayLabel, graph: graph, arraySort: graph.arraySort, arrayAction: arrayAction)
        
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
        
        textStudy.text = "Binary Search is an algorithm for searching through elements of an array"
        updateTextFont()
        var path: String = ""
        
        path = Bundle.main.path(forResource:"Binary", ofType: "plist")!
        dictData = NSDictionary(contentsOfFile: path)!
        arayKey = dictData.allKeys as! [String]
        ele = 0
        arayKey = arayKey.sorted()
        
        
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
    func getAction(arr: [Int]) -> [BinaryStep] {
        binary = BinarySearch(arrayInput: arr, search: search)
        return binary.arrayAction
    }
    
    @objc func run(sender: UIButton){
        textStudy.text = "Search: \(search!)"
        animate.loop()
        btnRunTmp.isUserInteractionEnabled = false
        btnStepTmp.isUserInteractionEnabled = false
        btnRunTmp.layer.backgroundColor = UIColor.gray.cgColor
        btnStepTmp.layer.backgroundColor = UIColor.gray.cgColor
        btnRunTmp.setNeedsDisplay()
        btnStepTmp.setNeedsDisplay()
    }
    @objc func step(sender: UIButton){
        
        if(ele==arayKey.count){
            textStudy.text = ""
            updateTextFont()
            return
        }
        btnRunTmp.isUserInteractionEnabled = false
        btnRunTmp.layer.backgroundColor = UIColor.gray.cgColor
        btnRunTmp.setNeedsDisplay()
        
        if(arayKey[ele].isNumber){
            btnStepTmp.isUserInteractionEnabled = false
            let data = dictData[arayKey[ele]]
            textStudy.text = data as! String?
            updateTextFont()
            animate.next()
        }else if(arayKey[ele]=="end"){
            textStudy.text = "Number 34 is found"
            updateTextFont()
            btnStepTmp.layer.backgroundColor = UIColor.gray.cgColor
            btnStepTmp.setNeedsDisplay()
            btnStepTmp.isUserInteractionEnabled = false
            
        }else{
            let data = dictData[arayKey[ele]]
            textStudy.text = data as! String?
            updateTextFont()
            btnStepTmp.isUserInteractionEnabled = true
            
        }
        ele = ele + 1
        
        
    }
    
}
