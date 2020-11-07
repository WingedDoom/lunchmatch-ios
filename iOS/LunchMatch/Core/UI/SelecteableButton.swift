//
//  SelecteableButton.swift
//  LunchMatch
//
//  Created by Розалия Амирова on 07.11.2020.
//

import UIKit

class SelectableButton: UIControl {
    enum Constants {
        static let height: CGFloat = 44
        static let labelInset: CGFloat = 16
    }
    
    @IBInspectable var title: String {
        get {
            titleLabel.text ?? ""
        }
        
        set {
            titleLabel.text = newValue
            invalidateIntrinsicContentSize()
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .appBody
        label.textColor = R.color.action()
        
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            isSelected ? select() : deselect()
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            isHighlighted || isSelected ? select() : deselect()
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
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        layer.borderWidth = 1
        layer.borderColor = R.color.action()?.cgColor
        backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
    
    override var intrinsicContentSize: CGSize {
        .init(
            width: titleLabel.intrinsicContentSize.width + Constants.labelInset * 2,
            height: Constants.height
        )
    }
    
    func select() {
        UIView.animate(withDuration: 0.4) {
            self.titleLabel.textColor = .white
            self.backgroundColor = R.color.action()
        }
    }
    
    func deselect() {
        UIView.animate(withDuration: 0.4) {
            self.titleLabel.textColor = R.color.action()
            self.backgroundColor = .clear
        }
    }
}
