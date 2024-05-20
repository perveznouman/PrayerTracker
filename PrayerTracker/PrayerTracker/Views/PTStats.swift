//
//  Stats.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 10/05/24.
//

import SwiftUI

struct PTStats: View {
    var body: some View {
        
        NavigationView {
            Text(LocalizedStringKey("statistics"))
                .navigationTitle("statistics")
        }
        
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    PTStats()
}
