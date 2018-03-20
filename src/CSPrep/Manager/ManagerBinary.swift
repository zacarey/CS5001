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
        
        textStudy = DetailTxtView(frame: CGRect(x: graph.frame.origin.x,
                                                y: graph.frame.maxY + 20,
                                                width: graph.frame.width,
                                                height: yMax-(graph.frame.origin.y+graph.frame.height)),
                                  textContainer: nil)
        
        viewcontroller.view.addSubview(textStudy)
        
        
        
        var path: String = ""
        
        path = Bundle.main.path(forResource:"Linear", ofType: "plist")!
        dictData = NSDictionary(contentsOfFile: path)!
        arayKey = dictData.allKeys as! [String]
        
        arayKey = arayKey.sorted(by: {$0 < $1})
        ele = 0
        
    }
    func getAction(arr: [Int]) -> [BinaryStep] {
        binary = BinarySearch(arrayInput: arr, search: search)
        return binary.arrayAction
    }
    
    @objc func run(sender: UIButton){
        textStudy.text = "Sap xep lai mang \nTim kiem so: \(search!)"
        animate.loop()
        btnRunTmp.isUserInteractionEnabled = false
        btnStepTmp.isUserInteractionEnabled = false
        btnRunTmp.layer.backgroundColor = UIColor.gray.cgColor
        btnStepTmp.layer.backgroundColor = UIColor.gray.cgColor
        btnRunTmp.setNeedsDisplay()
        btnStepTmp.setNeedsDisplay()
    }
    @objc func step(sender: UIButton){
        animate.next()
        btnRunTmp.isUserInteractionEnabled = false
        btnStepTmp.isUserInteractionEnabled = false
        btnRunTmp.layer.backgroundColor = UIColor.gray.cgColor
        btnRunTmp.setNeedsDisplay()
        btnStepTmp.setNeedsDisplay()
    }
    
}
