//
//  HeardstoneApp.swift
//  Heardstone
//
//  Created by Gerson Arbigaus on 29/05/23.
//

import SwiftUI

@main
struct HeardstoneApp: App {
    var body: some Scene {
        WindowGroup {
            CardsListView(viewModel: CardsListViewModel())
        }
    }
}
