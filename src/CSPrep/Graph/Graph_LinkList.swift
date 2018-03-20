//
//  Graph_LinkList.swift
//  Algorithms
//
//  Created by Loc Tran on 5/5/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import UIKit

class Graph_LinkList: UIView {
    
    var spacing : CGFloat!
    var rectSize: CGFloat!
    var arrayLabel: [SortingLabel]!
    
    var bearingPoint:CGPoint!
    let infoString: [String] = ["Mobile","IOS","Android"]
    let nextString: [String] = ["0x12","0x10","0x15","0x13"]
    let colors: [UIColor] = [LIME_COLOR,
                             UIColor(red: 30/255, green: 144/255, blue: 1, alpha: 1),
                             UIColor(red: 1, green: 215/255, blue: 0, alpha: 1)
        
    ]
    var arrNodes:[UILabel] = [UILabel]()
    var arrArrows:[CAShapeLayer] = [CAShapeLayer]()
    var view: UIView!
    var labelValue:UILabel!
    var labelNext:UILabel!
    var arrow1: CAShapeLayer!
    var arrow2: CAShapeLayer!
    var addLable: UILabel!
    var arrDots: [CAShapeLayer] = [CAShapeLayer]()
    var arrowCurved: [CAShapeLayer] = [CAShapeLayer]()
    var arrowDown: CAShapeLayer!
    var dotDown: CAShapeLayer!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //        view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height/2))
        //        addSubview(view)
        //        view.backgroundColor = UIColor.darkGray
        spacing = self.frame.width/22.5
        
        rectSize = spacing*5
        self.arrayLabel = [SortingLabel]()
        bearingPoint = CGPoint(x: spacing, y: self.frame.height*2/5)
        drawNameNodes()
        drawNodes()
        drawAdd()
        drawArrows()
        drawInfo()
        
        
    }
    func drawAdd(){
        addLable = UILabel(frame: CGRect(x: arrNodes[0].center.x, y: self.frame.height*3/5, width: rectSize, height: self.frame.height/10))
        //        label.backgroundColor = UIColor.blue
        self.addSubview(addLable)
        let infoLabel = UILabel(frame: CGRect(x: 0, y: 0, width: addLable.frame.width*3/5, height:addLable.frame.height))
        let nextLabel = UILabel(frame: CGRect(x: infoLabel.frame.width, y: 0, width: addLable.frame.width*2/5, height: addLable.frame.height))
        infoLabel.backgroundColor = UIColor.red
        nextLabel.backgroundColor = UIColor(red: 183/255, green: 183/255, blue: 183/255, alpha: 1)
        infoLabel.text = "Window"
        infoLabel.textAlignment = .center
        infoLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 14)
        nextLabel.text = "Null"
        nextLabel.textAlignment = .left
        nextLabel.font = nextLabel.font.withSize(nextLabel.fontoFitWidth())
        infoLabel.textColor = UIColor.black
        addLable.layer.cornerRadius = 2
        addLable.layer.masksToBounds = true
        addLable.layer.borderColor = UIColor.gray.cgColor
        addLable.layer.borderWidth = 2
        infoLabel.textColor = UIColor.white
        nextLabel.textColor = UIColor.white
        addLable.addSubview(infoLabel)
        addLable.addSubview(nextLabel)
        addLable.isHidden = true
        nextLabel.tag = 42
        
        let pathDot = UIBezierPath(ovalIn: CGRect.init(x: arrNodes[0].frame.minX + rectSize*4/5-5, y: self.frame.height/2-5, width: 10, height: 10))
        dotDown = CAShapeLayer()
        dotDown.path = pathDot.cgPath
        dotDown.strokeColor = UIColor.gray.cgColor
        dotDown.fillColor = UIColor.white.cgColor
        dotDown.lineWidth = 2
        //        CGPoint(x: arrNodes[0].frame.minX + rectSize*4/5, y: self.frame.height/2)
        let arrowPath = UIBezierPath.bezierPathWithArrowFromPoint(startPoint: CGPoint(x: arrNodes[0].frame.minX + rectSize*4/5, y: self.frame.height/2), endPoint: CGPoint(x: arrNodes[0].frame.minX + rectSize*4/5, y: self.frame.height*3/5), tailWidth: 4, headWidth: 20, headLength: 6)
        arrowDown = CAShapeLayer()
        arrowDown.path = arrowPath.cgPath
        arrowDown.lineWidth = 1
        arrowDown.fillColor = UIColor.gray.cgColor
        arrowDown.isHidden = true
        layer.addSublayer(arrowDown)
        layer.addSublayer(dotDown)
        dotDown.isHidden = true
    }
    func printNameNode(){
        let lable = UILabel(frame: CGRect(x: addLable.frame.minX, y: addLable.frame.maxY, width: addLable.frame.width, height: addLable.frame.height))
        lable.text = "Node( 0x35 )"
        lable.textAlignment = .center
        lable.font = lable.font.withSize(lable.fontoFitWidth())
        self.addSubview(lable)
        
    }
    func drawInfo(){
        labelValue = UILabel(frame: CGRect(x: bearingPoint.x * CGFloat(1)+rectSize*CGFloat(0), y: self.frame.height*3/5, width: rectSize, height: self.frame.height/10))
        labelValue.backgroundColor = UIColor.orange
        labelNext = UILabel(frame: CGRect(x: bearingPoint.x * CGFloat(4)+rectSize*CGFloat(2), y: self.frame.height*3/5, width: rectSize, height: self.frame.height/10))
        //        labelNext.backgroundColor = UIColor.red
        labelValue.text = "Data"
        labelValue.textAlignment = .center
        labelNext.text = "Reference"
        labelNext.textAlignment = .center
        labelNext.backgroundColor = LIME_COLOR
        labelValue.backgroundColor = LIME_COLOR
        labelValue.layer.borderColor = UIColor.gray.cgColor
        labelNext.layer.borderColor = UIColor.gray.cgColor
        labelNext.layer.borderWidth = 1
        labelValue.layer.borderWidth = 1
        labelNext.layer.masksToBounds = true
        labelValue.layer.masksToBounds = true
        labelNext.layer.cornerRadius = 10
        labelValue.layer.cornerRadius = 10
        labelNext.textColor = UIColor.white
        labelValue.textColor = UIColor.white
        arrow1 = CAShapeLayer()
        arrow2 = CAShapeLayer()
        var arrowPath = UIBezierPath.bezierPathWithArrowFromPoint(startPoint:CGPoint(x: labelValue.frame.maxX, y: labelValue.frame.minY), endPoint: CGPoint(x: arrNodes[1].frame.minX, y: arrNodes[1].frame.maxY), tailWidth: 4, headWidth: 8, headLength: 6)
        arrow1.path = arrowPath.cgPath
        arrowPath = UIBezierPath.bezierPathWithArrowFromPoint(startPoint:CGPoint(x: labelNext.frame.minX, y: labelValue.frame.minY), endPoint: CGPoint(x: arrNodes[1].frame.maxX, y: arrNodes[1].frame.maxY), tailWidth: 4, headWidth: 8, headLength: 6)
        arrow2.path = arrowPath.cgPath
        arrow1.fillColor = UIColor.gray.cgColor
        arrow2.fillColor = UIColor.gray.cgColor
        arrow1.isHidden = true
        arrow2.isHidden = true
        labelNext.isHidden = true
        labelValue.isHidden = true
        
        layer.addSublayer(arrow1)
        layer.addSublayer(arrow2)
        addSubview(labelValue)
        addSubview(labelNext)
        
    }
    func drawNameNodes(){
        var _space:Float = 1
        for i in 0...2{
            let label = UILabel(frame: CGRect(x: bearingPoint.x * CGFloat(_space)+rectSize*CGFloat(i), y: self.frame.height*3/10, width: rectSize, height: self.frame.height/10))
            label.text = "Node( "+nextString[i] + " )"
            label.textAlignment = .center
            label.font = label.font.withSize(label.fontoFitWidth())
            self.addSubview(label)
            _space += 1.5
        }
    }
    func drawNodes(){
        var _space:Float = 1
        for i in 1...4{
            let label = UILabel(frame: CGRect(x: bearingPoint.x * CGFloat(_space)+rectSize*CGFloat(i-1), y: bearingPoint.y, width: rectSize, height: self.frame.height/10))
            
            self.addSubview(label)
            self.arrNodes.append(label)
            if(i==4){
                label.frame.size.width = 2*spacing
                //                label.backgroundColor = UIColor.blue
                label.text = "Null"
                label.textAlignment = .left
                label.font = label.font.withSize(label.fontoFitWidth())
                
                break
            }
            
            let infoLabel = UILabel(frame: CGRect(x: 0, y: 0, width: label.frame.width*3/5, height:label.frame.height))
            let nextLabel = UILabel(frame: CGRect(x: infoLabel.frame.width, y: 0, width: label.frame.width*2/5, height: label.frame.height))
            infoLabel.tag = 10*i+1
            nextLabel.tag = 10*i+2
            infoLabel.backgroundColor = colors[i-1]
            nextLabel.backgroundColor = UIColor(red: 183/255, green: 183/255, blue: 183/255, alpha: 1)
            infoLabel.text = infoString[i-1]
            infoLabel.textAlignment = .center
            infoLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 14)
            nextLabel.text = nextString[i]
            nextLabel.textAlignment = .left
            nextLabel.font = nextLabel.font.withSize(nextLabel.fontoFitWidth())
            infoLabel.textColor = UIColor.white
            nextLabel.textColor = UIColor.white
            label.layer.cornerRadius = 2
            label.layer.masksToBounds = true
            label.layer.borderColor = UIColor.gray.cgColor
            label.layer.borderWidth = 2
            label.addSubview(infoLabel)
            label.addSubview(nextLabel)
            _space += 1.5
            
        }
        
        
    }
    func drawArrows(){
        for i in 1...3{
            let pointArrows = arrNodes[i-1].center
            let pathDot = UIBezierPath(ovalIn: CGRect.init(x: pointArrows.x+2.5*spacing-5, y: pointArrows.y-5, width: 10, height: 10))
            let dot = CAShapeLayer()
            dot.path = pathDot.cgPath
            let arrowPath = UIBezierPath.bezierPathWithArrowFromPoint(startPoint: CGPoint(x: pointArrows.x+2.5*spacing, y: pointArrows.y), endPoint: CGPoint(x: pointArrows.x+4*spacing, y: pointArrows.y), tailWidth: 4, headWidth: 20, headLength: 6)
            let arrow = CAShapeLayer()
            
            arrow.path = arrowPath.cgPath
            dot.strokeColor = UIColor.gray.cgColor
            dot.fillColor = UIColor.white.cgColor
            dot.lineWidth = 2
            arrDots.append(dot)
            
            arrow.path = arrowPath.cgPath
            arrow.lineWidth = 1
            arrow.fillColor = UIColor.gray.cgColor
            arrArrows.append(arrow)
            self.layer.addSublayer(arrow)
            self.layer.addSublayer(dot)
            
        }
        // draw arrow curved
        var arrCgPath = [UIBezierPath]()
        arrCgPath = UIBezierPath.bezierPathArrowUpward(startPoint: CGPoint(x:addLable.frame.maxX,y: addLable.center.y), endPoint: CGPoint(x:arrNodes[1].center.x,y: arrNodes[1].frame.maxY), headLength: 6, headWith: 20)
        let p1 = CAShapeLayer()
        let p2 = CAShapeLayer()
        
        p1.path = arrCgPath[0].cgPath
        p2.path = arrCgPath[1].cgPath
        p1.lineWidth = 6
        p2.lineWidth = 1
        p1.strokeColor = UIColor.gray.cgColor
        p1.fillColor = UIColor.clear.cgColor
        p2.strokeColor = UIColor.gray.cgColor
        p2.fillColor = UIColor.gray.cgColor
        p1.isHidden = true
        p2.isHidden = true
        arrowCurved.append(p1)
        arrowCurved.append(p2)
        let dot = CAShapeLayer()
        let pathDot = UIBezierPath(ovalIn: CGRect.init(x: addLable.frame.maxX-5, y: addLable.center.y-5, width: 10, height: 10))
        dot.path = pathDot.cgPath
        dot.strokeColor = UIColor.gray.cgColor
        dot.fillColor = UIColor.white.cgColor
        dot.lineWidth = 2
        dot.isHidden = true
        arrDots.append(dot)
        
        
        self.layer.addSublayer(p1)
        self.layer.addSublayer(p2)
        self.layer.addSublayer(dot)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension UIBezierPath {
    
    class func getAxisAlignedArrowPoints( points: inout Array<CGPoint>, forLength: CGFloat, tailWidth: CGFloat, headWidth: CGFloat, headLength: CGFloat ) {
        
        let tailLength = forLength - headLength
        
        points.append(CGPoint(x: 0, y: tailWidth/2))
        points.append(CGPoint(x:tailLength, y:tailWidth/2))
        points.append(CGPoint(x:tailLength, y:headWidth/2))
        points.append(CGPoint(x:forLength, y:0))
        points.append(CGPoint(x:tailLength, y:-headWidth/2))
        points.append(CGPoint(x:tailLength, y:-tailWidth/2))
        points.append(CGPoint(x: 0, y:-tailWidth/2))
        
    }
    
    
    class func transformForStartPoint(startPoint: CGPoint, endPoint: CGPoint, length: CGFloat) -> CGAffineTransform{
        let cosine: CGFloat = (endPoint.x - startPoint.x)/length
        let sine: CGFloat = (endPoint.y - startPoint.y)/length
        return __CGAffineTransformMake(cosine, sine, -sine, cosine, startPoint.x, startPoint.y)
    }
    
    
    class func bezierPathWithArrowFromPoint(startPoint:CGPoint, endPoint: CGPoint, tailWidth: CGFloat, headWidth: CGFloat, headLength: CGFloat) -> UIBezierPath {
        
        let xdiff: Float = Float(endPoint.x) - Float(startPoint.x)
        let ydiff: Float = Float(endPoint.y) - Float(startPoint.y)
        let length = hypotf(xdiff, ydiff)
        
        var points = [CGPoint]()
        self.getAxisAlignedArrowPoints(points: &points, forLength: CGFloat(length), tailWidth: tailWidth, headWidth: headWidth, headLength: headLength)
        
        let transform: CGAffineTransform = self.transformForStartPoint(startPoint: startPoint, endPoint: endPoint, length:  CGFloat(length))
        
        let cgPath: CGMutablePath = CGMutablePath()
        
        cgPath.addLines(between: points, transform: transform)
        //        cgPath.addLines(between: points)
        cgPath.closeSubpath()
        
        let uiPath: UIBezierPath = UIBezierPath(cgPath: cgPath)
        return uiPath
    }
    class func bezierPathArrowUpward(startPoint: CGPoint,endPoint: CGPoint,headLength: CGFloat,headWith:CGFloat)->[UIBezierPath]{
        let cgPath: CGMutablePath = CGMutablePath()
        cgPath.move(to: startPoint)
        let bearingPoint = CGPoint(x: endPoint.x, y: endPoint.y + headLength)
        cgPath.addQuadCurve(to: bearingPoint, control: CGPoint(x: (bearingPoint.x-bearingPoint.x)/2+bearingPoint.x, y: startPoint.y))
        let cg: CGMutablePath = CGMutablePath()
        cg.move(to: bearingPoint)
        cg.addLine(to: CGPoint(x: bearingPoint.x-headWith/2, y: bearingPoint.y))
        cg.addLine(to: endPoint)
        cg.addLine(to: CGPoint(x: bearingPoint.x+headWith/2,y: bearingPoint.y))
        cg.addLine(to: bearingPoint)
        return [UIBezierPath(cgPath: cgPath),UIBezierPath(cgPath: cg)]
        
        
    }
    
}
