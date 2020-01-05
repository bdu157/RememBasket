//
//  NoteTableViewCell.swift
//  SaveThings
//
//  Created by Dongwoo Pae on 1/5/20.
//  Copyright © 2020 Dongwoo Pae. All rights reserved.
//

import UIKit
import CoreData

class NoteTableViewCell: UITableViewCell {
    
    //MARK: Properties and Outlets
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dividerLabel: UILabel!
    @IBOutlet weak var previewLabel: UILabel!
    @IBOutlet weak var previewButton: UIButton!
    
    
    //MARK: Private Properties
    private var logoLabel: UILabel = UILabel()
    
    let noteController = NoteController()
    
    var note: Note? {
        didSet {
            self.updateViews()
        }
    }
    
    var delegate: NoteTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateViews()
        
        self.selectionStyle = .none
        self.cellView.setShadowandCornerRadius()
        self.previewLabel.alpha = 0.0
        
        self.previewButton.setImage(UIImage(named: "closedLock.png"), for: .normal)
        
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
        guard let note = self.note else {return}
        
        self.titleLabel?.text = note.title
        self.previewLabel?.text = note.content
        
        print("\(note.logoViewbgColor!)")
        DispatchQueue.main.async {
            self.logoImageView.backgroundColor = UIColor(hexString: note.logoViewbgColor!)
            self.logoLabel.text = note.title?.prefix(1).capitalized
        }
        updatePreviewButtonImage(for: note)
    }
    
    //Update PreviewButton image
    private func updatePreviewButtonImage(for note: Note) {
        
        if note.openPreview == true {
            self.previewButton.setImage(UIImage(named: "openLock.png"), for: .normal)
            self.titleLabel.alpha = 0
            self.previewLabel.alpha = 1
            
            self.previewLabel.textColor = .orange
        } else {
            self.previewButton.setImage(UIImage(named: "closedLock.png"), for: .normal)
            self.titleLabel.alpha = 1
            self.previewLabel.alpha = 0
        }
    }
    
    
    //MARK: PreviewButton Action
    @IBAction func previewButtonTapped(_ sender: Any) {
        self.dividerAnimation()
    }
    
    //MARK: Cell Animation - Divider, ShowTitle, ShowPreview and the other preview image
    private func dividerAnimation() {
        guard let note = self.note else {return}
        //when clicking the button
        if note.openPreview == false {
            self.previewButton.setImage(UIImage(named: "openLock.png"), for: .normal)
            self.previewButton.imageView?.tintColor = .orange
            showPreview()
        } else {
            self.previewButton.setImage(UIImage(named: "closedLock.png"), for: .normal)
            showTitle()
        }
    }
    
    private func showPreview() {
        
        UILabel.animateKeyframes(withDuration: 1.0, delay: 0, options: [], animations: {
            
            UILabel.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                self.dividerLabel.center = CGPoint(x: self.logoImageView.center.x + (29+10), y: self.dividerLabel.center.y)
            })
            //titleLabel animation part
            UILabel.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.2) {
                self.titleLabel.alpha = 0.0
            }
            
            UILabel.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.dividerLabel.center = CGPoint(x: self.cellView.bounds.maxX - self.previewButton.bounds.maxX - 23 - self.dividerLabel.frame.width / 2, y: self.dividerLabel.center.y)
            })
            
            UILabel.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.2) {
                self.previewLabel.alpha = 1.0
                self.previewLabel.textColor = .orange
            }
            
        }, completion: { (_) in
            self.delegate?.togglePreviewImage(for: self)
        })
    }
    
    private func showTitle() {
        UILabel.animateKeyframes(withDuration: 1.0, delay: 0, options: [], animations: {
            
            UILabel.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                self.dividerLabel.center = CGPoint(x: self.logoImageView.center.x + (29+10), y: self.dividerLabel.center.y)
            })
            
            //titleLabel animation part
            UILabel.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.2) {
                self.previewLabel.alpha = 0.0
            }
            
            UILabel.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.dividerLabel.center = CGPoint(x: self.cellView.bounds.maxX - self.previewButton.bounds.maxX - 23 - self.dividerLabel.frame.width / 2, y: self.dividerLabel.center.y)
            })
            
            UILabel.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.2) {
                self.titleLabel.alpha = 1.0
            }
            
        }, completion:  { (_) in
            self.delegate?.togglePreviewImage(for: self)
        })
    }
}
