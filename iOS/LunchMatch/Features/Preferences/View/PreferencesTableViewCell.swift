//
//  PreferencesTableViewCell.swift
//  LunchMatch
//
//  Created by Розалия Амирова on 07.11.2020.
//

import UIKit

class PreferencesTableViewCell: UITableViewCell {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var selectionImageView: UIImageView!
    
    // MARK: - Initialization
    
    func configure(with viewModel: PreferencesTableViewCellViewModel) {
        titleLabel.text = viewModel.title
        selectionImageView.image = viewModel.isSelected ? UIImage.init(systemName: "checkmark.circle.fill") : UIImage.init(systemName: "checkmark.circle")
    }
}
