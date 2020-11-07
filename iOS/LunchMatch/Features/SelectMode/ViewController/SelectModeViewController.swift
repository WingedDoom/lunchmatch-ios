//
//  SelectModeViewController.swift
//  LunchMatch
//
//  Created by Булат Хабиров on 07.11.2020.
//

import UIKit

final class SelectModeViewController: UIViewController {
    private enum State {
        case room, single
    }
    
    private var state: State = .single {
        didSet {
            switch state {
            case .single:
                selectModeView.configure(with: singleViewModel, animated: true)
            case .room:
                selectModeView.configure(with: roomViewModel, animated: true)
            }
        }
    }
    
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
        
        let barButtonItem = UIBarButtonItem()
        barButtonItem.title = R.string.localizable.selectModeNextButtonTitle()
        barButtonItem.target = self
        barButtonItem.action = #selector(didTapNextButton)
        navigationItem.rightBarButtonItem = barButtonItem
    }
}

extension SelectModeViewController: SelectModeViewDelegate {
    func didSelectSingleMode() {
        state = .single
    }
    
    func didSelectRoomMode() {
        state = .room
    }
}

private extension SelectModeViewController {
    var roomViewModel: SelectModeViewModel {
        .init(
            image: R.image.selectMode_RoomArt(),
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
    
    @objc private func didTapNextButton() {
        switch state {
        case .room:
            performSegue(withIdentifier: R.segue.selectModeViewController.roomSegue, sender: self)
        case .single:
            break
        }
    }
}
