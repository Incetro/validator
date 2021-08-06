//
//  TextFieldCell.swift
//  Example
//
//  Created by Alexander Lezya on 11.07.2021.
//

import Layout
import UIKit

// MARK: - TextFieldCell

final class TextFieldCell: UIView {

    // MARK: - Properties

    /// Current corners type
    private(set) var cornersType: SmoothCornerType = .full

    /// Title
    var title: String {
        get {
            titleLabel.text ?? ""
        }
        set {
            titleLabel.text = newValue
        }
    }

    /// Text field
    let textField: UITextField = {
        let textField = UITextField()
        textField.validateOnInputChange(enabled: true)
        textField.autocapitalizationType = .none
        return textField
    }()

    /// PLaceholder
    var placeholder: String {
        get {
            textField.placeholder ?? ""
        }
        set {
            textField.placeholder = newValue
        }
    }

    /// Title label
    private let titleLabel = UILabel()

    /// Content view container
    private let container = UIView()

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor(hexString: "#F2F2F7")
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Update current view corners
    /// - Parameter cornerRadiusType: corner radius type
    func updateConers(_ cornerRadiusType: SmoothCornerType) {
        self.cornersType = cornerRadiusType
    }

    // MARK: - RoundedView

    override func layoutSubviews() {
        super.layoutSubviews()
        smoothlyRoundCourners(cornersType, radius: Constants.cornerRadius)
    }

    // MARK: - Private

    private func setup() {
        let insets = Constants.contentInsets

        addSubview(titleLabel.prepareForAutolayout())
        titleLabel
            .left(to: left + insets.left)
            .top(to: top + insets.top)
            .bottom(to: bottom - insets.bottom)

        addSubview(container.prepareForAutolayout())
        container
            .top(to: top + insets.top)
            .bottom(to: bottom - insets.bottom)
            .left(to: titleLabel.right + insets.right)
            .right(to: right - insets.left)

        container.addSubview(textField.prepareForAutolayout())
        textField.pinToSuperview()
    }

    func visualizationValidate(isValid: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.textField.rightViewMode = self.textField.text?.isEmpty == true ? .never : .always
            if isValid {
                self.textField.rightView = UIImageView(image: UIImage(named: "green-circle"))
            } else {
                self.textField.rightView = UIImageView(image: UIImage(named: "red-circle")).size(16)
            }
        }
    }
}

// MARK: - Constants

extension TextFieldCell {

    enum Constants {
        static let cornerRadius: CGFloat = 13
        static let contentInsets = UIEdgeInsets.init(top: 14, left: 14, bottom: 14, right: 14)
    }
}
