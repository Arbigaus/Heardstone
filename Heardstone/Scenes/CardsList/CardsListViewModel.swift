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
    @Published var title: String
    private var setName: String

    private let cardModel: CardModelProtocol

    init(cardModel: CardModelProtocol = CardModel(), setName: String) {
        self.cardModel = cardModel
        self.setName = setName
        self.title = setName
    }

    func fetchCardsList() async {
        await MainActor.run { [weak self] in
            self?.loading = true
        }
        do {
            let list = try await cardModel.fetchCardList(setName: setName)

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
