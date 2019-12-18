//
//  PasswordTableViewCell.swift
//  RememBasket
//
//  Created by Dongwoo Pae on 11/23/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit
import CoreData

class PasswordTableViewCell: UITableViewCell {
    
    //MARK: Properties and Outlets
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dividerLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var LockButton: UIButton!
    
    //MARK: Private Properties
    private var logoLabel: UILabel = UILabel()
    
    let passwordController = PasswordController()
    
    var password: Password? {
        didSet {
            self.updateViews()
        }
    }
    
    var delegate: PasswordTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateViews()
          
        self.selectionStyle = .none
        self.cellView.setShadowandCornerRadius()
        self.userNameLabel.alpha = 0.0
        self.passwordLabel.alpha = 0.0
        
        self.LockButton.setImage(UIImage(named: "closedLock.png"), for: .normal)
        
        self.logoImageView.backgroundColor = .clear
        self.logoImageView.layer.cornerRadius = 10
        
        setUpLogoLabelFirstLetter()
    }
    
    
    //MARK: Private Methods
    private func setUpLogoLabelFirstLetter() {
        logoLabel.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        logoLabel.layer.backgroundColor = UIColor.clear.cgColor
        logoLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        logoLabel.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        self.logoImageView.addSubview(logoLabel)
        
        //Constraints
        logoLabel.topAnchor.constraint(equalTo: logoImageView.topAnchor, constant: 15).isActive = true
        logoLabel.trailingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: -10.5).isActive = true
        logoLabel.leadingAnchor.constraint(equalTo: logoImageView.leadingAnchor, constant: 18.5).isActive = true
        logoLabel.bottomAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: -15).isActive = true
    }
    
    //UpdateViews
    private func updateViews() {
        guard let password = self.password else {return}
        
        self.titleLabel?.text = password.title
        self.userNameLabel?.text = password.username
        self.passwordLabel?.text = password.password
        
        print("\(password.logoViewbgColor!)")
        DispatchQueue.main.async {
            self.logoImageView.backgroundColor = UIColor(hexString: password.logoViewbgColor!)
            self.logoLabel.text = password.title?.prefix(1).capitalized
        }
        updateLockButtonImage(for: password)
    }
    
    //Update BasketButtonImage
    private func updateLockButtonImage(for password: Password) {

        if password.openBasket == true {
            self.LockButton.setImage(UIImage(named: "openLock.png"), for: .normal)
            self.titleLabel.alpha = 0
            self.userNameLabel.alpha = 1
            self.passwordLabel.alpha = 1
            self.userNameLabel.textColor = .orange
            self.passwordLabel.textColor = .orange
        } else {
            self.LockButton.setImage(UIImage(named: "closedLock.png"), for: .normal)
            self.titleLabel.alpha = 1
            self.userNameLabel.alpha = 0
            self.passwordLabel.alpha = 0
        }
    }
    
    
    //MARK: LockButton Action
    @IBAction func lockButtonTapped(_ sender: Any) {
        self.dividerAnimation()
    }
    
    //MARK: Cell Animation - Divider, ShowTitle, ShowID/Password and LockButton
    private func dividerAnimation() {
        guard let password = self.password else {return}
        //when clicking the button
        if password.openBasket == false {
            self.LockButton.setImage(UIImage(named: "openLock.png"), for: .normal)
            self.LockButton.imageView?.tintColor = .orange
            showUserNameAndPassword()
        } else {
            self.LockButton.setImage(UIImage(named: "closedLock.png"), for: .normal)
            showTitle()
        }
    }

    private func showUserNameAndPassword() {
        
        UILabel.animateKeyframes(withDuration: 1.0, delay: 0, options: [], animations: {
            
            UILabel.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                self.dividerLabel.center = CGPoint(x: self.logoImageView.center.x + (29+10), y: self.dividerLabel.center.y)
            })
            //titleLabel animation part
            UILabel.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.2) {
                self.titleLabel.alpha = 0.0
            }
            
            UILabel.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.dividerLabel.center = CGPoint(x: self.cellView.bounds.maxX - self.LockButton.bounds.maxX - 23 - self.dividerLabel.frame.width / 2, y: self.dividerLabel.center.y)
            })
            
            UILabel.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.2) {
                self.userNameLabel.alpha = 1.0
                self.passwordLabel.alpha = 1.0
                self.userNameLabel.textColor = .orange
                self.passwordLabel.textColor = .orange
            }
            
        }, completion: { (_) in
            self.delegate?.toggleLockImage(for: self)
        })
    }
    
    private func showTitle() {
        UILabel.animateKeyframes(withDuration: 1.0, delay: 0, options: [], animations: {
            
            UILabel.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                self.dividerLabel.center = CGPoint(x: self.logoImageView.center.x + (29+10), y: self.dividerLabel.center.y)
            })
            
            //titleLabel animation part
            UILabel.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.2) {
                self.userNameLabel.alpha = 0.0
                self.passwordLabel.alpha = 0.0
            }
            
            UILabel.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.dividerLabel.center = CGPoint(x: self.cellView.bounds.maxX - self.LockButton.bounds.maxX - 23 - self.dividerLabel.frame.width / 2, y: self.dividerLabel.center.y)
            })
            
            UILabel.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.2) {
                self.titleLabel.alpha = 1.0
            }
            
        }, completion:  { (_) in
                   self.delegate?.toggleLockImage(for: self)
               })
    }
}
