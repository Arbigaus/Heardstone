//
//  LoadingView.swift
//  Heardstone
//
//  Created by Gerson Arbigaus on 30/05/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            ProgressView() {
                Text("Loading")
                    .font(.system(.title3, design: .rounded))
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)

    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
