//
//  RootView.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 10/05/24.
//

import SwiftUI

struct PTRootView: View {
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = .gray
    }
    
    var body: some View {
        TabView {
            PTMarkPrayer().tabItem {
                Label(LocalizedStringKey("newEntry"), image: "add-entry")
            }
            PTStats().tabItem {
                Label(LocalizedStringKey("statistics"), image: "stats")
            }
        }
        .accentColor(.accentGreenColor)
    }
}

#Preview {
    PTRootView()
}
