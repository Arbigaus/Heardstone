//
//  TextView.swift
//  Heardstone
//
//  Created by Gerson Arbigaus on 01/06/23.
//

import SwiftUI

struct LabelView: UIViewRepresentable {
    var attributedString: NSMutableAttributedString

    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0 // Enables multiple lines
        return label
    }

    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.attributedText = attributedString
        uiView.backgroundColor = .clear
        uiView.textAlignment = .center
        uiView.numberOfLines = 0
    }
}
