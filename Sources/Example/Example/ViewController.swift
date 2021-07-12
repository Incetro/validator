//
//  ViewController.swift
//  Example
//
//  Created by Alexander Lezya on 11.07.2021.
//

import Layout
import AloeStackView
import Validator

// MARK: - ViewController

class ViewController: UIViewController {

    // MARK: - Properties

    /// Title label
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Сells with examples"
        titleLabel.textColor = .black
        return titleLabel
    }()

    /// Current content AloeStackView
    private let stackView: AloeStackView = {
        let stackView = AloeStackView()
        stackView.separatorColor = .clear
        stackView.backgroundColor = .clear
        return stackView
    }()

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupStackView()
        setup()
    }

    // MARK: - Setup

    /// Current stack view setup
    private func setupStackView() {
        view.addSubview(stackView.prepareForAutolayout())
        stackView.pinToSuperview(excluding: .top)
        stackView.top(to: view.top + Constants.stackViewTopInset)
    }

    private func setup() {
        setupTitleLabel()

        addSection(sectionName: "Regex")
        setupRegexUsernameCell()
        setupRegexEmailCell()

        addSection(sectionName: "Length")
        setupMinimumLengthCell()
        setupRangeLengthCell()

        addSection(sectionName: "Equality")
        setupConditionCell()
        setupEqualityCell()
        setupPasswordCells()
    }

    private func setupTitleLabel() {
        view.addSubview(titleLabel.prepareForAutolayout())
        titleLabel
            .top(to: view.top + Constants.titleLabelTopInset)
            .centerX(to: view.centerX)
    }

    private func setupRegexUsernameCell() {
        let usernameCell = TextFieldCell()
        usernameCell.title = "Username:"
        usernameCell.placeholder = "Regex validation username"
        usernameCell.textField.add(rule: RegexValidationRule(pattern: Regex.username))
        usernameCell.textField.validationHandler = {
            usernameCell.visualizationValidate(isValid: $0.isValid)
        }
        stackView.addRow(usernameCell)
        stackView.setInset(forRow: usernameCell, inset: Constants.cellInsets)
        usernameCell.updateConers(.first)
    }

    private func setupRegexEmailCell() {
        let mailCell = TextFieldCell()
        mailCell.title = "Email:"
        mailCell.placeholder = "Regex validation email"
        mailCell.textField.add(rule: RegexValidationRule(pattern: Regex.email))
        mailCell.textField.validationHandler = {
            mailCell.visualizationValidate(isValid: $0.isValid)
        }
        stackView.addRow(mailCell)
        stackView.setInset(forRow: mailCell, inset: Constants.cellInsets)
        mailCell.updateConers(.last)
    }

    private func setupMinimumLengthCell() {
        let minimumLengthCell = TextFieldCell()
        minimumLengthCell.title = "Min length:"
        minimumLengthCell.placeholder = "Min length is 5"
        minimumLengthCell.textField.add(rule: LengthValidationRule(min: 5))
        minimumLengthCell.textField.validationHandler = {
            minimumLengthCell.visualizationValidate(isValid: $0.isValid)
        }
        stackView.addRow(minimumLengthCell)
        stackView.setInset(forRow: minimumLengthCell, inset: Constants.cellInsets)
        minimumLengthCell.updateConers(.first)
    }

    private func setupRangeLengthCell() {
        let rangeLengthCell = TextFieldCell()
        rangeLengthCell.title = "Range length:"
        rangeLengthCell.placeholder = "Min length is 5, max length is 10"
        rangeLengthCell.textField.add(rule: LengthValidationRule(min: 5, max: 10))
        rangeLengthCell.textField.validationHandler = {
            rangeLengthCell.visualizationValidate(isValid: $0.isValid)
        }
        stackView.addRow(rangeLengthCell)
        stackView.setInset(forRow: rangeLengthCell, inset: Constants.cellInsets)
        rangeLengthCell.updateConers(.last)
    }

    private func setupConditionCell() {
        let conditionCell = TextFieldCell()
        conditionCell.title = "Condition:"
        conditionCell.placeholder = "If entered text is equal to: \"text\""
        conditionCell.textField.add(rule: ConditionValidationRule { $0 == "text" })
        conditionCell.textField.validationHandler = {
            conditionCell.visualizationValidate(isValid: $0.isValid)
        }
        stackView.addRow(conditionCell)
        stackView.setInset(forRow: conditionCell, inset: Constants.cellInsets)
        conditionCell.updateConers(.first)
    }

    private func setupEqualityCell() {
        let equalityCell = TextFieldCell()
        equalityCell.title = "Equality:"
        equalityCell.placeholder = "Equality validation to: \"apple\""
        equalityCell.textField.add(rule: EqualityValidationRule { "apple" })
        equalityCell.textField.validationHandler = {
            equalityCell.visualizationValidate(isValid: $0.isValid)
        }
        stackView.addRow(equalityCell)
        stackView.setInset(forRow: equalityCell, inset: Constants.cellInsets)
        equalityCell.updateConers(.regular)
    }

    private func setupPasswordCells() {
        let firstPasswordCell = TextFieldCell()
        firstPasswordCell.title = "Password:"
        firstPasswordCell.placeholder = "Enter password"
        firstPasswordCell.textField.isSecureTextEntry = true
        firstPasswordCell.textField.add(rule: RegexValidationRule(pattern: Regex.password))
        stackView.addRow(firstPasswordCell)
        stackView.setInset(forRow: firstPasswordCell, inset: Constants.cellInsets)
        firstPasswordCell.updateConers(.regular)

        let secondPasswordCell = TextFieldCell()
        secondPasswordCell.title = "Repeat password:"
        secondPasswordCell.placeholder = "Repeat password"
        secondPasswordCell.textField.isSecureTextEntry = true
        secondPasswordCell.textField.add(
            rule: ConditionValidationRule { $0 == firstPasswordCell.textField.text }
        )
        secondPasswordCell.textField.validationHandler = {
            secondPasswordCell.visualizationValidate(isValid: $0.isValid)
        }
        stackView.addRow(secondPasswordCell)
        stackView.setInset(forRow: secondPasswordCell, inset: Constants.cellInsets)
        secondPasswordCell.updateConers(.last)

        firstPasswordCell.textField.validationHandler = {
            firstPasswordCell.visualizationValidate(isValid: $0.isValid)
            secondPasswordCell.textField.text = ""
            secondPasswordCell.textField.rightViewMode = .never
        }
    }

    private func addSection(sectionName: String) {
        let sectionLabel = UILabel()
        sectionLabel.text = sectionName
        sectionLabel.textColor = UIColor(hexString: "#8A8A8F")
        stackView.addRow(sectionLabel)
        stackView.setInset(forRow: sectionLabel, inset: Constants.sectionInsets)
    }
}

// MARK: - Constants

extension ViewController {

    enum Constants {
        static let stackViewTopInset: CGFloat = 75
        static let titleLabelTopInset: CGFloat = 50
        static let cellInsets = UIEdgeInsets(top: 1, left: 16, bottom: 1, right: 16)
        static let sectionInsets = UIEdgeInsets(top: 16, left: 30, bottom: 8, right: 16)
    }
}
