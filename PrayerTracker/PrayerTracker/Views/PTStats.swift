//
//  Stats.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 10/05/24.
//

import SwiftUI

struct PTStats: View {
    
    init() {
        
//        UINavigationBar.appearance().backgroundColor = .systemPink
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.PTAccentColor]
    }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color.PTViewBackgroundColor
                    .ignoresSafeArea()
                Text(LocalizedStringKey("statistics"))
                    .navigationTitle("statistics")
                    .foregroundColor(.PTAccentColor)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.PTAccentColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    PTStats()
}
