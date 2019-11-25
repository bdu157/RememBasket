//
//  PasswordTableViewCell.swift
//  RememBasket
//
//  Created by Dongwoo Pae on 11/23/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class PasswordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dividerLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var basketButton: UIButton!
    
    
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
        
        self.basketButton.backgroundColor = .clear
    }
    
    
    //private method
    private func updateViews() {
        guard let password = self.password else {return}
        
        self.titleLabel?.text = password.title
        self.userNameLabel?.text = password.username
        self.passwordLabel?.text = password.password
    }
    
    
    
    @IBAction func basketButtonTapped(_ sender: Any) {
        self.dividerAnimation()
        basketButtonAnimation()
    }
    
    //basketButton Animation
    private func basketButtonAnimation() {
        
        //this will be used through UIImage -> open basket image and closed basket images
        if self.basketButton.backgroundColor == .clear {
            self.basketButton.backgroundColor = .orange
        } else {
            self.basketButton.backgroundColor = .clear
        }
    }
    
    
    //animationforLabel
    private func dividerAnimation() {
        
        if self.basketButton.backgroundColor == .clear {
            
            UILabel.animateKeyframes(withDuration: 1.0, delay: 0, options: [], animations: {
                
                UILabel.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                    self.dividerLabel.center = CGPoint(x: self.logoImageView.center.x + (29+10), y: self.dividerLabel.center.y)
                })
                
                //titleLabel animation part
                UILabel.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.2) {
                    self.titleLabel.alpha = 0.0
                }
                
                
                //            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.1, animations: {
                //                self.dividerLabel.center = self.dividerLabel.center
                //            })
                
                UILabel.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                    self.dividerLabel.center = CGPoint(x: self.basketButton.center.x - (15+15), y: self.dividerLabel.center.y)
                })
                
                UILabel.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.2) {
                    self.userNameLabel.alpha = 1.0
                    self.passwordLabel.alpha = 1.0
                    self.userNameLabel.textColor = .orange
                    self.passwordLabel.textColor = .orange
                }
                
            }, completion: nil)
            
        } else {
            
            UILabel.animateKeyframes(withDuration: 1.0, delay: 0, options: [], animations: {
                
                UILabel.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                    self.dividerLabel.center = CGPoint(x: self.logoImageView.center.x + (29+10), y: self.dividerLabel.center.y)
                })
                
                //titleLabel animation part
                UILabel.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.2) {
                    self.userNameLabel.alpha = 0.0
                    self.passwordLabel.alpha = 0.0
                }
                
                
                //            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.1, animations: {
                //                self.dividerLabel.center = self.dividerLabel.center
                //            })
                
                UILabel.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                    self.dividerLabel.center = CGPoint(x: self.basketButton.center.x - (15+15), y: self.dividerLabel.center.y)
                })
                
                UILabel.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.2) {
                    self.titleLabel.alpha = 1.0
                }
                
            }, completion: nil)
        }
    }
}
