//
//  CardDetailView.swift
//  Heardstone
//
//  Created by Gerson Arbigaus on 01/06/23.
//

import SwiftUI

struct CardDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel: CardDetailViewModel

    init(viewModel: CardDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 16) {
                ImageView(imageUrl: viewModel.card.img ?? "")
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                VStack {
                    Text(viewModel.card.name ?? "")
                        .font(.system(size: 20, weight: .bold))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 4, trailing: 0))
                    Text(viewModel.card.text ?? "")
                        .font(.system(size: 16, weight: .regular))
                        .padding(EdgeInsets(top: 0, leading: 24, bottom: 4, trailing: 24))
                }

                HStack(alignment: .top) {
                    InfosView(title: "Health", value: "\(viewModel.card.health ?? 0)")
                    InfosView(title: "Attack", value: "\(viewModel.card.attack ?? 0)")
                    InfosView(title: "Cost", value: "\(viewModel.card.cost ?? 0)")
                }

                HStack(alignment: .top) {
                    InfosView(title: "Type", value: viewModel.card.type ?? "")
                    InfosView(title: "Rarity", value: viewModel.card.rarity ?? "")
                    InfosView(title: "Faction", value: viewModel.card.faction ?? "Unknow")
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(viewModel.card.playerClass ?? ""))
    }

    struct InfosView: View {
        let title: String
        let value: String

        var body:  some View {
            ZStack {
                VStack {
                    Text(title)
                        .font(.system(size: 16, weight: .bold))
                    Divider()
                    Text(value)
                        .minimumScaleFactor(0.01)
                }
                .frame(width: 60, height: 60)
                .padding()
                .modifier(ShadowView())
            }
        }
    }

}

struct CardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let card = Card(
            cardId: "1234",
            dbfId: 5678,
            name: "Example Card",
            cardSet: "Set Name",
            type: "Minion",
            rarity: "Rare",
            cost: 4,
            attack: 3,
            health: 5,
            text: "Reveal a minion from your deck. Give it +2/+2 and put it on top.",
            flavor: "Flavor text goes here",
            artist: "Artist Name",
            collectible: true,
            elite: false,
            playerClass: "Mage",
            howToGetSignature: "How to obtain the card signature",
            img:"https://d15f34w2p8l1cc.cloudfront.net/hearthstone/9aba4e9bf49d789db2ddfe14423d9e99d1ca1ffd831c051d276b9ceefe18504c.png",
            locale: "en_US",
            faction: "Some Faction",
            mechanics: [Mechanic(name: "Mechanic 1"), Mechanic(name: "Mechanic 2")]
        )

        CardDetailView(viewModel: CardDetailViewModel(card: card))
    }
}
