//
//  String+Extensions.swift
//  Heardstone
//
//  Created by Gerson Arbigaus on 01/06/23.
//

import Foundation
import UIKit

extension String {
    var htmlToAttributedString: NSMutableAttributedString? {
        let result = NSMutableAttributedString(string: "")
        var tagContent = ""
        var tagType: String?

        var i = 0
        while i < self.count {
            let index = self.index(self.startIndex, offsetBy: i)
            if self[index] == "<" {
                let tagStartIndex = self.index(index, offsetBy: 1)
                if let tagEndIndex = self[tagStartIndex...].firstIndex(of: ">") {
                    let tag = String(self[tagStartIndex..<tagEndIndex])
                    if tag == "/b" || tag == "/i" {
                        let attrs: [NSAttributedString.Key: Any]
                        if tagType == "b" {
                            attrs = [.font: UIFont.boldSystemFont(ofSize: 14)]
                        } else { // assuming it's "i"
                            attrs = [.font: UIFont.italicSystemFont(ofSize: 14)]
                        }
                        let attrStr = NSAttributedString(string: tagContent, attributes: attrs)
                        result.append(attrStr)
                        tagContent = ""
                        tagType = nil
                    } else {
                        tagType = tag
                    }
                    i += self.distance(from: tagStartIndex, to: tagEndIndex) + 2 // increase by 2 to skip '>'
                    continue
                }
            }
            if let _ = tagType {
                tagContent.append(self[index])
            } else {
                result.append(NSAttributedString(string: String(self[index])))
            }
            i += 1
        }

        // Append the remaining tagContent (if any) without any styling.
        if !tagContent.isEmpty {
            result.append(NSAttributedString(string: tagContent))
        }

        return result
    }


    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
