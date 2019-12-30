//
//  NoteCollectionViewCell.swift
//  SaveThings
//
//  Created by Dongwoo Pae on 12/22/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class NoteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.cornerRadius = 14.0
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.layer.shadowRadius = 14.0
        self.layer.shadowOpacity = 0.7
        self.layer.masksToBounds = false
        
        self.deleteButton.setImage(UIImage(named: "deleteButton"), for: .normal)
    }
    
    var delegate: NoteCollectionViewCellDelegate?
    
    var isEditing: Bool = false {
        didSet {
            self.deleteButton.isHidden = !isEditing
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
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        delegate?.removeCellAndReload(for: self)
    }
}
