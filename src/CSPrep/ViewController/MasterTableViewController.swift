//
//  ViewController.swift
//  CSPrep
//
//  Created by Loc Tran on 3/14/18.
//  Copyright © 2018 LocTran. All rights reserved.
//

import UIKit

class MasterTableViewController: UITableViewController {
    
    let cellId = "cellId"
    
    let algo = [
        ["Bubble Sort","Selection Sort","Insertion Sort","Merge Sort","Quick Sort","Heap Sort"],
        ["Linear Search","Binary Search"],
        ["Linked List","Queues","Stacks"],
        ["Tower Of Hanoi"]
    ]
    
    let sectionTitle = ["Sort","Search","Data Structures","Other"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.title = "CSPrep"
        navigationController?.navigationBar.barTintColor = LIME_COLOR
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.textAlignment = NSTextAlignment.left
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return algo.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return algo[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        let name = algo[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var studyVC : UIViewController!
        
        switch indexPath.section{
        case 0:
            switch indexPath.row{
            case 0:
                studyVC = BubbleSortSVC() as UIViewController
            case 1:
                studyVC = SelectionSortSVC() as UIViewController
            case 2:
                studyVC = InsertionSortSVC() as UIViewController
            case 3:
                studyVC = MergeSortSVC() as UIViewController
            case 4:
                studyVC = QuickSortSVC() as UIViewController
            case 5:
                studyVC = HeapSortSVC() as UIViewController
            default:
                break
            }
        case 1:
            switch indexPath.row{
            case 0:
                studyVC = LinearSVC() as UIViewController
            case 1:
                studyVC = BinarySVC() as UIViewController
//            case 2:
//                studyVC = BreadthSVC() as UIViewController
//            case 3:
//                studyVC = DepthSVC() as UIViewController
            default:
                break
            }
        case 2:
            switch indexPath.row{
            case 0:
                studyVC = LinkListVC() as UIViewController
            case 1:
                studyVC = QueuesSVC() as UIViewController
            case 2:
                studyVC = StacksSVC() as UIViewController
            default:
                break
            }
        case 3:
            switch indexPath.row{
            case 0:
                studyVC = TowerOfHaNoiVC() as UIViewController
            default:
                break
            }
        default:
            break
        }
        self.navigationController?.pushViewController(studyVC, animated: true)
    }
    
}

