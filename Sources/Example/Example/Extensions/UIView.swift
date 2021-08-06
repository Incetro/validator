//
//  UIView.swift
//  Example
//
//  Created by Alexander Lezya on 11.07.2021.
//

import UIKit

// MARK: - UIView

public extension UIView {

    enum SmoothCornerType {

        case first
        case last
        case left
        case right

        case topLeft
        case topRight
        case bottomLeft
        case bottomRight

        case full
        case regular

        /// UIKit corners
        public var corners: CACornerMask {
            switch self {
            case .topLeft:
                return .layerMinXMinYCorner
            case .topRight:
                return .layerMaxXMinYCorner
            case .bottomLeft:
                return .layerMinXMaxYCorner
            case .bottomRight:
                return .layerMaxXMaxYCorner
            case .full:
                return [
                    .layerMinXMinYCorner,
                    .layerMaxXMinYCorner,
                    .layerMinXMaxYCorner,
                    .layerMaxXMaxYCorner
                ]
            case .first:
                return [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            case .last:
                return [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            case .left:
                return [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            case .right:
                return [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            default:
                return []
            }
        }
    }

    func smoothlyRoundCourners(_ corners: SmoothCornerType = .full, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = corners.corners
        layer.masksToBounds = true
    }

    func subview(withId accessibilityIdentifier: String) -> UIView? {
        subviews.first { $0.accessibilityIdentifier == accessibilityIdentifier }
    }
}
