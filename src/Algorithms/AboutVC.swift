//
//  AboutVC.swift

//  Algorithms
//
//  Created by Loc Tran on 4/18/17.
//  Copyright © 2017 LocTran. All rights reserved.

//

import UIKit

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

class AboutVC: UIViewController {
    
    @IBOutlet weak var locTxtView: UITextView!
    
    @IBOutlet weak var tungTxtView: UITextView!
    
    @IBOutlet weak var khanhTxtView: UITextView!
    
    @IBOutlet weak var dungTxtView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)

        addLabel()

        // Do any additional setup after loading the view.
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        AppUtility.lockOrientation(.portrait)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Don't forget to reset when view is being removed
        AppUtility.lockOrientation(.all)
    }

    func addLabel(){
        
        locTxtView.layer.borderWidth = 2
        locTxtView.layer.borderColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1).cgColor
        locTxtView.layer.cornerRadius = 10
        locTxtView.layer.masksToBounds = false
        locTxtView.clipsToBounds = true
        
        tungTxtView.layer.borderWidth = 2
        tungTxtView.layer.borderColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1).cgColor
        tungTxtView.layer.cornerRadius = 10
        tungTxtView.layer.masksToBounds = false
        tungTxtView.clipsToBounds = true
        
        dungTxtView.layer.borderWidth = 2
        dungTxtView.layer.borderColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1).cgColor
        dungTxtView.layer.cornerRadius = 10
        dungTxtView.layer.masksToBounds = false
        dungTxtView.clipsToBounds = true
        
        khanhTxtView.layer.borderWidth = 2
        khanhTxtView.layer.borderColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1).cgColor
        khanhTxtView.layer.cornerRadius = 10
        khanhTxtView.layer.masksToBounds = false
        khanhTxtView.clipsToBounds = true
        
        
        locTxtView.backgroundColor = UIColor.white
        tungTxtView.backgroundColor = UIColor.white
        dungTxtView.backgroundColor = UIColor.white
        khanhTxtView.backgroundColor = UIColor.white        
        
//        locTxtView.text = "Loc Tran \nhttps://www.linkedin.com/in/loc-tran-cs/"

    }

}
