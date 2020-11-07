//
//  RoomViewController.swift
//  LunchMatch
//
//  Created by Розалия Амирова on 07.11.2020.
//

import UIKit

class RoomViewController: UIViewController {
    
    let repository: ProvidesRoomData = RoomRepositoryMock()
    private var presentedViewModel: RoomViewModel? {
        didSet {
            guard let viewModel = presentedViewModel else { return }
            roomView.configure(with: viewModel)
        }
    }
    
    private var roomView: RoomView {
        view as! RoomView
    }
    
    override func loadView() {
        view = RoomView()
        view.backgroundColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repository.delegate = self
        loadRoom()
    }
    
    private func loadRoom() {
        repository.getRoomInfo { response in
            switch response {
            case let .success(result):
                let viewModel = self.parseResult(result)
                self.presentedViewModel = viewModel
            case .failure:
                return
            }
        }
        repository.connect()
    }
    
    private func parseResult(_ room: RoomItem) -> RoomViewModel {
        return RoomViewModel(qrCodeImageViewURL: room.qrCodeImageViewURL, roomID: room.roomID, participants: [])
    }
}

extension RoomViewController: RoomRepositoryDelegate {
    func roomDidUpdateParticipants(newParticipants: [String]) {
        guard let viewModel = presentedViewModel else { return }
        presentedViewModel = viewModel.withParticipants(newParticipants.map { .init(name: $0) })
    }
}
