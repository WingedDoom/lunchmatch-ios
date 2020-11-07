//
//  RoomView.swift
//  LunchMatch
//
//  Created by Розалия Амирова on 07.11.2020.
//

import UIKit

class RoomView: UIView, XibInitializable {
    
    private let layout = UICollectionViewFlowLayout()
    private let manager = NamesCollectionViewManager()
    
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
    private  weak var submitButton: UIButton! {
        didSet {
            submitButton.setTitle("Submit", for: .normal)
            submitButton.layer.cornerRadius = 15.0
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
//
//    private func didLoad() {
//
//        manager.collectionView = namesCollectionView
//        namesCollectionView.backgroundColor = UIColor.white
//    }
    
    private func didLoad() {
        xibSetup()
    }
    
    func configure(with viewModel: RoomViewModel) {
//        qrCodeImageView?.kf.setImage(with: viewModel.qrCodeImageViewURL)
        roomIDLabel.text = viewModel.roomID
        
        manager.viewModels = [NameCollectionViewModel(name: "Kekster"),
                              NameCollectionViewModel(name: "Mekster"),
                              NameCollectionViewModel(name: "Pek"),
                              NameCollectionViewModel(name: "Hek"),
                              NameCollectionViewModel(name: "Sek")]
    }
}
