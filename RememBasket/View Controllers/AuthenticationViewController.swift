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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
