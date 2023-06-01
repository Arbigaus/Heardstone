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
            List(viewModel.cardsList) { card in
                NavigationLink {
                    CardDetailView(viewModel: CardDetailViewModel(card: card))
                } label: {
                    ItemView(card: card)
                        .modifier(ShadowView())
                        .listRowSeparator(.hidden)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 6, trailing: 0))
                }
                .buttonStyle(PlainButtonStyle())
            }
            .listRowSeparator(.hidden)
            .listStyle(PlainListStyle())
            .listRowBackground(Color.clear)
            .isLoading(viewModel.loading)
            .task {
                await viewModel.fetchCardsList()
            }
        }
        .safeAreaInset(edge: .top) {
            Color.clear
                .frame(height: 0)
                .background(.bar)
                .border(.black)
        }
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    struct ItemView: View {
        let card: Card

        var body: some View {
            VStack(alignment: .leading) {
                Text(card.name ?? "Unknow name")
                    .fontWeight(.heavy)
                    .font(.system(size: 16))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 4, trailing: 0))
                Text("Class: \(card.playerClass ?? "")")
                    .disabled(card.playerClass == nil)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding()
            .background(Color(card.playerClass ?? "Priest"))
        }
    }
}

struct CardsListView_Previews: PreviewProvider {
    static var previews: some View {
        CardsListView(viewModel: CardsListViewModel(setName: ""))
    }
}
