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
    
    //MARK: Properties and Outlets
    @IBOutlet weak var authenticationButton: UIButton!
    @IBOutlet weak var faceortouchIDImageView: UIImageView!
    @IBOutlet weak var saveThingsButtonView: UIView!
    
    //SAVETHINGS Labels
    @IBOutlet weak var labelS: UILabel!
    @IBOutlet weak var labelA: UILabel!
    @IBOutlet weak var labelV: UILabel!
    @IBOutlet weak var labelE: UILabel!
    
    @IBOutlet weak var labelT: UILabel!
    @IBOutlet weak var labelH: UILabel!
    @IBOutlet weak var labelI: UILabel!
    @IBOutlet weak var labelN: UILabel!
    @IBOutlet weak var labelG: UILabel!
    @IBOutlet weak var labelSecondS: UILabel!
    
    var labelLocations : [CGPoint] = []
    
    let myContext: LAContext = LAContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLabels()
        setUpAuthenticationImage()
        setUpButtonUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //show this if auto face id is checked
        self.autoFaceID()
    }
    
    //MARK: Enable Auto face ID/ touch ID
    private func autoFaceID() {
        let context:LAContext = LAContext()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: "Pleas type device password") { (success, error) in
                if success {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: {
                        self.performSegue(withIdentifier: "toPasswordTableVC", sender: self)
                    })
                    //use userdefault to automatically run this part as soon as the app launches within viewDidLoad - option for auto authentication in Settings Tab
                    print("good")
                } else {
                    print("no authentication")
                }
            }
        } else {
            print("your device does not support biometrics")
        }
    }
    
    //MARK: Private methods Set Ups
    private func setUpLabels() {
        let labels = [labelS, labelA, labelV, labelE, labelT, labelH, labelI, labelN, labelG, labelSecondS]
        for y in labels {
            guard let label = y else {return}
            label.alpha = 0
            label.layer.shadowOpacity = 1.0
            label.layer.shadowOffset = CGSize.zero
            label.layer.shadowColor = UIColor.darkGray.cgColor
            label.backgroundColor = .clear
            self.labelLocations.append(label.center)
        }
        DispatchQueue.main.async {
            self.scatterLetters()
        }
    }
    
    private func setUpAuthenticationImage() {
        if myContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) {
            if myContext.biometryType == .faceID {
                faceortouchIDImageView.image = UIImage(named: "faceID")
            } else if myContext.biometryType == .touchID {
                faceortouchIDImageView.image = UIImage(named: "touchID")
            } else {
                faceortouchIDImageView.image = UIImage(named: "none")
            }
        }
    }
    
    private func setUpButtonUI() {
        self.saveThingsButtonView.shapeSaveThingsButtonView()
        self.authenticationButton.setTitleColor(.white, for: .normal)
        self.authenticationButton.layer.shadowOpacity = 1.0
        self.authenticationButton.layer.shadowOffset = CGSize.zero
        self.authenticationButton.layer.shadowColor = UIColor.gray.cgColor
        self.authenticationButton.layer.cornerRadius = 10
    }
    
    
    //MARK: Start Saving Things Button Action
    @IBAction func buttonTapped(_ sender: Any) {
        let context:LAContext = LAContext()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: "Pleas type device password") { (success, error) in
                if success {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: {
                        self.performSegue(withIdentifier: "toPasswordTableVC", sender: self)
                    })
                    //use userdefault to automatically run this part as soon as the app launches within viewDidLoad - option for auto authentication in Settings Tab
                    print("good")
                } else {
                    print("no authentication")
                }
            }
        } else {
            print("your device does not support biometrics")
        }
    }
    
    
    //Scatter Animation
    func scatterLetters() {
        
        let animBlock = {
            
            //alpha
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.6) {
                
                self.labelS.alpha = 1.0
                self.labelA.alpha = 1.0
                self.labelV.alpha = 1.0
                self.labelE.alpha = 1.0
                self.labelT.alpha = 1.0
                self.labelH.alpha = 1.0
                self.labelI.alpha = 1.0
                self.labelN.alpha = 1.0
                self.labelG.alpha = 1.0
            }
            
            //rotation
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.6) {
                self.labelS.transform = CGAffineTransform(rotationAngle: CGFloat(Int.random(in: -360...360)))
                self.labelA.transform = CGAffineTransform(rotationAngle: CGFloat(Int.random(in: -360...360)))
                self.labelV.transform = CGAffineTransform(rotationAngle: CGFloat(Int.random(in: -360...360)))
                self.labelE.transform = CGAffineTransform(rotationAngle: CGFloat(Int.random(in: -360...360)))
                self.labelT.transform = CGAffineTransform(rotationAngle: CGFloat(Int.random(in: -360...360)))
                self.labelH.transform = CGAffineTransform(rotationAngle: CGFloat(Int.random(in: -360...360)))
                self.labelI.transform = CGAffineTransform(rotationAngle: CGFloat(Int.random(in: -360...360)))
                self.labelN.transform = CGAffineTransform(rotationAngle: CGFloat(Int.random(in: -360...360)))
                self.labelG.transform = CGAffineTransform(rotationAngle: CGFloat(Int.random(in: -360...360)))
            }
            
            //position
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.6) {
                self.labelS.layer.position = CGPoint(x: Int.random(in: 0...300), y: Int.random(in: 0...700))
                self.labelA.layer.position = CGPoint(x: Int.random(in: 0...300), y: Int.random(in: 0...700))
                self.labelV.layer.position = CGPoint(x: Int.random(in: 0...300), y: Int.random(in: 0...700))
                self.labelE.layer.position = CGPoint(x: Int.random(in: 0...300), y: Int.random(in: 0...700))
                self.labelT.layer.position = CGPoint(x: Int.random(in: 0...300), y: Int.random(in: 0...700))
                self.labelH.layer.position = CGPoint(x: Int.random(in: 0...300), y: Int.random(in: 0...700))
                self.labelI.layer.position = CGPoint(x: Int.random(in: 0...300), y: Int.random(in: 0...700))
                self.labelN.layer.position = CGPoint(x: Int.random(in: 0...300), y: Int.random(in: 0...700))
                self.labelG.layer.position = CGPoint(x: Int.random(in: 0...300), y: Int.random(in: 0...700))
            }
        }
        UIView.animateKeyframes(withDuration: 1.0, delay: 0, options: [], animations: animBlock, completion: {(_) in
            self.gatherLetters()
            self.secondSAnimation()
        })
    }
    
    //MARK: Gather animation as soon as scatter animation is done
    private func gatherLetters() {
        //rotation reset
        UIView.animate(withDuration: 0.6, animations: {
            self.labelS.transform = .identity
            self.labelA.transform = .identity
            self.labelV.transform = .identity
            self.labelE.transform = .identity
            self.labelT.transform = .identity
            self.labelH.transform = .identity
            self.labelI.transform = .identity
            self.labelN.transform = .identity
            self.labelG.transform = .identity
        }, completion: nil)
        
        //position reset - x and y
        //color set up
        let labels = [labelS, labelA, labelV, labelE, labelT, labelH, labelI, labelN, labelG]
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveLinear, animations: {
            var index = 0
            for x in labels {
                guard let label = x else {return}
                
                label.textColor = UIColor(red: CGFloat(Int.random(in: 0...255)) / 255.0, green: CGFloat(Int.random(in: 0...255)) / 255.0, blue: CGFloat(Int.random(in: 0...255)) / 255.0, alpha: 1)
                label.layer.shadowOpacity = 1.0
                label.layer.shadowOffset = CGSize.zero
                label.layer.shadowColor = UIColor.darkGray.cgColor
                label.backgroundColor = .clear
                label.center = self.labelLocations[index]
                index += 1
            }
        }, completion: nil)
    }
    
    private func secondSAnimation() {
        
        let animBlock = {
            
            self.labelSecondS.center = CGPoint(x: self.view.bounds.maxX - 50, y: -self.labelSecondS.bounds.size.height)
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.4, animations: {
                self.labelSecondS.center = self.labelLocations.last!
                self.labelSecondS.alpha = 1
                self.labelSecondS.textColor = UIColor(red: CGFloat(Int.random(in: 0...255)) / 255, green: CGFloat(Int.random(in: 0...255)) / 255, blue: CGFloat(Int.random(in: 1...254)) / 255, alpha: 1)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.2, animations: {
                self.labelSecondS.transform = CGAffineTransform(scaleX: 1.7, y: 0.6)
            })  //this is going to be happening at the same time as above
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.2, animations: {
                self.labelSecondS.transform = CGAffineTransform(scaleX: 0.6, y: 1.7)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.15, animations: {
                self.labelSecondS.transform = CGAffineTransform(scaleX: 1.11, y: 0.9)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.85, relativeDuration: 0.15, animations: {
                self.labelSecondS.transform = .identity
            })
            UIView.addKeyframe(withRelativeStartTime: 0.85, relativeDuration: 0.20, animations: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
                    self.saveThingsButtonAnimation()
                })
            })
        }
        UIView.animateKeyframes(withDuration: 1.0, delay: 0.0, options: [], animations: animBlock, completion: nil)
    }

    private func saveThingsButtonAnimation() {
        UIView.animate(withDuration: 0.20) {
            self.saveThingsButtonView.backgroundColor = self.labelSecondS.textColor
        }
    }
}
