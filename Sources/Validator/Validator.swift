//
//  Validator.swift
//  Validator IOS
//
//  Created by incetro on 6/28/21.
//

// MARK: - Validator

public struct Validator {

    public func validate<Rule: ValidationRule>(input: Rule.Input, rule: Rule) -> ValidationResult {
        validate(input: input, rules: [AnyValidationRule<Rule.Input>(base: rule)])
    }

    public func validate<Input>(input: Input, rules: AnyValidationRule<Input>...) -> ValidationResult {
        validate(input: input, rules: rules)
    }

    public func validate<Input>(input: Input, rules: [AnyValidationRule<Input>]) -> ValidationResult {
        let errors = rules
            .filter { !$0.validate(input: input) }
            .map { $0.error }
        return errors.isEmpty ? .valid : .invalid(errors)
    }
}
