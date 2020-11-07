//
//  HistoryItem.swift
//  LunchMatch
//
//  Created by Розалия Амирова on 07.11.2020.
//

import Foundation

struct HistoryItem: Codable {
    let imageLink: URL
    let date: String
    let placeName: String
    let participants: String
}
