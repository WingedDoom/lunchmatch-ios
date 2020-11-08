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
    private weak var placeTitleLabel: UILabel! {
        didSet {
            placeTitleLabel.font = .appBody
        }
    }
    
    @IBOutlet
    private weak var subtitleLabel: UILabel! {
        didSet {
            subtitleLabel.font = .appCaption1
        }
    }
    
    @IBOutlet
    private weak var stackView: UIStackView!
    
    @IBOutlet
    private weak var selectButton: SelectableButton! {
        didSet  {
            selectButton.addTarget(self, action: #selector(selectButtonDidTap), for: .touchUpInside)
            selectButton.title = R.string.localizable.optionsCellSelectButtonDeselected()
        }
    }
    
    private var placeSelected: Bool = false {
        didSet {
            selectButton.isSelected = placeSelected
            selectButton.title = placeSelected
                ? R.string.localizable.optionsCellSelectButtonSelected()
                : R.string.localizable.optionsCellSelectButtonDeselected()
        }
    }
    
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
        subtitleLabel.text = viewModel.description
    }
    
    private func didLoad() {
        xibSetup()
    }
    
    @objc private func selectButtonDidTap() {
        placeSelected = !placeSelected
    }
    
    override func prepareForReuse() {
        placeImageView?.kf.cancelDownloadTask()
    }
}

