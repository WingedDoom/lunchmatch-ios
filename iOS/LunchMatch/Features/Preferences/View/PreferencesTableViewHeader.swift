//
//  PreferencesTableViewHeader.swift
//  LunchMatch
//
//  Created by Розалия Амирова on 07.11.2020.
//

import UIKit

class PreferencesTableViewHeader: UITableViewHeaderFooterView {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var countLabel: UILabel!
    @IBOutlet private var arrowImageView: UIImageView!
    @IBOutlet private var selectButton: UIButton! {
        didSet {
            selectButton.addTarget(self, action: #selector(didTapHeader), for: .touchUpInside)
        }
    }
    
    private var selectAction: (() -> Void)?
    

    func configure(with viewModel: PreferencesTableViewHeaderViewModel) {
        titleLabel.text = viewModel.title
        countLabel.text = viewModel.counter
        arrowImageView.image = viewModel.isOpened ? UIImage.init(systemName: "chevron.down") : UIImage.init(systemName: "chevron.up")
        selectAction = viewModel.selectAction
    }
    
    @objc func didTapHeader() {
        guard let selectAction =  selectAction else { return }
        selectAction()
    }
}


