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
//            TempView().tabItem {
//                Label("More", systemImage: "ellipsis")
//            }
        }
//        .font(Font.custom("Mukta-ExtraBold", size:18))
        .accentColor(.PTAccentColor)
    }
}

#Preview {
    PTRootView()
//        .environment(\.locale, .init(identifier: "ur"))
}
