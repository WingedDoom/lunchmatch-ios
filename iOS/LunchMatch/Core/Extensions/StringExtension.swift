//
//  StringExtension.swift
//  LunchMatch
//
//  Created by Булат Хабиров on 07.11.2020.
//

import UIKit

extension String {
    func getSizeWithConstrainedSize(_ constraintRect: CGSize, font: UIFont) -> CGSize {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping

        let boundingBox = (self as NSString).boundingRect(
            with: constraintRect,
            options: NSStringDrawingOptions.usesLineFragmentOrigin,
            attributes: [
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
            ],
            context: nil
        )

        return boundingBox.size
    }
}
