//
//  HistoryRepository.swift
//  LunchMatch
//
//  Created by Розалия Амирова on 07.11.2020.
//

import Foundation

protocol ProvidesHistory {
    func getHistoryItems(completion: @escaping (Result<[HistoryItem], Error>) -> Void)
}

class HistoryRepositoryMock: ProvidesHistory {
    
    func getHistoryItems(completion: @escaping (Result<[HistoryItem], Error>) -> Void) {
        let item = HistoryItem(imageLink: URL(string: "https://archello.com/thumbs/images/2018/01/31/IndustrialrusticJuanValdezCaf3.1517370772.9964.jpg?fit=crop&w=1920&h=1080")!, date: "April 19", placeName: "Cafe", participants: "My friends")
        completion(.success([item, item, item, item]))
    }
}
