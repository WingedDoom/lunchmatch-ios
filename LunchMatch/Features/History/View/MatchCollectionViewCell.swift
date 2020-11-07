//
//  MatchCollectionViewCell.swift
//  LunchMatch
//
//  Created by Розалия Амирова on 07.11.2020.
//

import UIKit
import Kingfisher

class MatchCollectionViewCell: UICollectionViewCell, XibInitializable {
    // MARK: - Properties
    @IBOutlet
    private weak var placeImageView: UIImageView?
    
    @IBOutlet
    private weak var placeTitleLabel: UILabel!
    
    @IBOutlet
    private weak var subtitleLabel: UILabel!
    
    @IBOutlet
    private weak var dateLabel: UILabel!
    
    @IBOutlet
    private  weak var stackView: UIStackView!
    
    @IBOutlet
    private  weak var shareButton: UIButton!
    
    // MARK: - Initialization
    override public init(frame: CGRect) {
        super.init(frame: frame)
        didLoad()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        didLoad()
    }
    
    func configure(with viewModel: MatchCollectionViewModel) {
        placeImageView?.kf.setImage(with: viewModel.imageLink)
        placeTitleLabel.text = viewModel.placeName
        subtitleLabel.text = viewModel.participants
        dateLabel.text = viewModel.date
    }
    
    private func didLoad() {
        xibSetup()
    }
    
    override func prepareForReuse() {
        placeImageView?.kf.cancelDownloadTask()
    }
}

