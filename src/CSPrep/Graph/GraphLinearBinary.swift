//
//  GraphLinearBinary.swift
//  Algorithms
//
//  Created by Loc Tran on 5/8/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import UIKit

class GraphLinearBinary: UIView {
    
    var arrayLabel: [SortingLabel]!
    var arrayFind = [Int]()
    var arrayInt = [Int]()
    var arraySort = [Int]()
    var rowTotal = 6
    var colTotal = 6
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        arrayLabel = [SortingLabel]()
        drawBoard()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawBoard(){
        let cellSize = frame.width/6
        for i in 1..<37{
            var int: Int!
            int = i
            arrayInt.append(int)
        }
        var count:Int = 36
        for indexCol in 0..<6{
            for indexRow in 0..<6{
                
                let label = SortingLabel(frame: CGRect(x: CGFloat(indexRow) * cellSize,
                                                       y: CGFloat(indexCol) * cellSize,
                                                       width: cellSize, height: cellSize))
                
                
                let pos = Int(arc4random_uniform(UInt32(count)))
                label.text = String(arrayInt[pos])
                label.textColor = UIColor.black
                arrayFind.append(arrayInt[pos])
                arrayInt.remove(at: pos)
                count = count - 1
                label.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
                label.textAlignment = .center
                label.layer.masksToBounds = true
                label.layer.borderWidth = 2
                label.layer.cornerRadius = 5
                label.layer.borderColor = UIColor.black.cgColor
                
                arrayLabel.append(label)
                self.addSubview(label)
                
                // 0...63
                
            }
        }
        arraySort = arrayFind.sorted()
    }
}
