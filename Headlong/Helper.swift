//
//  Helper.swift
//  Headlong
//
//  Created by Holger Hinzberg on 28.09.25.
//  Copyright © 2025 Holger Hinzberg. All rights reserved.
//

/// Returns true if the input string is nil or empty.
/// - Parameter string: The optional string to check.
/// - Returns: Bool indicating whether the string is nil or empty.
func isNilOrEmpty(_ string: String?) -> Bool {
    return string?.isEmpty ?? true
}
