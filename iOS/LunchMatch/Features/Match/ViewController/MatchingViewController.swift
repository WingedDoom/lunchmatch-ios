//
//  MatchingViewController.swift
//  LunchMatch
//
//  Created by Розалия Амирова on 07.11.2020.
//

import UIKit

protocol MatchingViewControllerDelegate: AnyObject {
    func didFinishMatching()
}

class MatchingViewController: UIViewController {
    weak var delegate: MatchingViewControllerDelegate?
    let repository = MatchingRepositoryMock()
    
    private var matchingView: MatchingView {
        return view as! MatchingView
    }
    
    override func loadView() {
        view = MatchingView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repository.match()
        repository.delegate = self
    }
}

extension MatchingViewController: MatchingDataRepositoryDelegate {
    func didFinishMatching(users: [String], finalMatch: Bool) {
        matchingView.finishedUserNames = users
        if finalMatch {
            delegate?.didFinishMatching()
        }
    }
}
