//
//  ImageView.swift
//  Heardstone
//
//  Created by Gerson Arbigaus on 01/06/23.
//

import SwiftUI

struct ImageView: View {
    let imageUrl: String

    var body: some View {
        if let url = URL(string: imageUrl),
           let imageData = try? Data(contentsOf: url),
           let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            Text("Failed to load image")
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(imageUrl: "https://d15f34w2p8l1cc.cloudfront.net/hearthstone/9aba4e9bf49d789db2ddfe14423d9e99d1ca1ffd831c051d276b9ceefe18504c.png")
    }
}
