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
    @IBOutlet weak var basketImageView: UIImageView!
    
    var password: Password? {
        didSet {
            self.updateViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.cellView.setShadowandCornerRadius()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    //private method
    private func updateViews() {
        guard let password = self.password else {return}
        
        self.titleLabel?.text = password.title
    }
    
 
    
    @IBAction func basketButtonTapped(_ sender: Any) {
        self.dividerAnimation()
    }
    
    
    //animationforLabel
     private func dividerAnimation() {
         
         UILabel.animateKeyframes(withDuration: 1.0, delay: 0, options: [], animations: {
     
            UILabel.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                 self.dividerLabel.center = CGPoint(x: self.dividerLabel.center.x - 200, y: self.dividerLabel.center.y)
             })
            
            UILabel.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.dividerLabel.center = CGPoint(x: self.dividerLabel.center.x + 200, y: self.dividerLabel.center.y)
            })
        
         }, completion: nil)
     }
}
