//
//  NoteCollectionViewCellDelegate.swift
//  SaveThings
//
//  Created by Dongwoo Pae on 12/30/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation

protocol NoteCollectionViewCellDelegate {
    func removeCellAndReload(for cell: NoteCollectionViewCell)
}
