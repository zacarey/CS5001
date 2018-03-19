//
//  ViewController.swift
//  Algorithms
//
//  Created by Loc Tran on 4/5/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import UIKit
import KDPulseButton

struct AppUtility {
    
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }
    
    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
        self.lockOrientation(orientation)
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
    }
}

class StudyVC: UIViewController {
    
    var spacing:CGFloat!
    var widthRatio = 3
    var btnSizeWidth:CGFloat!
    var btnSizeHeight:CGFloat!
    var x:CGFloat!
    var btnReset:UIButton!
    var btnInfo:UIButton!
    var btnStep:UIButton!
    var btnRun:UIButton!
    var btnAdd:UIButton!
    var btnStepBig: UIButton!
    
    
    var y: CGFloat!
    
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
        
        self.view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
        spacing = view.bounds.size.width/CGFloat(widthRatio*3 + 4)
        btnSizeWidth = spacing*CGFloat(widthRatio)
        btnSizeHeight = btnSizeWidth*3/5
        y = view.bounds.size.height - spacing * 2 - btnSizeHeight
        yMax = y
        x = 2*spacing + btnSizeWidth
        
        addBtnReset()
        addBtnStep()
        addBtnRun()
        addBtnStepBig()
        btnStepBig.isHidden = true
        
        addReadingButton()
        addHomeButton()
        
//        VIEW_CHOSEN = "study"
        
    }
    
    func addBtnReset() {
        btnReset = KDPulseButton(frame: CGRect(x: spacing, y: view.bounds.size.height-spacing-btnSizeHeight, width: btnSizeWidth, height: btnSizeHeight))
        
        btnReset.layer.backgroundColor = LIME_COLOR.cgColor
        btnReset.setTitle("\u{f021}", for: .normal)
        btnReset.setTitleColor(UIColor.white, for: UIControlState.normal)
        btnReset.titleLabel?.font = UIFont.fontAwesome(ofSize: btnReset.fontoFitHeight())
        btnReset.setTitleColor(BUTTON_COLOR, for: .normal)
        btnReset.titleLabel?.adjustsFontSizeToFitWidth = true
        btnReset.titleLabel?.numberOfLines = 0
        btnReset.titleLabel?.minimumScaleFactor = 0.2
        btnReset.titleLabel?.lineBreakMode = NSLineBreakMode.byClipping
        btnReset.titleLabel?.baselineAdjustment = .alignCenters
        btnReset.titleLabel?.textAlignment = .center
        btnReset.layer.borderWidth = 2
        btnReset.layer.borderColor = BUTTON_COLOR.cgColor
        btnReset.layer.cornerRadius = 10
        
        view.addSubview(btnReset)
    }
    
    
    
    
    func addBtnStep() {
        
        btnStep = KDPulseButton(frame: CGRect(x: x, y: view.bounds.size.height-spacing-btnSizeHeight, width: btnSizeWidth, height: btnSizeHeight))
        
        btnStepTmp = btnStep
        
        btnStep.layer.backgroundColor = LIME_COLOR.cgColor
        btnStep.setTitleColor(UIColor.white, for: UIControlState.normal)
        btnStep.setTitle("\u{f051}", for: .normal)
        
        
        btnStep.titleLabel?.textColor = UIColor.white
        btnStep.titleLabel?.font = UIFont.fontAwesome(ofSize: btnStep.fontoFitHeight())
        btnStep.setTitleColor(BUTTON_COLOR, for: .normal)
        btnStep.titleLabel?.adjustsFontSizeToFitWidth = true
        btnStep.titleLabel?.numberOfLines = 0
        btnStep.titleLabel?.minimumScaleFactor = 0.2
        btnStep.titleLabel?.lineBreakMode = NSLineBreakMode.byClipping
        
        btnStep.titleLabel?.baselineAdjustment = .alignCenters
        btnStep.titleLabel?.textAlignment = .center
        
        btnStep.layer.borderWidth = 2
        btnStep.layer.borderColor = BUTTON_COLOR.cgColor
        btnStep.layer.cornerRadius = 10
        
        
        view.addSubview(btnStep)
    }
    
    func addBtnRun() {
        
        btnRun = KDPulseButton(frame: CGRect(x: 2*x-spacing, y: view.bounds.size.height-spacing-btnSizeHeight, width: btnSizeWidth, height: btnSizeHeight))
        
        btnRunTmp = btnRun
        
        btnRun.layer.backgroundColor = LIME_COLOR.cgColor
        btnRun.setTitleColor(UIColor.white, for: UIControlState.normal)
        btnRun.setTitle("\u{f144}", for: .normal)
        btnRun.setTitleColor(BUTTON_COLOR, for: .normal)
        btnRun.titleLabel?.font = UIFont.fontAwesome(ofSize: btnRun.fontoFitHeight())
        btnRun.titleLabel?.adjustsFontSizeToFitWidth = true
        btnRun.titleLabel?.numberOfLines = 0
        btnRun.titleLabel?.minimumScaleFactor = 0.2
        btnRun.titleLabel?.lineBreakMode = NSLineBreakMode.byClipping
        btnRun.titleLabel?.baselineAdjustment = .alignCenters
        btnRun.titleLabel?.textAlignment = .center
        
        btnRun.layer.borderWidth = 2
        btnRun.layer.borderColor = BUTTON_COLOR.cgColor
        btnRun.layer.cornerRadius = 10
        
        
        view.addSubview(btnRun)
    }
    
    func addBtnStepBig() {
        
        btnStepBig = KDPulseButton(frame: CGRect(x: x, y: view.bounds.size.height-spacing-btnSizeHeight, width: btnSizeWidth*2 + spacing, height: btnSizeHeight))
        
        btnStepBigTmp = btnStepBig
        btnStepBig.layer.backgroundColor = LIME_COLOR.cgColor
        btnStepBig.setTitleColor(UIColor.white, for: UIControlState.normal)
        btnStepBig.setTitle("\u{f051}", for: .normal)
        btnStepBig.setTitleColor(BUTTON_COLOR, for: .normal)
        btnStepBig.titleLabel?.font = UIFont.fontAwesome(ofSize: btnStepBig.fontoFitHeight())
        btnStepBig.titleLabel?.adjustsFontSizeToFitWidth = true
        btnStepBig.titleLabel?.numberOfLines = 0
        btnStepBig.titleLabel?.minimumScaleFactor = 0.2
        btnStepBig.titleLabel?.lineBreakMode = NSLineBreakMode.byClipping
        btnStepBig.titleLabel?.baselineAdjustment = .alignCenters
        btnStepBig.titleLabel?.textAlignment = .center
        
        btnStepBig.layer.borderWidth = 2
        btnStepBig.layer.borderColor = BUTTON_COLOR.cgColor
        btnStepBig.layer.cornerRadius = 10
        
        view.addSubview(btnStepBig)
        
    }

    func addReadingButton(){
        let readingButton = UIBarButtonItem(image: #imageLiteral(resourceName: "book"), style: .plain, target: self, action: #selector(pushToReadingVC(sender:)))
        readingButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = readingButton
    }
    
    @objc func pushToReadingVC(sender: UIBarButtonItem) {
        let readingVC = PDFViewController() as UIViewController
        self.navigationController?.pushViewController(readingVC, animated: true)
    }
    
    func addHomeButton(){
        let homeButton = UIBarButtonItem(image: #imageLiteral(resourceName: "home"), style: .plain, target: self, action: #selector(popToRootView(sender:)))
        homeButton.tintColor = UIColor.white
        
        self.navigationItem.leftBarButtonItem = homeButton
    }
    
    @objc func popToRootView(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

