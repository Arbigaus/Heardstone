//
//  CardsListView.swift
//  Heardstone
//
//  Created by Gerson Arbigaus on 29/05/23.
//

import SwiftUI

struct CardsListView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel: CardsListViewModel

    init(viewModel: CardsListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            Text(viewModel.title)
                .font(.system(size: 24))
            List(viewModel.cardsList) { card in
                Text(card.name ?? "No name")
            }
            .isLoading(viewModel.loading)
            .task {
                await viewModel.fetchCardsList()
            }
        }
    }
}

struct CardsListView_Previews: PreviewProvider {
    static var previews: some View {
        CardsListView(viewModel: CardsListViewModel(setName: ""))
    }
}
