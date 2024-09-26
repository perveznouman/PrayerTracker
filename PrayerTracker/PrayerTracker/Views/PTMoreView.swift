//
//  PTMoreView.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 27/09/24.
//

import SwiftUI

struct PTMoreView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Text("Hello, World!")
            }
            .navigationTitle(LocalizedStringKey("more"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.PTAccentColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .accentColor(.PTAccentColor)
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    PTMoreView()
}
