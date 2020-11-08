//
//  HistoryViewCollectionViewManager.swift
//  LunchMatch
//
//  Created by Розалия Амирова on 07.11.2020.
//

import UIKit

class OptionsViewCollectionViewManager: NSObject {
    private enum Constants {
        static let maxWidth: CGFloat = 330.0
        static let cellIndent: CGFloat = 22.0
        static let cellHeight: CGFloat = 201
        static let cellImageAspectRatio: CGFloat = 31/66
    }
    
    weak var collectionView: UICollectionView? {
        didSet {
            setupCollectionView()
        }
    }
    
    var viewModels: [OptionsCollectionViewModel] = [] {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    private func setupCollectionView()  {
        guard let collectionView = collectionView else { return }
        collectionView.register(OptionCollectionViewCell.self, forCellWithReuseIdentifier: OptionCollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - UICollectionViewDataSource

extension OptionsViewCollectionViewManager: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OptionCollectionViewCell.reuseIdentifier, for: indexPath) as! OptionCollectionViewCell
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension OptionsViewCollectionViewManager: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewModel = viewModels[indexPath.row]
        let width = collectionView.bounds.width - 2 * Constants.cellIndent
        let imageHeight = width * Constants.cellImageAspectRatio
        let textBoundingSize = CGSize(width: width - 98, height: CGFloat.greatestFiniteMagnitude)
        let titleHeight = "A".getSizeWithConstrainedSize(textBoundingSize, font: .appBody).height
        let subtitleHeight = viewModel.description.getSizeWithConstrainedSize(textBoundingSize, font: .appCaption1).height
        return CGSize(width: width, height: ceil(imageHeight + titleHeight + subtitleHeight + 8))
    }
}
