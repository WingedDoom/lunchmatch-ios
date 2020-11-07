//
//  RoomViewController.swift
//  LunchMatch
//
//  Created by Розалия Амирова on 07.11.2020.
//

import UIKit

class RoomViewController: UIViewController {
    
    let repository: RoomRepository = RoomRepositoryMock()
    
    private var roomView: RoomView {
        view as! RoomView
    }
    
    override func loadView() {
        view = RoomView()
        view.backgroundColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        loadRoom()
    }
    
    private func setupNavigationBar() {
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.title =  "Evgerher"
//        navigationController?.navigationBar.backgroundColor = UIColor.yellow
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newSessionDidTap))
//        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(settingsDidTap))
    }
    
    private func loadRoom() {
        repository.getRoomInfo { response in
            switch response {
            case let .success(result):
                self.roomView.configure(with: self.parseResult(result))
                
            case .failure:
                return
            }
        }
    }
    
    private func parseResult(_ room: RoomItem) -> RoomViewModel {
        return RoomViewModel(qrCodeImageViewURL: room.qrCodeImageViewURL, roomID: room.roomID)
    }
}
