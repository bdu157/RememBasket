//
//  NoteCollectionViewCell.swift
//  SaveThings
//
//  Created by Dongwoo Pae on 12/22/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class NoteCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties and Outlets
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var timestampLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setUpCellShape()
        
        self.deleteButton.setImage(UIImage(named: "deleteButton"), for: .normal)
        self.editButton.setImage(UIImage(named: "editButton"), for: .normal)
    }
    
    var delegate: NoteCollectionViewCellDelegate?
    
    //MARK: Multiple Cells - animations for edit and delete buttons for cell
    var isEditing: Bool = false {
        didSet {
            if self.isEditing {
                UIButton.animate(withDuration: 0.6) {
                    self.deleteButton.alpha = 1
                    self.editButton.alpha = 1
                }
            } else if !self.isEditing {
                self.deleteButton.alpha = 0
                self.editButton.alpha = 0
                
            }
        }
    }
    
    var category: Category? {
        didSet {
            self.updateViews()
        }
    }
    
    private func updateViews() {
        guard let category = self.category else {return}
        self.categoryLabel.text = category.name
        
        //Date Formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dateFromCoreData = category.timestamp
        let createdDate = dateFormatter.string(from: dateFromCoreData!)
        dateFormatter.timeZone = NSTimeZone.local
        
        self.timestampLabel.text = "Created: \(createdDate)"
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        delegate?.removeCellAndReload(for: self)
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        delegate?.editAlert(for: self)
    }
    
    //MARK: Setting Up Cell Shape
    private func setUpCellShape() {
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.cornerRadius = 14.0
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.layer.shadowRadius = 14.0
        self.layer.shadowOpacity = 0.7
        self.layer.masksToBounds = false
    }
}
