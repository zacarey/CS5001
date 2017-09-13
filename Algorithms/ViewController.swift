//
//  ViewController.swift
//  Chess
//
//  Created by Tuuu on 3/8/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import UIKit
import AVFoundation
import KDPulseButton

class ViewController: UIViewController, UITextFieldDelegate {
  

    var gamemanager: GameManager!
    var mainViewSize = CGSize()
    var sizeBoard:UITextField!
    var spacing:CGFloat!
    var widthRatio = 3
    var btnSizeWidth:CGFloat!
    var btnSizeHeight:CGFloat!
    var x:CGFloat!
    var btn: UIButton!
    var btnReset: UIButton!
    var btnPauseAction: UIButton!
    var btnStart: UIButton!
    var btnNext: UIButton!
    var lblNoteText:UILabel!

    
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
        
        self.hideKeyboardWhenTappedAround()
        
        spacing = view.bounds.size.width/CGFloat(widthRatio*3 + 4)
        btnSizeWidth = spacing*CGFloat(widthRatio)
        btnSizeHeight = btnSizeWidth*3/5
        x = 2*spacing + btnSizeWidth

        view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)

        super.viewDidLoad()
        self.gamemanager = GameManager()
        btnSizeBoard()
        addSizeBoard()
        addReset()
        btnPause()
        addBtnNext()
        addBtnMove()
        addNoteStart()
        
        btnStart.isUserInteractionEnabled = false
        btnReset.isUserInteractionEnabled = false
        btnNext.isUserInteractionEnabled = false
        
//        self.gamemanager.initGameWith(viewcontroller: self, size: self.view.bounds.size.width)

        sizeBoard.delegate = self
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Find out what the text field will be after adding the current edit
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if Int(text) != nil {
            
            // Text field converted to an Int
            
            btn.isEnabled = true
        } else {
            // Text field is not an Int
            btn.isEnabled = false
        }
        
        // Return true so the text field will be changed
        return true
    }
    
    func addAlert(message: String){
        let alert = UIAlertController.init(title: "Warning",
                                           message: message,
                                           preferredStyle: .alert)
        
        let defaultAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func draw(sender: UIButton){
          if(sizeBoard.text != "" && sizeBoard.text != nil){
            if (Int(sizeBoard.text!)! <= 10){
                if (Int(sizeBoard.text!)! >= 4 ){
                    self.btnNext.isUserInteractionEnabled = true
                    self.btnStart.isUserInteractionEnabled = true
                    lblNoteText.isHidden = true
                    btnStart.isHidden = false
                    btnPauseAction.isHidden = true
//                    self.gamemanager.boardView.removeFromSuperview()
//                    self.btnStart.isHidden = true
//                    self.gamemanager.lblSolutionFound.isHidden = true
                    self.gamemanager.rowTotal = Int(self.sizeBoard.text!)!
                    self.gamemanager.colTotal = Int(self.sizeBoard.text!)!
                    self.gamemanager.initGameWith(viewcontroller: self, size: self.view.bounds.size.width)
                    btn.isHidden = true
                    sizeBoard.isHidden = true
                    btnReset.isUserInteractionEnabled = true
                }else{
                    
                addAlert(message: "Can not enter less than 10 digits")
                }
            }else{
                
                addAlert(message: "Can not enter more than 4 digits")
            }
        }
          else{
            addAlert(message: "Please enter a number")
        }
        sizeBoard.text = ""
    }
    func addNoteStart(){
        lblNoteText = UILabel(frame: CGRect(x: view.bounds.size.width/2 - 100, y: view.bounds.size.height/2 - 50, width: 200, height: 30))
        lblNoteStartTmp = lblNoteText
        lblNoteText.text = "Enter the board size"
        lblNoteText.textAlignment = .center
        view.addSubview(lblNoteText)
    }

    
    func btnSizeBoard(){
        btn = KDPulseButton(frame: CGRect(x: view.bounds.size.width/2 + spacing/2, y: view.bounds.size.height/2, width: btnSizeWidth, height: btnSizeHeight))
        btnSizeBoardTmp = btn
        btn.layer.backgroundColor = LIME_COLOR.cgColor
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.setTitle("\u{23CE}", for: .normal)
        btn.titleLabel?.font = UIFont.fontAwesome(ofSize: btn.fontoFitHeight())
        btn.setTitleColor(BUTTON_COLOR, for: .normal)
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.titleLabel?.numberOfLines = 0
        btn.titleLabel?.minimumScaleFactor = 0.2
        btn.titleLabel?.lineBreakMode = NSLineBreakMode.byClipping
        btn.titleLabel?.baselineAdjustment = .alignCenters
        btn.titleLabel?.textAlignment = .center
        btn.layer.borderWidth = 2
        btn.layer.borderColor = BUTTON_COLOR.cgColor
        btn.layer.cornerRadius = 10

        btn.addTarget(self, action: #selector(draw(sender:)), for: .touchUpInside)
        view.addSubview(btn)
    }

    func addSizeBoard(){
        sizeBoard = UITextField(frame: CGRect(x: view.bounds.size.width/2 - spacing/2 - btnSizeWidth, y: view.bounds.size.height/2, width: btnSizeWidth, height: btnSizeHeight))
        textInPutBoard = sizeBoard
        
        
        sizeBoard.placeholder = "........................."
        sizeBoard.font = UIFont.boldSystemFont(ofSize: 15)
        sizeBoard.borderStyle = UITextBorderStyle.roundedRect
        sizeBoard.autocorrectionType = UITextAutocorrectionType.no
        sizeBoard.keyboardType = UIKeyboardType.numberPad
        sizeBoard.returnKeyType = UIReturnKeyType.done
        sizeBoard.clearButtonMode = UITextFieldViewMode.whileEditing
        sizeBoard.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        sizeBoard.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        sizeBoard.layer.cornerRadius = 10
        sizeBoard.layer.borderWidth = 2
        sizeBoard.layer.borderColor = UIColor.black.cgColor
        sizeBoard.layer.masksToBounds = true
        
        view.addSubview(sizeBoard)
    }
    
    func addReset(){
        btnReset = KDPulseButton(frame: CGRect(x: spacing, y: view.bounds.size.height-spacing-btnSizeHeight, width: btnSizeWidth, height: btnSizeHeight))
        btnResetTmp = btnReset
        btnReset.layer.backgroundColor = LIME_COLOR.cgColor
        btnReset.setTitleColor(UIColor.white, for: UIControlState.normal)
        btnReset.setTitle("\u{f021}", for: .normal)
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
        
        btnReset.addTarget(self.gamemanager, action: #selector(self.gamemanager.reset(sender:)), for: .touchUpInside)
        view.addSubview(btnReset)
    }
    
    func btnPause(){
        
        btnPauseAction = KDPulseButton(frame: CGRect(x: 2*x-spacing, y: view.bounds.size.height-spacing-btnSizeHeight, width: btnSizeWidth, height: btnSizeHeight))
        
        btnPauseActionTmp = btnPauseAction
        
        btnPauseAction.layer.backgroundColor = LIME_COLOR.cgColor
        btnPauseAction.setTitleColor(UIColor.white, for: UIControlState.normal)
        btnPauseAction.setTitle("\u{f04c}", for: .normal)
        
        btnPauseAction.setTitleColor(BUTTON_COLOR, for: .normal)
        btnPauseAction.titleLabel?.font = UIFont.fontAwesome(ofSize: btnPauseAction.fontoFitHeight())
        btnPauseAction.titleLabel?.adjustsFontSizeToFitWidth = true
        btnPauseAction.titleLabel?.numberOfLines = 0
        btnPauseAction.titleLabel?.minimumScaleFactor = 0.2
        btnPauseAction.titleLabel?.lineBreakMode = NSLineBreakMode.byClipping
        btnPauseAction.titleLabel?.baselineAdjustment = .alignCenters
        btnPauseAction.titleLabel?.textAlignment = .center
        
        btnPauseAction.layer.borderWidth = 2
        btnPauseAction.layer.borderColor = BUTTON_COLOR.cgColor
        btnPauseAction.layer.cornerRadius = 10
        
        btnPauseAction.addTarget(self.gamemanager, action: #selector(self.gamemanager.action_Pause(_:)), for: .touchUpInside)
        view.addSubview(btnPauseAction)
        
    }
    
    func addBtnMove()
    {
        btnStart = KDPulseButton(frame: CGRect(x: 2*x-spacing, y: view.bounds.size.height-spacing-btnSizeHeight, width: btnSizeWidth, height: btnSizeHeight))
        btnStartTmp = btnStart
        btnStart.layer.backgroundColor = LIME_COLOR.cgColor
        btnStart.setTitleColor(UIColor.white, for: UIControlState.normal)
        btnStart.setTitle("\u{f144}", for: .normal)
        btnStart.titleLabel?.font = UIFont.fontAwesome(ofSize: btnStart.fontoFitHeight())
        btnStart.setTitleColor(BUTTON_COLOR, for: .normal)
        btnStart.titleLabel?.adjustsFontSizeToFitWidth = true
        btnStart.titleLabel?.numberOfLines = 0
        btnStart.titleLabel?.minimumScaleFactor = 0.2
        btnStart.titleLabel?.lineBreakMode = NSLineBreakMode.byClipping
        btnStart.titleLabel?.baselineAdjustment = .alignCenters
        btnStart.titleLabel?.textAlignment = .center
        btnStart.layer.borderWidth = 2
        btnStart.layer.borderColor = BUTTON_COLOR.cgColor
        btnStart.layer.cornerRadius = 10
        btnStart.addTarget(self.gamemanager, action: #selector(self.gamemanager.move(sender:)), for: .touchUpInside)
        view.addSubview(btnStart)
    }
    
    func addBtnNext(){
        btnNext = KDPulseButton(frame: CGRect(x: x, y: view.bounds.size.height-spacing-btnSizeHeight, width: btnSizeWidth, height: btnSizeHeight))
        btnNextTmp = btnNext
        btnNext.layer.backgroundColor = LIME_COLOR.cgColor
        btnNext.setTitleColor(UIColor.white, for: UIControlState.normal)
        btnNext.setTitle("\u{f051}", for: .normal)
        btnNext.setTitleColor(BUTTON_COLOR, for: .normal)
        btnNext.titleLabel?.font = UIFont.fontAwesome(ofSize: btnNext.fontoFitHeight())
        btnNext.titleLabel?.adjustsFontSizeToFitWidth = true
        btnNext.titleLabel?.numberOfLines = 0
        btnNext.titleLabel?.minimumScaleFactor = 0.2
        btnNext.titleLabel?.lineBreakMode = NSLineBreakMode.byClipping
        btnNext.titleLabel?.baselineAdjustment = .alignCenters
        btnNext.titleLabel?.textAlignment = .center
        
        btnNext.layer.borderWidth = 2
        btnNext.layer.borderColor = BUTTON_COLOR.cgColor
        btnNext.layer.cornerRadius = 10
        
        btnNext.addTarget(self.gamemanager, action: #selector(self.gamemanager.next(sender:)), for: .touchUpInside)
        view.addSubview(btnNext)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}


