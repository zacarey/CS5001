//
//  LinearSearch.swift
//  Algorithms
//
//  Created by TTung on 5/8/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation

class LinearSearch {
    var arrayAction = [LinearStep]()
    var arrayInput = [Int]()
    
    init(arrayInput: [Int], search: Int) {
        self.arrayInput = arrayInput
        linearSearch(arrayInput, search)

    }
    
    func linearSearch<T: Equatable>(_ array: [T], _ object: T) {
        
        for (_, obj) in array.enumerated()  {
            
            
            if obj == object{
                self.arrayAction.append(LinearStep(act: "true"))
            }
            else {
                self.arrayAction.append(LinearStep(act: "false"))
            }
        }
    }
}
