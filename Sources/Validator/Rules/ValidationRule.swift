//
//  ValidationRule.swift
//  Validator IOS
//
//  Created by incetro on 6/28/21.
//

// MARK: - ValidationRule

public protocol ValidationRule {

    /// Input validation type
    associatedtype Input

    /// Validation error instance
    var error: ValidationError { get }

    /// Validates the given input
    /// - Parameter input: an input instance
    func validate(input: Input) -> Bool
}

extension ValidationRule {

    public func eraseToAnyValidationRule() -> AnyValidationRule<Input> {
        .init(base: self)
    }
}
