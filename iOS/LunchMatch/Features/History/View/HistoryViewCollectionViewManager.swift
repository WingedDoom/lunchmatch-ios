//
//  HistoryViewCollectionViewManager.swift
//  LunchMatch
//
//  Created by Розалия Амирова on 07.11.2020.
//

import UIKit

class HistoryViewCollectionViewManager: NSObject {
    
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
    
    var viewModels: [MatchCollectionViewModel] = [] {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    private func setupCollectionView()  {
        guard let collectionView = collectionView else { return }
        collectionView.register(MatchCollectionViewCell.self, forCellWithReuseIdentifier: MatchCollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}



// MARK: - UICollectionViewDataSource

extension HistoryViewCollectionViewManager: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MatchCollectionViewCell.reuseIdentifier, for: indexPath) as! MatchCollectionViewCell
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
}




// MARK: - UICollectionViewDelegateFlowLayout

extension HistoryViewCollectionViewManager: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 2 * Constants.cellIndent
        let height = width * Constants.cellAspectRatio
        return CGSize(width: width, height: height)
        
//        if collectionViewWidth > maxWidth {
//            return CGSize(width: maxWidth, height: Constants.cellHeight)
//        } else {
//            return CGSize(width: collectionViewWidth, height: Constants.cellHeight)
//        }
    }
}
