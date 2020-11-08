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
        completion(.success([
            .init(
                imageLink: <#T##URL#>,
                placeName: <#T##String#>,
                description: <#T##String#>
            )
        ]))
    }
}
