//
//  HistoryRepository.swift
//  LunchMatch
//
//  Created by Розалия Амирова on 07.11.2020.
//

import Foundation

protocol ProvidesOptions {
    func getOptionsItems(completion: @escaping (Result<[OptionItem], Error>) -> Void)
}

class OptionsRepositoryMock: ProvidesOptions {
    
    func getOptionsItems(completion: @escaping (Result<[OptionItem], Error>) -> Void) {
        let item = OptionItem(imageLink: URL(string: "https://archello.com/thumbs/images/2018/01/31/IndustrialrusticJuanValdezCaf3.1517370772.9964.jpg?fit=crop&w=1920&h=1080")!, placeName: "Cafe", participants: "My friends")
        completion(.success([item, item, item, item]))
    }
}
