//
//  FiqueSettingsView.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 17/11/24.
//

import SwiftUI

struct FiqueSettingsView: View {
    
    let fiques = PTFique.allCases
    
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(fiques) { fique in
                    HStack {
                        Text(NSLocalizedString(fique.title, comment: ""))
                            .foregroundColor(.PTWhite)
                            .font(.PTCellDetailedText)
                            .frame(alignment: .leading)
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.PTAccentColor)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.PTAccentColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .accentColor(.PTAccentColor)
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle(NSLocalizedString("fique", comment: ""))
        }

    }
}

#Preview {
    FiqueSettingsView()
}
