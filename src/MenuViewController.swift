//
//  MenuViewController.swift
//  Algorithms
//
//  Created by Loc Tran on 4/11/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import UIKit
import KDPulseButton


class MenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    struct cellData{
        let nameText: String!
        let image: UIImage!
        
    }
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var viewMenu: UIView!
    var arrayCellData = [cellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrayCellData = [cellData(nameText: "Study",image: #imageLiteral(resourceName: "learning")),
                         cellData(nameText: "Customize",image: #imageLiteral(resourceName: "pencils")),
                         cellData(nameText: "Reading",image: #imageLiteral(resourceName: "reading"))
        ]
        
        imgProfile.layer.borderWidth = 2
        imgProfile.layer.borderColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1).cgColor
        imgProfile.layer.cornerRadius = 20
        imgProfile.layer.backgroundColor = UIColor.black.cgColor
        
        imgProfile.layer.masksToBounds = false
        imgProfile.clipsToBounds = true
        
        let nib = UINib(nibName: "MenuCell", bundle: nil)
        
        tableView.register(nib, forCellReuseIdentifier: "MenuCell")
        
        viewMenu.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
        let navBar = UINavigationBar(frame: CGRect(x: 0, y:0 , width: 270, height: 44+UIApplication.shared.statusBarFrame.height))
        
        navBar.barTintColor = LIME_COLOR
        
        let navItem = UINavigationItem(title: "Menu")
        navBar.setItems([navItem], animated: false)
        
        self.view.addSubview(navBar)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCellData.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.imgCell.image = arrayCellData[indexPath.row].image
        cell.titleCell.text = arrayCellData[indexPath.row].nameText
        cell.titleCell.font = UIFont(name: "Helvetica Neue", size: 18)
        cell.titleCell.textColor = UIColor.black
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let revealviewcontroller:SWRevealViewController = self.revealViewController()
        
        if (indexPath.row == 0){
//            DETAIL.loadView()
            let newFontController = UINavigationController.init(rootViewController: DETAIL)
            newFontController.navigationBar.barTintColor = LIME_COLOR
            revealviewcontroller.pushFrontViewController(newFontController, animated: true) 
            newFontController.view.addGestureRecognizer((revealviewcontroller.tapGestureRecognizer())!)
            _ = UIImage(named: "list-1")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            VIEW_CHOSEN = "study"
            
        }else if(indexPath.row == 1){
            let newFontController = UINavigationController.init(rootViewController: INPUT_XIB_CLASS)
            
            newFontController.navigationBar.barTintColor = LIME_COLOR
            
            
            INPUT_XIB_CLASS.title = DETAIL.title
            revealviewcontroller.pushFrontViewController(newFontController, animated: true)
            var img = UIImage(named: "list-1")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            INPUT_XIB_CLASS.navigationItem.rightBarButtonItem = UIBarButtonItem(image: img, style: .plain, target: revealviewcontroller, action: #selector(revealviewcontroller.rightRevealToggle(_:)))
            INPUT_XIB_CLASS.view.addGestureRecognizer((revealviewcontroller.tapGestureRecognizer())!)

            
            img = UIImage(named: "home")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            
            INPUT_XIB_CLASS.navigationItem.leftBarButtonItem = UIBarButtonItem(image: img, style: .plain, target: self, action: #selector(backHOME(sender:)))
            VIEW_CHOSEN = "input"

        }else{
            
            
            let pdfVC = PDFViewController()
            let PDF_INFO = pdfVC
            
            let newFontController = UINavigationController.init(rootViewController: pdfVC)
            
            newFontController.navigationBar.barTintColor = LIME_COLOR
            
            
            PDF_INFO.title = DETAIL.title
            revealviewcontroller.pushFrontViewController(newFontController, animated: true)
            var img = UIImage(named: "list-1")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            PDF_INFO.navigationItem.rightBarButtonItem = UIBarButtonItem(image: img, style: .plain, target: revealviewcontroller, action: #selector(revealviewcontroller.rightRevealToggle(_:)))
            pdfVC.view.addGestureRecognizer((revealviewcontroller.tapGestureRecognizer())!)

            img = UIImage(named: "home")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            PDF_INFO.navigationItem.leftBarButtonItem = UIBarButtonItem(image: img, style: .plain, target: self, action: #selector(backHOME(sender:)))
            VIEW_CHOSEN = "Info"
            
        }
    }
    
    func backHOME(sender: UIBarButtonItem){
        dismiss(animated: true, completion: nil)
    }
    
}
