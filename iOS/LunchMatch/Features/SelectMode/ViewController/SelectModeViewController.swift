//
//  SelectModeViewController.swift
//  LunchMatch
//
//  Created by Булат Хабиров on 07.11.2020.
//

import UIKit

final class SelectModeViewController: UIViewController {
    private var selectModeView: SelectModeView {
        return view as! SelectModeView
    }
    
    override func loadView() {
        view = SelectModeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectModeView.delegate = self
        selectModeView.configure(with: singleViewModel, animated: false)
    }
}

extension SelectModeViewController: SelectModeViewDelegate {
    func didSelectSingleMode() {
        selectModeView.configure(with: singleViewModel, animated: true)
    }
    
    func didSelectRoomMode() {
        selectModeView.configure(with: roomViewModel, animated: true)
    }
}

private extension SelectModeViewController {
    var roomViewModel: SelectModeViewModel {
        .init(
            image: R.image.selectMode_SingleArt(),
            title: R.string.localizable.selectModeRoomTitle(),
            description: R.string.localizable.selectModeRoomDescription()
        )
    }
    
    var singleViewModel: SelectModeViewModel {
        .init(
            image: R.image.selectMode_SingleArt(),
            title: R.string.localizable.selectModeSingleTitle(),
            description: R.string.localizable.selectModeSingleDescription()
        )
    }
}
