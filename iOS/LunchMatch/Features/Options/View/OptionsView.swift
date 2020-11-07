//
//  HistoryView.swift
//  LunchMatch
//
//  Created by Розалия Амирова on 07.11.2020.
//

import UIKit

class OptionsView: UIView {
    private let layout = UICollectionViewFlowLayout()
    private lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    private let manager = OptionsViewCollectionViewManager()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        didLoad()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        didLoad()
    }
    
    private func didLoad() {
        addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        ])
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        manager.collectionView = collectionView
        collectionView.backgroundColor = UIColor.white
    }
    
    func configure(with viewModels: [OptionsCollectionViewModel]) {
        manager.viewModels = viewModels
    }
}
