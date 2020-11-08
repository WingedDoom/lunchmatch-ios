//
//  MatchingRepository.swift
//  LunchMatch
//
//  Created by Розалия Амирова on 07.11.2020.
//

import Foundation

protocol ProvidesMatchingData: AnyObject {
    func match()
    var delegate: MatchingDataRepositoryDelegate? { get set }
}

protocol MatchingDataRepositoryDelegate: AnyObject {
    func didFinishMatching(users: [String], finalMatch: Bool)
}

class MatchingRepositoryMock: ProvidesMatchingData {
    private var allMockUsers = [
        "real_shrek",
        "Cutie",
        "HungryGuy98",
        "MemeLord",
    ]
    private var users: [String] = [] {
        didSet {
            delegate?.didFinishMatching(users: users, finalMatch: false)
        }
    }
    
    weak var delegate: MatchingDataRepositoryDelegate?
    
    func match() {
        updateMockUsers()
    }
    
    private func updateMockUsers() {
        guard users.count < allMockUsers.count else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.delegate?.didFinishMatching(users: self.users, finalMatch: true)
            }
            return
        }
        
        let intervals: [TimeInterval] = [1, 0.3, 1.83, 0.8]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + intervals[users.count]) { [weak self] in
            guard let self = self else { return }
            self.users.append(self.allMockUsers[self.users.count])
            self.updateMockUsers()
        }
    }
}
