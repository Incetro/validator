//
//  UITextField.swift
//  Validator IOS
//
//  Created by incetro on 6/28/21.
//

import UIKit

// MARK: - UIValidatable

extension UITextField: UIValidatable {

    /// Input validation value
    public var inputValue: String { text ?? "" }

    /// Enable/Disable validation logic for .editingChanged event
    /// - Parameter enabled: true if we need to enable validation logic
    public func validateOnInputChange(enabled: Bool) {
        if enabled {
            addTarget(self, action: #selector(performValidation), for: .editingChanged)
        } else {
            removeTarget(self, action: #selector(performValidation), for: .editingChanged)
        }
    }

    /// Enable/Disable validation logic for .editingDidEnd event
    /// - Parameter enabled: true if we need to enable validation logic
    public func validateOnEditingEnd(enabled: Bool) {
        if enabled {
            addTarget(self, action: #selector(performValidation), for: .editingDidEnd)
        } else {
            removeTarget(self, action: #selector(performValidation), for: .editingDidEnd)
        }
    }

    /// Perform validation logic
    /// - Parameter sender: sender instance
    @objc private func performValidation(_ sender: UITextField) {
        sender.validate()
    }
}
