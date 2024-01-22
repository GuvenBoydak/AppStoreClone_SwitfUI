//
//  CustomString.swift
//  AppStoreClone
//
//  Created by Güven Boydak on 18.01.2024.
//

import Foundation
import SwiftUI

extension String {
    func trimSquareBrackets() -> String {
        return self.replacingOccurrences(of: "【", with: "").replacingOccurrences(of: "】", with: "")
    }
}

extension String {
    func locale() -> LocalizedStringKey {
        return LocalizedStringKey(self)
    }
}
