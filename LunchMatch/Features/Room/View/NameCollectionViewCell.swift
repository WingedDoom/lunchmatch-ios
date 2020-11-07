//
//  NameCell.swift
//  LunchMatch
//
//  Created by Розалия Амирова on 07.11.2020.
//

import UIKit
import Kingfisher

class NameCollectionViewCell: UICollectionViewCell, XibInitializable {
    // MARK: - Properties
    
    @IBOutlet
    private weak var nameLabel: UILabel!
  
    
    // MARK: - Initialization
    override public init(frame: CGRect) {
        super.init(frame: frame)
        didLoad()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        didLoad()
    }
    
    func configure(with viewModel: NameCollectionViewModel) {
        nameLabel.text = viewModel.name
        backgroundColor = R.color.backgroundPrimary()
        self.layer.cornerRadius = 15
    }
    
    private func didLoad() {
        xibSetup()
    }
}
