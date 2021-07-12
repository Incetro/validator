//
//  ValidationError.swift
//  Validator IOS
//
//  Created by incetro on 6/28/21.
//

import Foundation

// MARK: - ValidationError

public protocol ValidationError: Error {

    /// Error message
    var message: String { get }
}

// MARK: - String

extension String: ValidationError {
    public var message: String { self }
}
