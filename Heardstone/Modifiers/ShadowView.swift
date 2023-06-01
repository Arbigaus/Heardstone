//
//  ShadowView.swift
//  Heardstone
//
//  Created by Gerson Arbigaus on 01/06/23.
//

import SwiftUI

public struct ShadowView: ViewModifier {
    @Environment(\.colorScheme) var colorScheme

    public let color: Color?

    public init(color: Color? = nil) {
        self.color = color
    }

    public func body(content: Content) -> some View {
        if colorScheme == .dark {
            content
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.gray, lineWidth: 1)
                )
        } else if let color = color {
            content
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(color, lineWidth: 2)
                )
        } else {
            content
                .background(.white)
                .cornerRadius(12)
                .shadow(color: .gray, radius: 3, x: 2, y: 2)
        }
    }
}
