//
//  EqualityValidationRule.swift
//  Validator IOS
//
//  Created by incetro on 6/28/21.
//

// MARK: - EqualityValidationRule

public struct EqualityValidationRule<T: Equatable>: ValidationRule {

    // MARK: - Properties

    /// Static value for comparison
    public let target: T?

    /// Dynamic target value for comparison
    public let dynamicTarget: (() -> T)?

    /// Validation error instance
    public let error: ValidationError

    // MARK: - Initializers

    /// Initializer with static value
    /// - Parameters:
    ///   - target: static value for comparison
    ///   - error: validation error instance
    public init(target: T, error: ValidationError) {
        self.target = target
        self.error = error
        self.dynamicTarget = nil
    }

    /// Initializer with dynamic value
    /// - Parameters:
    ///   - target: dynamic value for comparison
    ///   - error: validation error instance
    public init(dynamicTarget: @escaping () -> T, error: ValidationError = "") {
        self.dynamicTarget = dynamicTarget
        self.error = error
        self.target = nil
    }

    /// Validates the given input
    /// - Parameter input: an input instance
    public func validate(input: T) -> Bool {
        if let dynamicTarget = dynamicTarget {
            return input == dynamicTarget()
        }
        guard let target = target else {
            return false
        }
        return input == target
    }
}
