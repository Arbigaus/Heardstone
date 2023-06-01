//
//  SetsListViewModel.swift
//  Heardstone
//
//  Created by Gerson Arbigaus on 31/05/23.
//

import Foundation

final class SetsListViewModel: ObservableObject {
    @Published var loading: Bool = false
    @Published var setsList: [String] = []

    private let setModel = SetModel()

    func fetchSetsList() async {
        await MainActor.run { [weak self] in
            self?.loading = true
        }
        do {
            let list = try await setModel.fetchSetList()

            await MainActor.run { [weak self] in
                self?.setsList = list
                self?.loading = false
            }
        }
        catch(let error) {
            print(error)
        }
    }
}
