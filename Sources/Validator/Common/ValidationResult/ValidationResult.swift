//
//  ValidationResult.swift
//  Validator IOS
//
//  Created by incetro on 6/28/21.
//

import Foundation

// MARK: - ValidationResult

public enum ValidationResult {

    // MARK: - Cases

    case valid
    case invalid([ValidationError])

    public var isValid: Bool {
        self == .valid
    }
}

// MARK: - Equatable

extension ValidationResult: Equatable {

    public static func == (lhs: ValidationResult, rhs: ValidationResult) -> Bool {
        switch (lhs, rhs) {
        case (.valid, .valid):
            return true
        case (.invalid(let left), .invalid(let right)):
            return left.map(\.message).joined() == right.map(\.message).joined()
        default:
            return false
        }
    }
}
