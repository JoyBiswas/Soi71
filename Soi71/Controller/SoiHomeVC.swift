//
//  SoiHomeVC.swift
//  Soi71
//
//  Created by RIO on 7/21/18.
//  Copyright © 2018 RIO. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn



class SoiHomeVC: UIViewController,GIDSignInUIDelegate{
    
    @IBOutlet weak var menuButton: UIButton!
    
    @IBOutlet weak var menuWidth: NSLayoutConstraint!
    
    @IBOutlet weak var menuView: UIView!
    var menuShow = false
    
    @IBOutlet weak var aboutusBTN: UIButton!
    
    @IBOutlet weak var accountBTn: UIButton!

    
    
    @IBOutlet weak var menuViewBTN: UIButton!
    
    @IBOutlet weak var saleMenuBtn: UIButton!
    @IBOutlet weak var menuCategoriesBTN: UIButton!
    
    @IBOutlet weak var reservationBTN: UIButton!
    
    @IBOutlet weak var ordersBTn: UIButton!
    
    @IBOutlet weak var contactBTn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuWidth.constant = 0

        // Do any additional setup after loading the view.
        self.saleMenuBtn.isHidden = true
        self.menuCategoriesBTN.isHidden = true
        self.reservationBTN.isHidden = true
        GIDSignIn.sharedInstance().uiDelegate = self
       
       // self.mostDownload()
    }

    

    @IBAction func menuButtonTapped(_ sender: Any) {
        self.manuBtn()
        
        
    }
     func manuBtn() {
        let btnBgColor = UIColor(rgb: 0x222222)
        if(menuShow)
        {
            menuWidth.constant = 0
            menuButton.backgroundColor = btnBgColor
            self.saleMenuBtn.isHidden = true
            self.menuCategoriesBTN.isHidden = true
            self.reservationBTN.isHidden = true
            handelanimation()
            
        }
        else{
            menuWidth.constant = 160
            menuButton.backgroundColor = nil
            self.saleMenuBtn.isHidden = false
            self.menuCategoriesBTN.isHidden = false
            self.reservationBTN.isHidden = false
            handelanimationForMenuShow()
            
            
        }
        menuShow = !menuShow
    }
    
    func handelanimationForMenuShow()
    {
        UIView.animate(withDuration: 0.9, animations: {
            self.view.layoutIfNeeded()
        })
        
        
        
    }
    func handelanimation()
    {
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        })
        
        
        
    }
    
    @IBAction func fbLoginBtnTapped(_ sender: Any) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                // if user cancel the login
                if (result?.isCancelled)!{
                    return
                }
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                }
            }
        }
    }
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    //everything works print the user data
                    print(result as Any)
                }
            })
        }
    }
    

    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        
    }
    
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func googleSignButtonTapped(_ sender: Any) {
        
        GIDSignIn.sharedInstance().signIn()
        
    }
  
    
}
