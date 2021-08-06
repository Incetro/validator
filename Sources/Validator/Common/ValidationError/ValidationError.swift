//
//  ValidationError.swift
//  Validator IOS
//
//  Created by incetro on 6/28/21.
//

// MARK: - ValidationError

public protocol ValidationError: Error {

    /// Error message
    var message: String { get }
}

// MARK: - String

extension String: ValidationError {

    /// Error message
    public var message: String { self }
}
