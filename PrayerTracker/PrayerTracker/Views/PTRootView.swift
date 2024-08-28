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
            PTMarkPrayerView().tabItem {
                Label(LocalizedStringKey("newEntry"), systemImage: "calendar.badge.plus")
            }
            PTStatsView().tabItem {
                Label(LocalizedStringKey("statistics"), systemImage: "chart.bar.xaxis.ascending.badge.clock")
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
