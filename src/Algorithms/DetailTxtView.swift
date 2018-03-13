//
//  DetailTxtView.swift
//  Algorithms
//
//  Created by Loc Tran on 5/8/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import UIKit

class DetailTxtView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 10
        self.isEditable = false
        self.layer.masksToBounds = true
        self.textColor = UIColor.black

        self.isScrollEnabled = false
        self.textContainerInset = UIEdgeInsetsMake(5, 10, 5, 10)
        self.font = UIFont.boldSystemFont(ofSize:20)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
