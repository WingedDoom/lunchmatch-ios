//
//  RoomRepository.swift
//  LunchMatch
//
//  Created by Розалия Амирова on 07.11.2020.
//

import Foundation

protocol ProvidesRoomData: AnyObject {
    var delegate: RoomRepositoryDelegate? { get set }
    func getRoomInfo(completion: @escaping (Result<RoomItem, Error>) -> Void)
    func connect()
}

protocol RoomRepositoryDelegate: AnyObject {
    func roomDidUpdateParticipants(newParticipants: [String])
}

class RoomRepositoryMock: ProvidesRoomData {
    weak var delegate: RoomRepositoryDelegate?
    private var allMockParticipants = [
        "HungryGuy98",
        "Cutie",
        "MemeLord",
        "real_shrek"
    ]
    private var participants: [String] = [] {
        didSet {
            delegate?.roomDidUpdateParticipants(newParticipants: participants)
        }
    }
    
    func getRoomInfo(completion: @escaping (Result<RoomItem, Error>) -> Void) {
        let item = RoomItem(
            qrCodeImageViewURL: URL(string: "https://archello.com/thumbs/images/2018/01/31/IndustrialrusticJuanValdezCaf3.1517370772.9964.jpg?fit=crop&w=1920&h=1080")!, roomID: "qwerty"
        )
        completion(.success(item))
    }
    
    func connect() {
        updateMockParticipants()
    }
    
    private func updateMockParticipants() {
        guard participants.count < allMockParticipants.count else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            self.participants.append(self.allMockParticipants[self.participants.count])
            self.updateMockParticipants()
        }
    }
}
