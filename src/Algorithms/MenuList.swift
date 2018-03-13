//
//  MenuList.swift
//  Algorithms
//
//  Created by Loc Tran on 3/28/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
import UIKit

struct Menu {
    var title: String
    var viewClass: String
    var inputClass: UIViewController
    var infoTitle: String
    
};

struct MenuSection {
    var section: String
    var menus: [Menu]
}

class MenuList: NSObject {
    
    var menu : [MenuSection]!
    static var rootWindow: UIWindow!
    static var main: MainScreen!
    class func boot(window:UIWindow){
        
        let basic = MenuSection(section: "Sort", menus:[
            Menu(title: "Bubble Sort", viewClass: "BubbleSortSVC",inputClass: BubbleSortIVC(), infoTitle: "BubbleSortDocument" ),
            Menu(title: "Selection Sort", viewClass: "SelectionSortSVC",inputClass: SelectionSortIVC(), infoTitle: "SelectionSortDocument" ),
            Menu(title: "Insertion Sort", viewClass: "InsertionSortSVC",inputClass: InsertionSortIVC(), infoTitle: "InsertionSortDocument" ),
            Menu(title: "Merge Sort", viewClass: "MergeSortSVC",inputClass: MergeSortIVC(), infoTitle: "MergeSortDocument" ),
            Menu(title: "Quick Sort", viewClass: "QuickSortSVC",inputClass: QuickSortIVC(), infoTitle: "QuickSortDocument" ),
            Menu(title: "Heap Sort", viewClass: "HeapSortSVC",inputClass: HeapSortIVC(), infoTitle: "HeapSortDocument" )
            
            ])
        
//        let inter = MenuSection(section: "N-Queen ", menus:[
//            Menu(title: "N-Queen Problem", viewClass: "ViewController",inputClass: SelectionSortIVC(), infoTitle: "A" )
//            ])
        let tower = MenuSection(section: "Other", menus:[
            Menu(title: "Tower Of Hanoi", viewClass: "TowerOfHaNoiVC",inputClass: SelectionSortIVC(), infoTitle: "A" )
            ])
        let dataStructs = MenuSection(section: "Data Structures", menus:[
             Menu(title: "Link List", viewClass: "LinkListVC",inputClass: SelectionSortIVC(), infoTitle: "A" ),
            Menu(title: "Stacks", viewClass: "StacksSVC",inputClass: StacksSVC(), infoTitle: "A" ),
            Menu(title: "Queues", viewClass: "QueuesSVC",inputClass: QueuesSVC(), infoTitle: "A" ),
            
            ])
        let search = MenuSection(section: "Search", menus:[
            Menu(title: "Linear Search", viewClass: "LinearSVC",inputClass: LinearSVC(), infoTitle: "A" ),
            Menu(title: "Binary Search", viewClass: "BinarySVC",inputClass: BinarySVC(), infoTitle: "A" ),
            Menu(title: "Breadth-First Search", viewClass: "BreadthSVC",inputClass: BreadthSVC(), infoTitle: "A" ),
            Menu(title: "Depth-First Search", viewClass: "DepthSVC",inputClass: DepthSVC(), infoTitle: "A" )
            ])

        
//        let advance = MenuSection(section: "Other", menus:[
//            Menu(title: "About", viewClass: "AboutVC",inputClass: SelectionSortIVC(), infoTitle: "A" ),
//            Menu(title: "Share", viewClass: "ShareVC",inputClass: ShareVC(), infoTitle: "A" )
//            ])
        
//        let advance = MenuSection(section: "Other", menus:[
//            Menu(title: "Share", viewClass: "ShareVC",inputClass: ShareVC(), infoTitle: "A" )
//            ])
        
        let mainScreen = MainScreen(style: UITableViewStyle.grouped)
        mainScreen.menu = [basic,search,dataStructs,tower]
        mainScreen.title = "Algorithms"
        
        let nav = UINavigationController(rootViewController: mainScreen)
        
        
        window.rootViewController = nav
        rootWindow = window
        main = mainScreen
        
    }
    class func nextView(){
        rootWindow.rootViewController = UINavigationController(rootViewController: main)
        
    }
}
