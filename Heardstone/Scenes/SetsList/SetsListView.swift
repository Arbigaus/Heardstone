//
//  SetsListView.swift
//  Heardstone
//
//  Created by Gerson Arbigaus on 31/05/23.
//

import SwiftUI

struct SetsListView: View {
    @StateObject private var viewModel: SetsListViewModel
    @State private var viewDidAppear = false

    init(viewModel: SetsListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
        VStack {
            Text("Sets of cards")
                .font(.system(size: 24))
                List(viewModel.setsList, id: \.self) { item in
                    NavigationLink {
                        CardsListView(viewModel: CardsListViewModel(setName: item))
                    } label: {
                        Text(item)
                            .foregroundColor(.black)
                    }
                    .listRowSeparator(.hidden)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding()
                    .modifier(ShadowView())
                }
                .listStyle(PlainListStyle())
                .listRowBackground(Color.clear)
                .isLoading(viewModel.loading)
                .task {
                    if !viewDidAppear {
                        await viewModel.fetchSetsList()
                        viewDidAppear = true
                    }
                }
            }
        }

    }
}

struct SetsListView_Previews: PreviewProvider {
    static var previews: some View {
        SetsListView(viewModel: SetsListViewModel())
    }
}
