//
//  PreferencesViewModel.swift
//  LunchMatch
//
//  Created by Розалия Амирова on 07.11.2020.
//

import Foundation

struct PreferencesViewModel {
    var sections: [PreferencesSection]
}

struct PreferencesSection {
    var header: PreferencesTableViewHeaderViewModel
    var cells: [PreferencesTableViewCellViewModel]
}

struct PreferencesTableViewCellViewModel {
    let title: String
    var isSelected: Bool
}

struct PreferencesTableViewHeaderViewModel {
    let title: String
    var counter: String
    var isOpened: Bool
    let selectAction: () -> Void
}
