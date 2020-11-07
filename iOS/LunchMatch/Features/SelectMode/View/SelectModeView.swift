//
//  SelectModeView.swift
//  LunchMatch
//
//  Created by Булат Хабиров on 07.11.2020.
//

import UIKit

protocol SelectModeViewDelegate: AnyObject {
    func didSelectRoomMode()
    func didSelectSingleMode()
}

final class SelectModeView: UIView, XibInitializable {
    // MARK: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    weak var delegate: SelectModeViewDelegate?
    
    // MARK: - Init
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
        
        titleLabel.font = .appTitle1
        descriptionLabel.font = .appBody
    }
    
    func configure(with viewModel: SelectModeViewModel, animated: Bool) {
        UIView.animate(withDuration: animated ? 0.3 : 0) {
            self.imageView.image = viewModel.image
            self.titleLabel.text = viewModel.title
            self.descriptionLabel.text = viewModel.description
        }
    }
    
    @IBAction private func didSelectRoomMode() {
        delegate?.didSelectRoomMode()
    }
    
    @IBAction private func didSelectSingleMode() {
        delegate?.didSelectSingleMode()
    }
}
