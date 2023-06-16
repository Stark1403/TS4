//
//  String.swift
//  TestTS4
//
//  Created by cesar.torres on 14/06/23.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: .main, value: "", comment: "")
    }
}
