//
//  CardsListViewModel.swift
//  Heardstone
//
//  Created by Gerson Arbigaus on 29/05/23.
//

import Foundation

final class CardsListViewModel: ObservableObject {
    @Published var loading: Bool = false
    @Published private var cardsList: [Card] = []

    private let cardModel: CardModelProtocol

    init(cardModel: CardModelProtocol = CardModel()) {
        self.cardModel = cardModel
    }

    func fetchCardsList() async {
        loading = true

        guard let list = try? await cardModel.fetchCardList() else {
            loading = false
            return
        }

        cardsList = list
        loading = false
    }

}
