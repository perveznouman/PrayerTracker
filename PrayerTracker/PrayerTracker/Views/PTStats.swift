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
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.accentGreenColor]
    }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color.viewBackgroundColor
                    .ignoresSafeArea()
                Text(LocalizedStringKey("statistics"))
                    .navigationTitle("statistics")
                    .foregroundColor(.accentGreenColor)
            }
            .navigationBarTitleDisplayMode(.large)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    PTStats()
}
