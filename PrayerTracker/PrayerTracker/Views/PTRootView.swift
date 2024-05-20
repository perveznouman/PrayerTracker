//
//  RootView.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 10/05/24.
//

import SwiftUI

struct PTRootView: View {
    var body: some View {
        TabView {
            PTStats().tabItem {
                Label(LocalizedStringKey("statistics"), image: "stats")
            }
            PTMarkPrayer().tabItem {
                Label(LocalizedStringKey("newEntry"), image: "add-entry")

            }
        }
    }
}

#Preview {
    PTRootView()
}
