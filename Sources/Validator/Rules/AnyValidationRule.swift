//
//  AnyValidationRule.swift
//  Validator IOS
//
//  Created by incetro on 6/28/21.
//

import Foundation

// MARK: - AnyValidationRule

public struct AnyValidationRule<Input>: ValidationRule {

    // MARK: - Properties

    /// Validation error instance
    public let error: ValidationError

    /// Internal validation block
    private let baseValidateInput: (Input) -> Bool

    // MARK: - Initializers

    /// Default initializer
    /// - Parameter base: target validation rule for wrapping
    public init<Rule: ValidationRule>(base: Rule) where Rule.Input == Input {
        baseValidateInput = base.validate
        error = base.error
    }

    // MARK: - ValidationRule

    /// Validates the given input
    /// - Parameter input: an input instance
    public func validate(input: Input) -> Bool {
        baseValidateInput(input)
    }
}
