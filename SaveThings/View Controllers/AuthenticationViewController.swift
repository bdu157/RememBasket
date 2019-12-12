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
    
    var isScattered: Bool = true
    
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
        //self.addLabelLocations()
        self.setUpLabels()
        self.scatterLetters()
        
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
        self.authenticationButton.setTitleColor(.white, for: .normal)
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
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: "Pleas type device password") { (success, error) in
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
        
        //add performandwait for 2 seconds and excute above after animation is done
        /*
        if isScattered == true {
        self.scatterLetters()
        } else {
        self.gatherLetters()
        }
         */
    }
    
    
    //scatter part
    func scatterLetters() {
        
        let animBlock = {
            
            //alpha
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.3) {
                self.labelS.alpha = 1.0
                self.labelA.alpha = 1.0
                self.labelV.alpha = 1.0
                self.labelE.alpha = 1.0
                self.labelT.alpha = 1.0
                self.labelH.alpha = 1.0
                self.labelI.alpha = 1.0
                self.labelN.alpha = 1.0
                self.labelG.alpha = 1.0
                self.labelSecondS.alpha = 1.0
            }
            
            
            //rotation
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.3) {
                self.labelS.transform = CGAffineTransform(rotationAngle: CGFloat(Int.random(in: -360...360)))
                self.labelA.transform = CGAffineTransform(rotationAngle: CGFloat(Int.random(in: -360...360)))
                self.labelV.transform = CGAffineTransform(rotationAngle: CGFloat(Int.random(in: -360...360)))
                self.labelE.transform = CGAffineTransform(rotationAngle: CGFloat(Int.random(in: -360...360)))
                self.labelT.transform = CGAffineTransform(rotationAngle: CGFloat(Int.random(in: -360...360)))
                self.labelH.transform = CGAffineTransform(rotationAngle: CGFloat(Int.random(in: -360...360)))
                self.labelI.transform = CGAffineTransform(rotationAngle: CGFloat(Int.random(in: -360...360)))
                self.labelN.transform = CGAffineTransform(rotationAngle: CGFloat(Int.random(in: -360...360)))
                self.labelG.transform = CGAffineTransform(rotationAngle: CGFloat(Int.random(in: -360...360)))
                self.labelSecondS.transform = CGAffineTransform(rotationAngle: CGFloat(Int.random(in: -360...360)))
            }
            
            //position
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.6) {
                self.labelS.layer.position = CGPoint(x: Int.random(in: 0...300), y: Int.random(in: 0...700))
                self.labelA.layer.position = CGPoint(x: Int.random(in: 0...300), y: Int.random(in: 0...700))
                self.labelV.layer.position = CGPoint(x: Int.random(in: 0...300), y: Int.random(in: 0...700))
                self.labelE.layer.position = CGPoint(x: Int.random(in: 0...300), y: Int.random(in: 0...700))
                self.labelT.layer.position = CGPoint(x: Int.random(in: 0...300), y: Int.random(in: 0...700))
                self.labelH.layer.position = CGPoint(x: Int.random(in: 0...300), y: Int.random(in: 0...700))
                self.labelI.layer.position = CGPoint(x: Int.random(in: 0...300), y: Int.random(in: 0...700))
                self.labelN.layer.position = CGPoint(x: Int.random(in: 0...300), y: Int.random(in: 0...700))
                self.labelG.layer.position = CGPoint(x: Int.random(in: 0...300), y: Int.random(in: 0...700))
                self.labelSecondS.layer.position = CGPoint(x: Int.random(in: 0...300), y: Int.random(in: 0...700))
            }
        
            //color - textColor
            UIView.addKeyframe(withRelativeStartTime: 1.0, relativeDuration: 0.6) {
                self.labelS.textColor = UIColor(red: CGFloat(Int.random(in: 0...255)) / 255.0, green: CGFloat(Int.random(in: 0...255)) / 255.0, blue: CGFloat(Int.random(in: 0...255)) / 255.0, alpha: 1)
               self.labelA.textColor = UIColor(red: CGFloat(Int.random(in: 0...255)) / 255.0, green: CGFloat(Int.random(in: 0...255)) / 255.0, blue: CGFloat(Int.random(in: 0...255)) / 255.0, alpha: 1)
                self.labelV.textColor = UIColor(red: CGFloat(Int.random(in: 0...255)) / 255.0, green: CGFloat(Int.random(in: 0...255)) / 255.0, blue: CGFloat(Int.random(in: 0...255)) / 255.0, alpha: 1)
                self.labelE.textColor = UIColor(red: CGFloat(Int.random(in: 0...255)) / 255.0, green: CGFloat(Int.random(in: 0...255)) / 255.0, blue: CGFloat(Int.random(in: 0...255)) / 255.0, alpha: 1)
                self.labelT.textColor = UIColor(red: CGFloat(Int.random(in: 0...255)) / 255.0, green: CGFloat(Int.random(in: 0...255)) / 255.0, blue: CGFloat(Int.random(in: 0...255)) / 255.0, alpha: 1)
                self.labelH.textColor = UIColor(red: CGFloat(Int.random(in: 0...255)) / 255.0, green: CGFloat(Int.random(in: 0...255)) / 255.0, blue: CGFloat(Int.random(in: 0...255)) / 255.0, alpha: 1)
                self.labelI.textColor = UIColor(red: CGFloat(Int.random(in: 0...255)) / 255.0, green: CGFloat(Int.random(in: 0...255)) / 255.0, blue: CGFloat(Int.random(in: 0...255)) / 255.0, alpha: 1)
                self.labelN.textColor = UIColor(red: CGFloat(Int.random(in: 0...255)) / 255.0, green: CGFloat(Int.random(in: 0...255)) / 255.0, blue: CGFloat(Int.random(in: 0...255)) / 255.0, alpha: 1)
                self.labelG.textColor = UIColor(red: CGFloat(Int.random(in: 0...255)) / 255.0, green: CGFloat(Int.random(in: 0...255)) / 255.0, blue: CGFloat(Int.random(in: 0...255)) / 255.0, alpha: 1)
                self.labelSecondS.textColor = UIColor(red: CGFloat(Int.random(in: 0...255)) / 255.0, green: CGFloat(Int.random(in: 0...255)) / 255.0, blue: CGFloat(Int.random(in: 0...255)) / 255.0, alpha: 1)
            }
            
            //color - backgroundColor
            /*
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.6) {
                self.labelS.backgroundColor = UIColor(red: CGFloat(Int.random(in: 0...255)) / 255.0, green: CGFloat(Int.random(in: 0...255)) / 255.0, blue: CGFloat(Int.random(in: 0...255)) / 255.0, alpha: 0.6)
                self.labelA.backgroundColor = UIColor(red: CGFloat(Int.random(in: 0...255)) / 255.0, green: CGFloat(Int.random(in: 0...255)) / 255.0, blue: CGFloat(Int.random(in: 0...255)) / 255.0, alpha: 0.6)
                self.labelV.backgroundColor = UIColor(red: CGFloat(Int.random(in: 0...255)) / 255.0, green: CGFloat(Int.random(in: 0...255)) / 255.0, blue: CGFloat(Int.random(in: 0...255)) / 255.0, alpha: 0.6)
                self.labelE.backgroundColor = UIColor(red: CGFloat(Int.random(in: 0...255)) / 255.0, green: CGFloat(Int.random(in: 0...255)) / 255.0, blue: CGFloat(Int.random(in: 0...255)) / 255.0, alpha: 0.6)
                self.labelT.backgroundColor = UIColor(red: CGFloat(Int.random(in: 0...255)) / 255.0, green: CGFloat(Int.random(in: 0...255
                )) / 255.0, blue: CGFloat(Int.random(in: 0...255)) / 255.0, alpha: 0.6)
                self.labelH.backgroundColor = UIColor(red: CGFloat(Int.random(in: 0...255)) / 255.0, green: CGFloat(Int.random(in: 0...255)) / 255.0, blue: CGFloat(Int.random(in: 0...255)) / 255.0, alpha: 0.6)
                self.labelI.backgroundColor = UIColor(red: CGFloat(Int.random(in: 0...255)) / 255.0, green: CGFloat(Int.random(in: 0...255)) / 255.0, blue: CGFloat(Int.random(in: 0...255)) / 255.0, alpha: 0.6)
                self.labelN.backgroundColor = UIColor(red: CGFloat(Int.random(in: 0...255)) / 255.0, green: CGFloat(Int.random(in: 0...255)) / 255.0, blue: CGFloat(Int.random(in: 0...255)) / 255.0, alpha: 0.6)
                self.labelG.backgroundColor = UIColor(red: CGFloat(Int.random(in: 0...255)) / 255.0, green: CGFloat(Int.random(in: 0...255)) / 255.0, blue: CGFloat(Int.random(in: 0...255)) / 255.0, alpha: 0.6)
                self.labelSecondS.backgroundColor = UIColor(red: CGFloat(Int.random(in: 0...255)) / 255.0, green: CGFloat(Int.random(in: 0...255)) / 255.0, blue: CGFloat(Int.random(in: 0...255)) / 255.0, alpha: 0.6)
            }
            */
            
        }
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: [], animations: animBlock, completion: nil)
        isScattered = false
    }
    
    //gather
    func gatherLetters() {
        //rotation reset
        UIView.animate(withDuration: 1.0, animations: {
            self.labelS.transform = .identity
            self.labelA.transform = .identity
            self.labelV.transform = .identity
            self.labelE.transform = .identity
            self.labelT.transform = .identity
            self.labelH.transform = .identity
            self.labelI.transform = .identity
            self.labelN.transform = .identity
            self.labelG.transform = .identity
            self.labelSecondS.transform = .identity
        }, completion: nil)
        
        
        //position reset - x and y
        //color reset - backgroundColor/textColor
        let labels = [labelS, labelA, labelV, labelE, labelT, labelH, labelI, labelN, labelG, labelSecondS]
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveLinear, animations: {
                var index = 0
            for x in labels {
                guard let label = x else {return}
                
                label.alpha = 1
                
                label.layer.shadowOpacity = 1.0
                label.layer.shadowOffset = CGSize.zero
                label.layer.shadowColor = UIColor.darkGray.cgColor
                label.backgroundColor = .clear
                
                label.center = self.labelLocations[index]
                index += 1
                
            }
        }, completion: nil)
        self.isScattered = true
    }
    
    //Private method
//    private func addLabelLocations() {
//        let labels = [labelS, labelA, labelV, labelE, labelT, labelH, labelI, labelN, labelG, labelSecondS]
//        for x in labels {
//            guard let label = x else {return}
//            self.labelLocations.append(label.center)
//        }
//    }

    private func setUpLabels() {
        let labelss = [labelS, labelA, labelV, labelE, labelT, labelH, labelI, labelN, labelG, labelSecondS]
        for y in labelss {
            guard let label = y else {return}
            self.labelLocations.append(label.center)
            label.layer.shadowOpacity = 1.0
            label.layer.shadowOffset = CGSize.zero
            label.layer.shadowColor = UIColor.darkGray.cgColor
            label.backgroundColor = .clear
            label.alpha = 0.0
        }
    }
    
    @IBAction func gatherButton(_ sender: Any) {
        self.gatherLetters()
    }
    
    
}
