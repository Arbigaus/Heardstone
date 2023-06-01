//
//  CardDetailViewModel.swift
//  Heardstone
//
//  Created by Gerson Arbigaus on 01/06/23.
//

import Foundation

final class CardDetailViewModel: ObservableObject {
    @Published var loading: Bool = false
    @Published var card: Card

    init(card: Card) {
        self.card = card
    }
}
