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
    
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dividerLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var basketButton: UIButton!
    
    //this is to use fetchcompanlogo
    let passwordController = PasswordController()
    
    var password: Password? {
        didSet {
            self.updateViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.cellView.setShadowandCornerRadius()
        self.userNameLabel.alpha = 0.0
        self.passwordLabel.alpha = 0.0
        
        self.basketButton.setImage(UIImage(named: "basket.png"), for: .normal)
        
        self.logoImageView.backgroundColor = .orange
        self.logoImageView.tintColor = .white
        self.logoImageView.layer.cornerRadius = 10
        
        
        observeShouldResetData()
    }
    
    //observerFortheReset
    func observeShouldResetData() {
        NotificationCenter.default.addObserver(self, selector: #selector(resetCells(notification:)), name: .needtoResetData, object: nil)
    }
    
    @objc func resetCells(notification: Notification) {
        if self.basketButton.image(for: .normal) == UIImage(named: "basket-id-password.png") {
            showTitle()
            self.basketButton.setImage(UIImage(named: "basket.png"), for: .normal)
        }
    }
    
    //private method
    private func updateViews() {
        guard let password = self.password else {return}
        
        self.titleLabel?.text = password.title
        self.userNameLabel?.text = password.username
        self.passwordLabel?.text = password.password
        
        self.passwordController.fetchCompanyLogoForOneTerm(searchTerm: password.imageURLString!) { (result) in
            <#code#>
        }
        
        updateBasketButtonImage()
    }
    
    //update basketButton
    private func updateBasketButtonImage() {
        
        if self.basketButton.image(for: .normal) == UIImage(named: "basket.png") {
            self.titleLabel.alpha = 1
            self.userNameLabel.alpha = 0
            self.passwordLabel.alpha = 0
        } else {
            self.titleLabel.alpha = 0
            self.userNameLabel.alpha = 1
            self.passwordLabel.alpha = 1
        }
    }
    
    
    @IBAction func basketButtonTapped(_ sender: Any) {
        self.dividerAnimation()
    }
    
    //animationforLabels
    private func dividerAnimation() {
        
        //when clicking the button
        if self.basketButton.image(for: .normal) == UIImage(named: "basket.png") {
            self.basketButton.setImage(UIImage(named: "basket-id-password.png"), for: .normal)
            showUserNameAndPassword()
        } else {
            showTitle()
            self.basketButton.setImage(UIImage(named: "basket.png"), for: .normal)
        }
    }
    
    //private methods for divider animation
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
                self.dividerLabel.center = CGPoint(x: self.basketButton.center.x - (15+18), y: self.dividerLabel.center.y)
            })
            
            UILabel.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.2) {
                self.userNameLabel.alpha = 1.0
                self.passwordLabel.alpha = 1.0
                self.userNameLabel.textColor = .orange
                self.passwordLabel.textColor = .orange
            }
            
        }, completion: nil)
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
                self.dividerLabel.center = CGPoint(x: self.basketButton.center.x - (15+18), y: self.dividerLabel.center.y)
            })
            
            UILabel.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.2) {
                self.titleLabel.alpha = 1.0
            }
            
        }, completion: nil)
    }
}
