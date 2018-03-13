//
//  MainScreen.swift
//  Algorithms
//
//  Created by Loc Tran on 3/28/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import UIKit
import GoogleMobileAds

enum TypeSection: String{
    case Sort="Sort",Other = "Other",DataStructer="Data Structures"
}


class MainScreen: UITableViewController, GADBannerViewDelegate {
    //    var about: String!
    
    var menu: [MenuSection]!
    var bannerView = GADBannerView()
    var viewcontroller: UIViewController!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AppUtility.lockOrientation(.portrait)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Don't forget to reset when view is being removed
        AppUtility.lockOrientation(.all)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewcontroller = UIViewController()
        
//        initAdMobBanner()
        self.tableView.contentInset = UIEdgeInsetsMake(20,0,0,0)
        self.navigationController?.navigationBar.barTintColor = LIME_COLOR
        
    }
    /*
//    func initAdMobBanner(){
//        bannerView.adSize = GADAdSizeFromCGSize(CGSize(width: 320, height: 50))
//        bannerView.frame = CGRect(x: 0, y: view.bounds.size.height+300, width: 320, height: 50)
//        bannerView.adUnitID = "ca-app-pub-7384215319654531/6555347808"
//        bannerView.rootViewController = self
//        bannerView.delegate = self
//        view.addSubview(bannerView)
//        let request = GADRequest()
//        bannerView.load(request)

//    }
    func hideBanner(_ banner: UIView) {
        UIView.beginAnimations("hideBanner", context: nil)
        banner.frame = CGRect(x: view.frame.size.width/2 - banner.frame.size.width/2, y: view.frame.size.height - banner.frame.size.height, width: banner.frame.size.width, height: banner.frame.size.height)
        UIView.commitAnimations()
        banner.isHidden = true
    }
    
    // Show the banner
    func showBanner(_ banner: UIView) {
        UIView.beginAnimations("showBanner", context: nil)
        banner.frame = CGRect(x: view.frame.size.width/2 - banner.frame.size.width/2, y: view.frame.size.height - banner.frame.size.height, width: banner.frame.size.width, height: banner.frame.size.height)
        UIView.commitAnimations()
        banner.isHidden = false
    }
    
    // AdMob banner available
    func adViewDidReceiveAd(_ view: GADBannerView) {
        showBanner(bannerView)
    }
    
    // NO AdMob banner available
    func adView(_ view: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        hideBanner(bannerView)
    }
    
*/
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return menu.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let menuSection: MenuSection  = self.menu[section]
        let menuArray: [Menu] = menuSection.menus
        
        return menuArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let menuSection: MenuSection = self.menu[section]
        return menuSection.section
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "id")
        let menuSection: MenuSection = self.menu[indexPath.section]
        let menuItems = menuSection.menus
        let item: Menu = menuItems[indexPath.row]
        cell.textLabel!.text = item.title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let menuSection: MenuSection = self.menu[indexPath.section]
        let menuItems = menuSection.menus
        
        let item: Menu = menuItems[indexPath.row]
        INPUT_XIB_CLASS = item.inputClass
        PDF_TITLE = item.infoTitle
        let xibClass = item.viewClass
        
        let detailScreen: UIViewController!
        
        
        let appName =  Bundle.main.infoDictionary!["CFBundleName"] as! String
        
        // check if class exits
        
        if let aClass = NSClassFromString("\(appName).\(xibClass)") as? UIViewController.Type {
            
            if (Bundle.main.path(forResource: xibClass, ofType: "nib") == nil){
                //if the xib file does not exits
                detailScreen = aClass.init() as UIViewController
            }else{
                detailScreen = aClass.init(nibName:xibClass,bundle:nil) as UIViewController
                
            }
            
            let menuVC = MenuViewController(nibName: "MenuViewController", bundle: nil)
            
            detailScreen.title = item.title
            DETAIL = detailScreen

            let typeSection = menuSection.section

            switch typeSection {
            case TypeSection.Other.rawValue: break

            case TypeSection.Sort.rawValue,TypeSection.DataStructer.rawValue:
                let list = UIImage(named: "list-1")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
                detailScreen.navigationItem.rightBarButtonItem = UIBarButtonItem(image: list, style: .plain, target: revealViewController(), action: #selector(self.revealViewController().rightRevealToggle(_:)))

            default:
                break
            }

            let img = UIImage(named: "home")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            detailScreen.navigationItem.leftBarButtonItem = UIBarButtonItem(image: img, style: .plain, target: self, action: #selector(backHOME(sender:)))
            
            let navDetail = UINavigationController(rootViewController: detailScreen)

            navDetail.navigationBar.barTintColor = LIME_COLOR
            let revel = SWRevealViewController(rearViewController: menuVC, frontViewController: navDetail)
            revel?.rightViewController = menuVC

            navDetail.view.addGestureRecognizer((revel?.tapGestureRecognizer())!)
            
            present(revel!, animated: true, completion: nil)
            revel?.rightViewRevealWidth = 180
            VIEW_CHOSEN = "study"
            
            
            
            
        }else{
            let alert = UIAlertController.init(title: "Warning",
                                               message: "Thuật toán cần thêm \(xibClass)",
                preferredStyle: .alert)
            
            let defaultAction = UIAlertAction.init(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
            
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
        }
        
    }

    @objc func backHOME(sender: UIBarButtonItem){
        
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
}





