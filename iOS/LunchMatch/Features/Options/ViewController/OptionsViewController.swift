//
//  HistoryViewController.swift
//  LunchMatch
//
//  Created by Розалия Амирова on 07.11.2020.
//

import UIKit

class OptionsViewController: UIViewController {
    
    let repository: ProvidesOptions = OptionsRepositoryMock()
    
    private var optionsView: OptionsView {
        view as! OptionsView
    }
    
    override func loadView() {
        view = OptionsView()
        view.backgroundColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLoadOptions()
    }
    
    
    @objc
    func settingsDidTap() {
        
    }
    
    private func loadLoadOptions() {
        repository.getOptionsItems { response in
            switch response {
            case let .success(result):
                self.optionsView.configure(with: self.parseResult(result))
                
            case .failure:
                return
            }
        }
    }
    
    private func parseResult(_ historyItems: [OptionItem]) -> [OptionsCollectionViewModel] {
        historyItems.map { OptionsCollectionViewModel(imageLink: $0.imageLink, placeName: $0.placeName, participants: $0.participants) }
    }
}
