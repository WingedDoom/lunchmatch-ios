//
//  TagsView.swift
//  LunchMatch
//
//  Created by Булат Хабиров on 08.11.2020.
//

import UIKit

final class TagsView: UIView {
    private let layout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
    private let manager = NamesCollectionViewManager()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        didLoad()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        didLoad()
    }
    
    private func didLoad() {
        collectionView.frame = bounds
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(collectionView)
        
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        
        manager.collectionView = collectionView
        collectionView.backgroundColor = UIColor.white
    }
    
    func configure(with viewModels: [NameCollectionViewModel]) {
        manager.viewModels = viewModels
    }
}
