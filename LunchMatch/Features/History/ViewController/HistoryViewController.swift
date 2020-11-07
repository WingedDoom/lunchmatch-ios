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
        
        setupNavigationBar()
        loadHistory()
    }
    
    @objc
    func newSessionDidTap() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "RoomViewController") as! RoomViewController
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @objc
    func settingsDidTap() {
        
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title =  "Evgerher"
        navigationController?.navigationBar.backgroundColor = UIColor.yellow
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newSessionDidTap))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(settingsDidTap))
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
