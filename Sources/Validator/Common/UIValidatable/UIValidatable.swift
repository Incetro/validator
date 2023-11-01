//
//  UIValidatable.swift
//  Validator IOS
//
//  Created by incetro on 6/28/21.
//

import Foundation

// MARK: - UIValidatable

public protocol UIValidatable: AnyObject {

    /// Input validation type
    associatedtype Input: Validatable

    /// Input validation value
    var inputValue: Input { get }

    /// Validate current object with the given rule
    /// - Parameter rule: a rule
    func validate<Rule: ValidationRule>(rule: Rule) -> ValidationResult where Rule.Input == Input

    /// Validate current object with the given rules
    /// - Parameter rules: target rules
    func validate<Rule: ValidationRule>(rules: Rule...) -> ValidationResult where Rule.Input == Input

    /// Validate current object with the given rules
    /// - Parameter rules: target rules
    func validate<Rule: ValidationRule>(rules: [Rule]) -> ValidationResult where Rule.Input == Input

    /// Handler which calls on every `validate` call
    var validationHandler: ((ValidationResult) -> Void)? { get set }

    /// Enable/Disable `validationHandler` logic
    /// - Parameter enabled: true if we need to enable `validationHandler` logic
    func validateOnInputChange(enabled: Bool)
}

private var ValidatableInterfaceElementRulesKey: UInt8 = 0
private var ValidatableInterfaceElementHandlerKey: UInt8 = 0

extension UIValidatable {

    /// Validate current object with the given rule
    /// - Parameter rule: a rule
    public func validate<Rule: ValidationRule>(rule: Rule) -> ValidationResult where Rule.Input == Input {
        let result = validator.validate(input: inputValue, rule: rule)
        validationHandler?(result)
        return result
    }

    /// Validate current object with the given rules
    /// - Parameter rules: target rules
    public func validate<Rule: ValidationRule>(rules: Rule...) -> ValidationResult where Rule.Input == Input {
        validate(rules: rules)
    }

    /// Validate current object with the given rules
    /// - Parameter rules: target rules
    public func validate<Rule: ValidationRule>(rules: [Rule]) -> ValidationResult where Rule.Input == Input {
        let result = validator.validate(input: inputValue, rules: rules.map { $0.eraseToAnyValidationRule() })
        validationHandler?(result)
        return result
    }

    /// Add a new rule to current element rules set
    /// - Parameter rule: a new rule
    public func add<Rule: ValidationRule>(rule: Rule) where Rule.Input == Input {
        validationRules.append(rule.eraseToAnyValidationRule())
    }

    /// Validate value with currently stored rules
    /// - Returns: ValidationResult type
    @discardableResult public func validate() -> ValidationResult {
        validate(rules: validationRules)
    }

    /// Currently stored validation rules
    public var validationRules: [AnyValidationRule<Input>] {
        get {
            objc_getAssociatedObject(self, &ValidatableInterfaceElementRulesKey) as? [AnyValidationRule<Input>] ?? []
        }
        set(newValue) {
            objc_setAssociatedObject(self, &ValidatableInterfaceElementRulesKey, newValue as AnyObject, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    /// Handler which calls on every `validate` call
    public var validationHandler: ((ValidationResult) -> Void)? {
        get {
            objc_getAssociatedObject(self, &ValidatableInterfaceElementHandlerKey) as? (ValidationResult) -> Void
        }
        set(newValue) {
            if let n = newValue {
                objc_setAssociatedObject(self, &ValidatableInterfaceElementHandlerKey, n as AnyObject, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}
