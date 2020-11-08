//
//  HistoryRepository.swift
//  LunchMatch
//
//  Created by Розалия Амирова on 07.11.2020.
//

import Foundation

protocol ProvidesOptions {
    func getOptionsItems(completion: @escaping (Result<[OptionItem], Error>) -> Void)
    func submit(onMatch: @escaping (String) -> Void)
}

class OptionsRepositoryMock: ProvidesOptions {
    
    private let mockOptions: [OptionItem] = [
        .init(
            imageLink: URL(string: "https://vilunov.me/junction/3.png")!,
            placeName: "Dinner in the Sky",
            description: "Over 30 countries worldwide. Bring your dining experience to new heights at Dinner in the Sky."
        ),
        .init(
            imageLink: URL(string: "https://vilunov.me/junction/5.png")!,
            placeName: "The Blue Oyster",
            description: "Looking for a unique way to unwind? The Blue Oyster gives you just that, as you’re seated in a swing for the entirety of your dining experience."
        ),
        .init(
            imageLink: URL(string: "https://vilunov.me/junction/1.png")!,
            placeName: "Bar 107 Burger & Beer",
            description: "Burgers, beer and a pleasant atmosphere are all you need for a great evening."
        )
    ]
    
    func getOptionsItems(completion: @escaping (Result<[OptionItem], Error>) -> Void) {
        completion(.success(mockOptions))
    }
    
    func submit(onMatch: @escaping (String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            onMatch(self.mockOptions[1].placeName)
        }
    }
}
