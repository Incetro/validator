//
//  Regex.swift
//  Example
//
//  Created by Alexander Lezya on 12.07.2021.
//

// MARK: - Regex

enum Regex {
    static let email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    static let username = "^[a-zA-Z_]{1}[a-zA-Z0-9_]{2,18}$"
    static let password = "^[0-9a-zA-Z!@#$%^&*]{8,32}$"
}
