//
//  RoomRepository.swift
//  LunchMatch
//
//  Created by Розалия Амирова on 07.11.2020.
//

import Foundation

protocol RoomRepository {
    func getRoomInfo(completion: @escaping (Result<RoomItem, Error>) -> Void)
}

class RoomRepositoryMock: RoomRepository {
    
    func getRoomInfo(completion: @escaping (Result<RoomItem, Error>) -> Void) {
        let item = RoomItem(qrCodeImageViewURL: URL(string: "https://archello.com/thumbs/images/2018/01/31/IndustrialrusticJuanValdezCaf3.1517370772.9964.jpg?fit=crop&w=1920&h=1080")!, roomID: "qwerty")
        completion(.success(item))
    }
}
