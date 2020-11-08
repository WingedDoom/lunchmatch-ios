//
//  PreferencesViewController.swift
//  LunchMatch
//
//  Created by Розалия Амирова on 07.11.2020.
//

import UIKit

class PreferencesViewController: UIViewController {
    
    private var preferencesView: PreferencesView {
        view as! PreferencesView
    }
    
    override func loadView() {
        view = PreferencesView()
        view.backgroundColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nextButton = UIBarButtonItem()
        nextButton.title = R.string.localizable.preferencesNextButtonTitle()
        nextButton.target = self
        nextButton.action = #selector(didTapNextButton)
        navigationItem.rightBarButtonItem = nextButton
    }
}

extension PreferencesViewController: MatchingViewControllerDelegate {
    func didFinishMatching() {
        dismiss(animated: true) { [weak self] in
            self?.presentOptions()
        }
    }
}

private extension PreferencesViewController {
    @objc func didTapNextButton() {
        presentMatchingProcess()
    }
    
    func presentMatchingProcess() {
        let vc = MatchingViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func presentOptions() {
        let vc = OptionsViewController()
        navigationController?.show(vc, sender: self)
    }
}
