//
//  MatchCollectionViewCell.swift
//  LunchMatch
//
//  Created by Розалия Амирова on 07.11.2020.
//

import UIKit
import Kingfisher

class OptionCollectionViewCell: UICollectionViewCell, XibInitializable {
    // MARK: - Properties
    @IBOutlet
    private weak var placeImageView: UIImageView?
    
    @IBOutlet
    private weak var placeTitleLabel: UILabel!
    
    @IBOutlet
    private weak var subtitleLabel: UILabel!
    
    @IBOutlet
    private  weak var stackView: UIStackView!
    
    // MARK: - Initialization
    override public init(frame: CGRect) {
        super.init(frame: frame)
        didLoad()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        didLoad()
    }
    
    func configure(with viewModel: OptionsCollectionViewModel) {
        placeImageView?.kf.setImage(with: viewModel.imageLink)
        placeTitleLabel.text = viewModel.placeName
        subtitleLabel.text = viewModel.participants
    }
    
    private func didLoad() {
        xibSetup()
    }
    
    override func prepareForReuse() {
        placeImageView?.kf.cancelDownloadTask()
    }
}

