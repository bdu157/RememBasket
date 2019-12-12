//
//  AuthenticationViewController.swift
//  RememBasket
//
//  Created by Dongwoo Pae on 12/11/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit
import LocalAuthentication

class AuthenticationViewController: UIViewController {

    @IBOutlet weak var authenticationButton: UIButton!
    @IBOutlet weak var faceortouchIDImageView: UIImageView!
    @IBOutlet weak var saveThingsButtonView: UIView!
    
    let myContext: LAContext = LAContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if myContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) {
            if myContext.biometryType == .faceID {
                faceortouchIDImageView.image = UIImage(named: "faceID")
            } else if myContext.biometryType == .touchID {
                faceortouchIDImageView.image = UIImage(named: "touchID")
            } else {
                faceortouchIDImageView.image = UIImage(named: "none")
            }
        }
        
        
        self.saveThingsButtonView.shapeSaveThingsButtonView()
        self.authenticationButton.layer.shadowOpacity = 1.0
        self.authenticationButton.layer.shadowOffset = CGSize.zero
        self.authenticationButton.layer.shadowColor = UIColor.gray.cgColor
        self.authenticationButton.layer.cornerRadius = 10

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func buttonTapped(_ sender: Any) {
        let context:LAContext = LAContext()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: "Message") { (success, error) in
                if success {
                    DispatchQueue.main.sync {
                        self.performSegue(withIdentifier: "toPasswordTableVC", sender: self)
                    }
                    //use userdefault to automatically run this part as soon as the app launches within viewDidLoad
                    print("good")
                } else {
                    print("no authentication")
                }
            }
        } else {
            print("your device does not support biometrics")
        }
    }
}
