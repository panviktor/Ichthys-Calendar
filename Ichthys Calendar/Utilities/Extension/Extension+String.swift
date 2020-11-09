//
//  Extension+String.swift
//  Ichthys Calendar
//
//  Created by Viktor on 09.11.2020.
//

import Foundation

extension String {
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
