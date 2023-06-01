//
//  Array+Extensions.swift
//  Heardstone
//
//  Created by Gerson Arbigaus on 31/05/23.
//

import Foundation

extension Array where Element: Hashable {
    var removingDuplicates: [Element] {
        var addedDict = [Element: Bool]()
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates
    }
}
