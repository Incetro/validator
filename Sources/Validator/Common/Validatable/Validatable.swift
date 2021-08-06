//
//  Validatable.swift
//  Validator IOS
//
//  Created by incetro on 6/28/21.
//

let validator = Validator()

// MARK: - Validatable

public protocol Validatable {

    /// Validate current object with the given rule
    /// - Parameter rule: a rule
    func validate<Rule: ValidationRule>(rule: Rule) -> ValidationResult where Rule.Input == Self

    /// Validate current object with the given rules
    /// - Parameter rules: rules list
    func validate<Rule: ValidationRule>(rules: Rule...) -> ValidationResult where Rule.Input == Self

    /// Validate current object with the given rules
    /// - Parameter rules: rules list
    func validate<Rule: ValidationRule>(rules: [Rule]) -> ValidationResult where Rule.Input == Self
}

// MARK: - Default

extension Validatable {

    /// Validate current object with the given rule
    /// - Parameter rule: a rule
    public func validate<Rule: ValidationRule>(rule: Rule) -> ValidationResult where Rule.Input == Self {
        validator.validate(input: self, rule: rule)
    }

    /// Validate current object with the given rules
    /// - Parameter rules: rules list
    public func validate<Rule: ValidationRule>(rules: Rule...) -> ValidationResult where Rule.Input == Self {
        validate(rules: rules)
    }

    /// Validate current object with the given rules
    /// - Parameter rules: rules list
    public func validate<Rule: ValidationRule>(rules: [Rule]) -> ValidationResult where Rule.Input == Self {
        let rules = rules.map(AnyValidationRule.init)
        return validator.validate(input: self, rules: rules)
    }
}

// MARK: - Validatable extensions

extension String: Validatable {}
extension Double: Validatable {}
extension Float: Validatable {}
extension Array: Validatable {}
extension Date: Validatable {}
extension Int: Validatable {}
