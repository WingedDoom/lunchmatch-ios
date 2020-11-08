//
//  HistoryViewController.swift
//  LunchMatch
//
//  Created by Розалия Амирова on 07.11.2020.
//

import UIKit

class OptionsViewController: UIViewController {
    
    let repository: ProvidesOptions = OptionsRepositoryMock()
    lazy var submitButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = R.string.localizable.optionsSubmitButtonTitle()
        button.target = self
        button.action = #selector(didTapSubmit)
        
        return button
    }()
    
    private var optionsView: OptionsView {
        view as! OptionsView
    }
    
    override func loadView() {
        view = OptionsView()
        view.backgroundColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = R.string.localizable.optionsTitle()
        navigationItem.rightBarButtonItem = submitButton
        
        loadOptions()
    }
    
    
    @objc
    private func didTapSubmit() {
        submit()
    }
    
    private func loadOptions() {
        repository.getOptionsItems { response in
            switch response {
            case let .success(result):
                self.optionsView.configure(with: self.parseResult(result))
                
            case .failure:
                return
            }
        }
    }
    
    private func submit() {
        submitButton.isEnabled = false
        submitButton.title = R.string.localizable.optionsSubmitWaitingButtonTitle()
        repository.submit { [weak self] placeName in
            guard let self = self else { return }
            self.submitButton.isEnabled = true
            self.submitButton.title = R.string.localizable.optionsSubmitButtonTitle()
            self.presentFinalAlert(with: placeName)
        }
    }
    
    private func presentFinalAlert(with placeName: String) {
        let alert = UIAlertController(
            title: R.string.localizable.optionsFinalAlertTitle(),
            message: R.string.localizable.optionsFinalAlertText(placeName),
            preferredStyle: .alert
        )
        alert.addAction(.init(title: R.string.localizable.optionsFinalAlertOkTitle(), style: .default, handler: { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        
        present(alert, animated: true)
    }
    
    private func parseResult(_ options: [OptionItem]) -> [OptionsCollectionViewModel] {
        options.map { OptionsCollectionViewModel(imageLink: $0.imageLink, placeName: $0.placeName, description: $0.description) }
    }
}
