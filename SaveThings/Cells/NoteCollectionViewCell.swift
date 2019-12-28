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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 14
        self.layer.backgroundColor = UIColor.orange.cgColor
    }
    
    var note: Note? {
        didSet {
            self.updateViews()
        }
    }

    
    private func updateViews() {
        guard let note = note else {return}
        self.categoryLabel.text = note.category
    }
}
