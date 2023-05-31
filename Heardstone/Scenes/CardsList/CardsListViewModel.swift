//
//  CardsListViewModel.swift
//  Heardstone
//
//  Created by Gerson Arbigaus on 29/05/23.
//

import Foundation

final class CardsListViewModel: ObservableObject {
    @Published var loading: Bool = false
    @Published var cardsList: [Card] = []

    private let cardModel: CardModelProtocol

    init(cardModel: CardModelProtocol = CardModel()) {
        self.cardModel = cardModel
    }

    func fetchCardsList() async {
        await MainActor.run { [weak self] in
            self?.loading = true
        }
        do {
            let list = try await cardModel.fetchCardList()

            await MainActor.run { [weak self] in
                self?.cardsList = list
                self?.loading = false
            }
        }
        catch(let error) {
            print(error)
        }
    }

}
