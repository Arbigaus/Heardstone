//
//  View+Extensions.swift
//  Heardstone
//
//  Created by Gerson Arbigaus on 30/05/23.
//

import SwiftUI

public extension View {

    /**
     Show loading in the view

     - parameters:
     - condition: The boolean to confirm if has to show loading

     This function will show loading when the parameter is true
     */
    @ViewBuilder func isLoading(_ condition: Bool) -> some View {
        if condition {
            LoadingView()
        } else {
            self
        }
    }
}

