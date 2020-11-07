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
    }
}
