//
//  PDFViewController.swift
//  Algorithms
//
//  Created by Loc Tran on 4/17/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import UIKit
import GoogleMobileAds

class PDFViewController: UIViewController, GADBannerViewDelegate {
    
    var bannerView = GADBannerView()
    
    
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
        
        initAdMobBanner()

    }
    func initAdMobBanner(){
        bannerView.adSize = GADAdSizeFromCGSize(CGSize(width: 320, height: 50))
        bannerView.frame = CGRect(x: 0, y: view.bounds.size.height, width: 320, height: 50)
        bannerView.adUnitID = "ca-app-pub-7384215319654531/6555347808"
        bannerView.rootViewController = self
        bannerView.delegate = self
        view.addSubview(bannerView)
        let request = GADRequest()
        bannerView.load(request)
        
    }
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
}
