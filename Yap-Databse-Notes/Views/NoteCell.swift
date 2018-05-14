//
//  NoteCell.swift
//  Yap-Databse-Notes
//
//  Created by Trevin Wisaksana on 04/05/2018.
//  Copyright © 2018 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class NoteCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var modificationTimeLabel: UILabel!
    
    func configure(with data: Note) {
        titleLabel.text = data.title
        modificationTimeLabel.text = data.modificationTime.convertToString()
    }
    
}
