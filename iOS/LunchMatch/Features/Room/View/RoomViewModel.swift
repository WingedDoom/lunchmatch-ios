//
//  RoomViewModel.swift
//  LunchMatch
//
//  Created by Розалия Амирова on 07.11.2020.
//

import Foundation

struct RoomViewModel {
    let qrCodeImageViewURL: URL
    let roomID: String
    let participants: [NameCollectionViewModel]
}

extension RoomViewModel {
    func withParticipants(_ participants: [NameCollectionViewModel]) -> RoomViewModel {
        .init(
            qrCodeImageViewURL: qrCodeImageViewURL,
            roomID: roomID,
            participants: participants
        )
    }
}
