//
//  NameCollectionViewManager.swift
//  LunchMatch
//
//  Created by Розалия Амирова on 07.11.2020.
//

import UIKit

class NamesCollectionViewManager: NSObject {
    
    private enum Constants {
        static let maxWidth: CGFloat = 330.0
        static let cellIndent: CGFloat = 22.0
        static let cellHeight: CGFloat = 231.0
        static let cellAspectRatio: CGFloat = 0.7
    }
    
    weak var collectionView: UICollectionView? {
        didSet {
            setupCollectionView()
        }
    }
    
    var viewModels: [NameCollectionViewModel] = [] {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    private func setupCollectionView()  {
        guard let collectionView = collectionView else { return }
        collectionView.register(NameCollectionViewCell.self, forCellWithReuseIdentifier: NameCollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}



// MARK: - UICollectionViewDataSource

extension NamesCollectionViewManager: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NameCollectionViewCell.reuseIdentifier, for: indexPath) as! NameCollectionViewCell
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
}




// MARK: - UICollectionViewDelegateFlowLayout

extension NamesCollectionViewManager: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModels[indexPath.row].name.getSizeWithConstrainedSize(CGSize(width: 200.0, height: 200.0), font: UIFont.systemFont(ofSize: 17))
    }
}
