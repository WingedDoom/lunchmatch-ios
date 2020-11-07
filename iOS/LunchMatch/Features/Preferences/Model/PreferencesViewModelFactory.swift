//
//  PreferencesRepository.swift
//  LunchMatch
//
//  Created by Розалия Амирова on 07.11.2020.
//

import Foundation

protocol ProvidesPreferences {
    func getPreferences() -> PreferencesViewModel
    func selectSection(_ section: Int) 
}

class PreferencesViewModelFactory: ProvidesPreferences {
    
    let cuisineOptions = [PreferencesTableViewCellViewModel(title: "Chinese", isSelected: false),
                          PreferencesTableViewCellViewModel(title: "Tatar", isSelected: false),
                          PreferencesTableViewCellViewModel(title: "French", isSelected: false),
                          PreferencesTableViewCellViewModel(title: "Russian", isSelected: false),
                          PreferencesTableViewCellViewModel(title: "Ukranian", isSelected: false)]
    
    let allergiesOptions = [PreferencesTableViewCellViewModel(title: "No nuts", isSelected: false),
                            PreferencesTableViewCellViewModel(title: "No fish", isSelected: false),
                            PreferencesTableViewCellViewModel(title: "No diary", isSelected: false),
                            PreferencesTableViewCellViewModel(title: "diabetic", isSelected: false)]
    
    var data: PreferencesViewModel = PreferencesViewModel(sections: [])

    init() {
        let firstSection = PreferencesSection(header: PreferencesTableViewHeaderViewModel(title: "Cuisine",
                                                                                          counter: getCounter(cuisineOptions),
                                                                                          isOpened: false,
                                                                                          selectAction: { self.selectSection(0) }),
                                              cells: cuisineOptions)
        
        let secondSection = PreferencesSection(header: PreferencesTableViewHeaderViewModel(title: "Allergies and diets",
                                                                                           counter: getCounter(cuisineOptions),
                                                                                           isOpened: false,
                                                                                           selectAction: { self.selectSection(1) }),
                                               cells: allergiesOptions)
        
        data = PreferencesViewModel(sections: [firstSection, secondSection])
    }
    
    func getPreferences() -> PreferencesViewModel {
        let firstSection = PreferencesSection(header: PreferencesTableViewHeaderViewModel(title: "Cuisine",
                                                                                          counter: getCounter(cuisineOptions),
                                                                                          isOpened: false,
                                                                                          selectAction: { self.selectSection(0) }),
                                              cells: cuisineOptions)
        
        let secondSection = PreferencesSection(header: PreferencesTableViewHeaderViewModel(title: "Allergies and diets",
                                                                                           counter: getCounter(cuisineOptions),
                                                                                           isOpened: false,
                                                                                           selectAction: { self.selectSection(1) }),
                                               cells: allergiesOptions)
        
        data = PreferencesViewModel(sections: [firstSection, secondSection])
        return data
    }
    
    func selectSection(_ section: Int) {
        data.sections[section].header.isOpened = !data.sections[section].header.isOpened
        if data.sections[section].header.isOpened {
            data.sections[section].cells = section == 0 ? cuisineOptions : allergiesOptions
        } else {
            data.sections[section].cells = []
        }
    }
    
    func selectCell(at indexPath: IndexPath) {
        data.sections[indexPath.section].cells[indexPath.row].isSelected = !data.sections[indexPath.section].cells[indexPath.row].isSelected
        data.sections[indexPath.section].header.counter = getCounter(data.sections[indexPath.section].cells)
    }
    
    private func getCounter(_ cells: [PreferencesTableViewCellViewModel]) -> String {
        let selected = cells.filter { $0.isSelected }.count
        return "\(selected)\\\(cells.count)"
    }
}

