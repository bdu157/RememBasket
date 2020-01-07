//
//  NoteTableViewCellDelegate.swift
//  SaveThings
//
//  Created by Dongwoo Pae on 1/5/20.
//  Copyright © 2020 Dongwoo Pae. All rights reserved.
//

import Foundation

protocol NoteTableViewCellDelegate {
    func togglePreviewImage(for cell: NoteTableViewCell)
    func showActivityView(for cell: NoteTableViewCell)
}
