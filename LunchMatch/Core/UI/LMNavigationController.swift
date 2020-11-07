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
        
        navigationBar.tintColor = R.color.action()
        navigationBar.prefersLargeTitles = true
        
        let largeFont = UIFont(name: "Cochin-Bold", size: 34) ?? .preferredFont(forTextStyle: .largeTitle)
        let regularFont = UIFont(name: "Cochin-Bold", size: 18) ?? .preferredFont(forTextStyle: .title1)
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [
            .foregroundColor: R.color.textPrimary()!,
            .font: largeFont
        ]
        appearance.titleTextAttributes = [
            .foregroundColor: R.color.textPrimary()!,
            .font: regularFont
        ]
        appearance.backgroundColor = R.color.backgroundPrimary()
        
        navigationBar.compactAppearance = appearance
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}
