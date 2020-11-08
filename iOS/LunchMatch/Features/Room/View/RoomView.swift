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
    weak var delegate: RoomViewDelegate?
    // MARK: - Properties
    @IBOutlet
    private weak var qrCodeImageView: UIImageView?
    
    @IBOutlet
    private weak var roomIDLabel: UILabel!
    
    @IBOutlet
    private weak var tagsView: TagsView!
    
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
        tagsView.configure(with: viewModel.participants)
    }
    
    @IBAction private func didTapPreferencesButton() {
        delegate?.didTapPreferencesButton()
    }
}
