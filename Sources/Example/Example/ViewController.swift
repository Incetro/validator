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

final class ViewController: UIViewController {

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
        setupRegexCells()
        setupLengthCells()
        setupEqualityCells()
    }

    private func setupTitleLabel() {
        view.addSubview(titleLabel.prepareForAutolayout())
        titleLabel
            .top(to: view.top + Constants.titleLabelTopInset)
            .centerX(to: view.centerX)
    }

    private func setupCell<Rule>(
        title: String,
        placeholder: String,
        rule: Rule,
        cornerType: UIView.SmoothCornerType
    ) where Rule: ValidationRule, UITextField.Input == Rule.Input {
        let cell = TextFieldCell()
        cell.title = title
        cell.placeholder = placeholder
        cell.textField.add(rule: rule)
        cell.textField.validationHandler = {
            cell.visualizationValidate(isValid: $0.isValid)
        }
        stackView.addRow(cell)
        stackView.setInset(forRow: cell, inset: Constants.cellInsets)
        cell.updateConers(cornerType)
    }

    private func setupRegexCells() {
        addSection(sectionName: "Regex")
        setupCell(
            title: "Username:",
            placeholder: "Regex validation username",
            rule: RegexValidationRule(pattern: Regex.username),
            cornerType: .first
        )
        setupCell(
            title: "Email:",
            placeholder: "Regex validation email",
            rule: RegexValidationRule(pattern: Regex.email),
            cornerType: .last
        )
    }

    private func setupLengthCells() {
        addSection(sectionName: "Length")
        setupCell(
            title: "Min length:",
            placeholder: "Min length is 5",
            rule: LengthValidationRule(min: 5),
            cornerType: .first
        )
        setupCell(
            title: "Range length:",
            placeholder: "Min length is 5, max length is 10",
            rule: LengthValidationRule(min: 5, max: 10),
            cornerType: .last
        )
    }

    private func setupEqualityCells() {
        addSection(sectionName: "Equality")
        setupCell(
            title: "Condition:",
            placeholder: "If entered text is equal to: \"text\"",
            rule: ConditionValidationRule { $0 == "text" },
            cornerType: .first
        )
        setupCell(
            title: "Equality:",
            placeholder: "Equality validation to: \"apple\"",
            rule: EqualityValidationRule { "apple" },
            cornerType: .regular
        )
        setupPasswordCells()
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
