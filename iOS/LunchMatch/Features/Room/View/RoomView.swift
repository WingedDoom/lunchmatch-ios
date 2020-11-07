//
//  RoomView.swift
//  LunchMatch
//
//  Created by Розалия Амирова on 07.11.2020.
//

import UIKit

protocol RoomViewDelegate: AnyObject {
    func didTapPreferencesButton()
}

class RoomView: UIView, XibInitializable {
    private let layout = UICollectionViewFlowLayout()
    private let manager = NamesCollectionViewManager()
    weak var delegate: RoomViewDelegate?
    
    // MARK: - Properties
    @IBOutlet
    private weak var qrCodeImageView: UIImageView?
    
    @IBOutlet
    private weak var roomIDLabel: UILabel!
    
    @IBOutlet
    private weak var namesCollectionView: UICollectionView! {
        didSet {
            manager.collectionView = namesCollectionView
            namesCollectionView.backgroundColor = UIColor.white
            namesCollectionView.setCollectionViewLayout(layout, animated: true)
            layout.minimumLineSpacing = 10.0
            layout.minimumInteritemSpacing = 10.0
        }
    }
    
    @IBOutlet
    private  weak var submitButton: SelectableButton! {
        didSet {
            submitButton.title = R.string.localizable.roomNextButtonTitle()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        didLoad()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        didLoad()
    }
    
    private func didLoad() {
        xibSetup()
    }
    
    func configure(with viewModel: RoomViewModel) {
        // qrCodeImageView?.kf.setImage(with: viewModel.qrCodeImageViewURL)
        roomIDLabel.text = viewModel.roomID
        manager.viewModels = viewModel.participants
    }
    
    @IBAction private func didTapPreferencesButton() {
        delegate?.didTapPreferencesButton()
    }
}
