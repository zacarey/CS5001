//
//  CustomButton.swift
//  Algorithms
//
//  Created by Loc Tran on 4/9/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import UIKit

extension UIButton{
    
    
    func fontoFitHeight()->CGFloat{
        
        var minFontsize: CGFloat = DISPLAY_FONT_MIN
        var maxFontsize: CGFloat = DISPLAY_FONT_MAX
        var fontSizeAverage: CGFloat = 0
        var textandLabelHeight: CGFloat = 0
        while(minFontsize<=maxFontsize){
            fontSizeAverage = (maxFontsize-minFontsize)/2 + minFontsize
            
            let text = self.titleLabel?.text
            guard (text?.count)!>0 else {
                break
            }
            if let  labelText: NSString = text as NSString?{
                let labelHeight = self.frame.height-5
                
                let textHeight = labelText.size(withAttributes: [NSAttributedStringKey.font:self.titleLabel?.font.withSize(fontSizeAverage) as Any]).height
                
                textandLabelHeight = labelHeight - textHeight
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

