//
//  Square.swift
//  Chess
//
//  Created by Tuuu on 3/8/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import Foundation
import UIKit
struct Position {
    var row: Int!
    var col: Int!
}
extension Position: Equatable
{
    static func ==(lhs: Position, rhs: Position) -> Bool
    {
        if(lhs.row == rhs.row && lhs.col == rhs.col)
        {
            return true
        }
        return false
    }
}
struct CellInfo {
    var margin: CGFloat!
    var squareWidth: CGFloat!
}
class Square: UIView
{
    required init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
    
    init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        drawCell(cellSize: frame.width, color: color.cgColor)
        
    }
    
    func drawCell(cellSize: CGFloat, color: CGColor){
        
        let cell = UIView(frame: self.frame)
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = cell.bounds
        maskLayer.path = UIBezierPath(rect: cell.bounds).cgPath
        maskLayer.opacity = 0.7
        cell.layer.mask = maskLayer
        
        let borderLayer = CAShapeLayer()
        borderLayer.path = maskLayer.path
        borderLayer.fillColor = color
        borderLayer.strokeColor = UIColor.black.cgColor
        borderLayer.lineWidth = 2
        borderLayer.frame = cell.bounds
        
        self.layer.addSublayer(borderLayer)
        
    }
}

