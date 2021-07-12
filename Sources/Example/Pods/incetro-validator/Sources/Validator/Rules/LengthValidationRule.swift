//
//  LengthValidationRule.swift
//  Validator IOS
//
//  Created by incetro on 6/28/21.
//

import Foundation

// MARK: - LengthValidationRule

public struct LengthValidationRule: ValidationRule {

    // MARK: - Properties

    /// Min length value
    public let min: Int

    /// Max length value
    public let max: Int

    /// Validation error instance
    public let error: ValidationError

    // MARK: - Initializers

    /// Default initializer
    /// - Parameters:
    ///   - min: min length value
    ///   - max: max length value
    ///   - error: validation error instance
    public init(min: Int = 0, max: Int = .max, error: ValidationError = "") {
        self.min = min
        self.max = max
        self.error = error
    }

    // MARK: - ValidationRule

    /// Validates the given input
    /// - Parameter input: an input instance
    public func validate(input: String) -> Bool {
        let length = input.count
        return length >= min && length <= max
    }
}
