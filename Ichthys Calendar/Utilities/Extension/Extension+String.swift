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
    
    var html2StringCustomREG: String {
        let openingTagPattern = "<.*?>"
        let regex = try! NSRegularExpression(pattern: openingTagPattern, options: [.caseInsensitive] )
        let range = NSRange(location: 0, length: self.count)
        let newString = regex.stringByReplacingMatches(in: self, options: [], range:range, withTemplate: "")
        
        if let index = (newString.range(of: "Перевод:")?.lowerBound) {
            let beforeEqualsTo = String(newString.prefix(upTo: index))
            let replacedString = beforeEqualsTo.replacingOccurrences(of: "/", with: "")
            return replacedString.replacingOccurrences(of: "</p>", with: "")
        }
        return newString
    }
    
    var html2StringCustomREGLite: String {
        let openingTagPattern = "<.*?>"
        let regex = try! NSRegularExpression(pattern: openingTagPattern, options: [.caseInsensitive] )
        let range = NSRange(location: 0, length: self.count)
        let newString = regex.stringByReplacingMatches(in: self, options: [], range:range, withTemplate: "")
        
        if let index = (newString.range(of: "Купить книгу:")?.lowerBound) {
            let beforeEqualsTo = String(newString.prefix(upTo: index))
            let replacedString = beforeEqualsTo.replacingOccurrences(of: "/", with: "")
            return replacedString.replacingOccurrences(of: "</p>", with: "")
        }
        return newString
    }
    
}


