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
        self.layer.cornerRadius = 14
        self.layer.backgroundColor = UIColor.orange.cgColor
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
