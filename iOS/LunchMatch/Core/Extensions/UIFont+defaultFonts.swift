//
//  UIFont+defaultFonts.swift
//  LunchMatch
//
//  Created by Булат Хабиров on 07.11.2020.
//

import UIKit

extension UIFont {
    static var appLargeTitle: UIFont {
        UIFont(name: "Cochin-Bold", size: 34) ?? .preferredFont(forTextStyle: .largeTitle)
    }
    
    static var appRegularTitle: UIFont {
        UIFont(name: "Cochin-Bold", size: 18) ?? .preferredFont(forTextStyle: .title1)
    }
    
    static var appTitle1: UIFont {
        UIFont(name: "Cochin-Bold", size: 28) ?? .preferredFont(forTextStyle: .title1)
    }
    
    static var appBody: UIFont {
        UIFont(name: "Cochin", size: 17) ?? .preferredFont(forTextStyle: .body)
    }
    
    static var appCaption1: UIFont {
        UIFont(name: "Cochin", size: 14) ?? .preferredFont(forTextStyle: .caption1)
    }
    
    static var appCaption2: UIFont {
        UIFont(name: "Cochin", size: 12) ?? .preferredFont(forTextStyle: .caption2)
    }
}
