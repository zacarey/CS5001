//
//  SortingLabel.swift
//  Algorithms
//
//  Created by Loc Tran on 3/23/17.
//  Copyright © 2017 LocTran. All rights reserved.
//
import Foundation
import UIKit
class SortingLabel: UILabel {

    required init?(coder aDecoder: NSCoder) {
        fatalError(".....")
    }

    override func layoutSubviews() {
        font = fontoFitHeight()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textAlignment = NSTextAlignment.center
        self.textColor = UIColor.red


    }


    init(frame: CGRect, color: UIColor, value: String) {
        super.init(frame: frame)

        self.backgroundColor = color
        self.text = value
        self.textColor = UIColor.white

        self.textAlignment = NSTextAlignment.center
        self.layer.cornerRadius = frame.width/2
        self.clipsToBounds = true
        self.alpha = DEFAULT_ALPHA

        self.adjustsFontSizeToFitWidth = true
        self.numberOfLines = 0
        self.baselineAdjustment = .alignBaselines
        self.minimumScaleFactor = 0.2


    }

    func fontoFitHeight()->UIFont{
        var minFontsize: CGFloat = DISPLAY_FONT_MIN
        var maxFontsize: CGFloat = DISPLAY_FONT_MAX
        var fontSizeAverage: CGFloat = 0
        var textandLabelHeight: CGFloat = 0
        while(minFontsize<=maxFontsize){
            fontSizeAverage = (maxFontsize-minFontsize)/2 + minFontsize
            let text = self.text
            if text == nil{
                break
            }
            guard (text?.characters.count)!>0 else {
                break
            }
            if let  labelText: NSString = text as NSString?{
                let labelHeight = self.frame.height-5

                let textHeight = labelText.size(withAttributes: [NSAttributedStringKey.font:self.font.withSize(fontSizeAverage)]).height
                textandLabelHeight = labelHeight - textHeight
                if(fontSizeAverage==minFontsize || fontSizeAverage==maxFontsize){
                    if(textandLabelHeight<0){
                        return self.font.withSize(fontSizeAverage-1)
                    }
                    return self.font.withSize(fontSizeAverage)
                }
                if(textandLabelHeight<0){
                    maxFontsize = fontSizeAverage-1
                }else if(textandLabelHeight>0){
                    minFontsize = fontSizeAverage+1
                }else{
                    return self.font.withSize(fontSizeAverage)
                }
            }
        }
        return self.font.withSize(fontSizeAverage)

    }
}
extension UILabel{
    
    func fontoFitWidth()->CGFloat{
        var minFontsize: CGFloat = DISPLAY_FONT_MIN
        var maxFontsize: CGFloat = DISPLAY_FONT_MAX
        var fontSizeAverage: CGFloat = 0
        var textandLabelHeight: CGFloat = 0
        while(minFontsize<=maxFontsize){
            fontSizeAverage = (maxFontsize-minFontsize)/2 + minFontsize
            let text = self.text
            if text == nil{
                break
            }
            guard (text?.characters.count)!>0 else {
                break
            }
            if let  labelText: NSString = text as NSString?{
                let labelWidth = self.frame.width-10
                
                let textWidth = labelText.size(withAttributes: [NSAttributedStringKey.font:self.font.withSize(fontSizeAverage)]).width
                textandLabelHeight = labelWidth - textWidth
                if(fontSizeAverage==minFontsize || fontSizeAverage==maxFontsize){
                    if(textandLabelHeight<0){
                        return fontSizeAverage-1
                    }
                    return fontSizeAverage
                }
                if(textandLabelHeight<0){
                    maxFontsize = fontSizeAverage-1
                }else if(textandLabelHeight>0){
                    minFontsize = fontSizeAverage+1
                }else{
                    return fontSizeAverage
                }
            }
        }
        return fontSizeAverage
        
    }
    func fontoFitSquare()->CGFloat{
        var minFontsize: CGFloat = DISPLAY_FONT_MIN
        var maxFontsize: CGFloat = DISPLAY_FONT_MAX
        var fontSizeAverage: CGFloat = 0
        var textandLabelHeight: CGFloat = 0
        while(minFontsize<=maxFontsize){
            fontSizeAverage = (maxFontsize-minFontsize)/2 + minFontsize
            let text = self.text
            if text == nil{
                break
            }
            guard (text?.characters.count)!>0 else {
                break
            }
            if let  labelText: NSString = text as NSString?{
                let labelWidth = self.frame.width-20
                
                let textWidth = labelText.size(withAttributes: [NSAttributedStringKey.font:self.font.withSize(fontSizeAverage)]).width
                textandLabelHeight = labelWidth - textWidth
                if(fontSizeAverage==minFontsize || fontSizeAverage==maxFontsize){
                    if(textandLabelHeight<0){
                        return fontSizeAverage-1
                    }
                    return fontSizeAverage
                }
                if(textandLabelHeight<0){
                    maxFontsize = fontSizeAverage-1
                }else if(textandLabelHeight>0){
                    minFontsize = fontSizeAverage+1
                }else{
                    return fontSizeAverage
                }
            }
        }
        return fontSizeAverage
        
    }
    
    
    
}

