//
//  ConditionValidationRule.swift
//  Validator IOS
//
//  Created by incetro on 6/28/21.
//

import Foundation

// MARK: - ConditionValidationRule

public struct ConditionValidationRule<T>: ValidationRule {

    // MARK: - Properties

    /// Validation error instance
    public let error: ValidationError

    /// Condition block
    public let condition: (T) -> Bool

    // MARK: - Initializers

    /// Default initializer
    /// - Parameters:
    ///   - condition: condition block
    ///   - error: validation error instance
    public init(condition: @escaping ((T) -> Bool), error: ValidationError = "") {
        self.condition = condition
        self.error = error
    }

    /// Validates the given input
    /// - Parameter input: an input instance
    public func validate(input: T) -> Bool {
        condition(input)
    }
}
