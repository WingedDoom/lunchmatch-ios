//
//  HistoryViewController.swift
//  LunchMatch
//
//  Created by Розалия Амирова on 07.11.2020.
//

import UIKit


class HistoryViewController: UIViewController {
    
    let repository: ProvidesHistory = HistoryRepositoryMock()
    
    private var historyView: HistoryView {
        view as! HistoryView
    }
    
    override func loadView() {
        view = HistoryView()
        view.backgroundColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadHistory()
    }
    
    @objc
    func settingsDidTap() {
        
    }
    
    private func loadHistory() {
        repository.getHistoryItems { response in
            switch response {
            case let .success(result):
                self.historyView.configure(with: self.parseResult(result))
                
            case .failure:
                return
            }
        }
    }
    
    private func parseResult(_ historyItems: [HistoryItem]) -> [MatchCollectionViewModel] {
        historyItems.map { MatchCollectionViewModel(imageLink: $0.imageLink, date: $0.date, placeName: $0.placeName, participants: $0.participants) }
    }
}
