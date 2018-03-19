//
//  PDFViewController.swift
//  Algorithms
//
//  Created by Loc Tran on 4/17/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import UIKit


class PDFViewController: UIViewController {
    
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
        
        // Do any additional setup after loading the view.
        
        let pdfTitle = PDF_TITLE
        
        let url = Bundle.main.url(forResource: pdfTitle, withExtension: "pdf")
        
        let webView = UIWebView(frame: view.frame)
        let urlRequest = URLRequest(url: url!)
        
        webView.loadRequest(urlRequest as URLRequest)
        webView.scalesPageToFit = true
        
        view.addSubview(webView)
        title = pdfTitle
        
        addBackButton()
        
    }
    
    func addBackButton(){
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: self, action: #selector(popToRootView(sender:)))
        backButton.tintColor = UIColor.white
        
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func popToRootView(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}

