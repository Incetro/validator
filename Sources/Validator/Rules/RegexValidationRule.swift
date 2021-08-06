//
//  RegexValidationRule.swift
//  Validator IOS
//
//  Created by incetro on 6/28/21.
//

// MARK: - RegexValidationRule

public struct RegexValidationRule: ValidationRule {

    // MARK: - Properties

    /// Regular expression string
    public let pattern: String

    /// Validation error instance
    public let error: ValidationError

    // MARK: - Initializers

    /// Default initializer
    /// - Parameters:
    ///   - pattern: regular expression string
    ///   - error: validation error instance
    public init(pattern: String, error: ValidationError = "") {
        self.pattern = pattern
        self.error = error
    }

    /// Validates the given input
    /// - Parameter input: an input instance
    public func validate(input: String) -> Bool {
        do {
            let range = NSRange(location: 0, length: input.utf16.count)
            let regex = try NSRegularExpression(pattern: pattern)
            return regex.firstMatch(in: input, options: [], range: range) != nil
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }
}
