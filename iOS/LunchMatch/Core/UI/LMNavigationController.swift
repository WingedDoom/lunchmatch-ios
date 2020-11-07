//
//  LMNavigationController.swift
//  LunchMatch
//
//  Created by Булат Хабиров on 07.11.2020.
//

import UIKit

final class LMNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [
            .foregroundColor: R.color.textPrimary()!,
            .font: UIFont.appLargeTitle
        ]
        appearance.titleTextAttributes = [
            .foregroundColor: R.color.textPrimary()!,
            .font: UIFont.appRegularTitle
        ]
        appearance.backgroundColor = R.color.backgroundPrimary()
        
        navigationBar.compactAppearance = appearance
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        
        navigationBar.tintColor = R.color.action()
    }
}
