//
//  FiqueSettingsView.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 17/11/24.
//

import SwiftUI

struct FiqueSettingsView: View {
    
    @State var fiques = PTFique.allCases
    @State var selectedItem: PTFique?
    @State var existingItem: PTFique?
    
    var body: some View {
        
        NavigationStack {
                List(selection: $selectedItem) {
                    ForEach($fiques) { fique in
                        PTFiqueSettingsRow(fique: fique, selectedItem: $selectedItem)
                    }
                }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.PTAccentColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .accentColor(.PTAccentColor)
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle(NSLocalizedString("fique", comment: ""))
        }.onAppear {
            selectedItem = fiques[UserDefaults.standard.retrieve(object: Int.self, fromKey: PTConstantKey.selectedFique) ?? 3]
            existingItem = fiques[UserDefaults.standard.retrieve(object: Int.self, fromKey: PTConstantKey.selectedFique) ?? 3]
        }.onDisappear {
            if(existingItem != selectedItem) {
                UserDefaults.standard.save(customObject: selectedItem?.rawValue, inKey: PTConstantKey.selectedFique)
                PTLocationManager().callPrayerTimingAPI()
                PTAnalyticsManager.logEvent(eventName:PTAnalyticsConstant.fiqueSetting.caseValue, parameter: [PTAnalyticsConstant.fiqueSetting.caseValue: selectedItem?.id ?? 3])
            }
        }
    }
}

struct PTFiqueSettingsRow: View {
    
    @Binding var fique: PTFique
    @Binding var selectedItem: PTFique?

    var body: some View {
        HStack {
            Text(NSLocalizedString(fique.title, comment: ""))
                .foregroundColor(.PTWhite)
                .font(.PTCellDetailedText)
                .frame(alignment: .leading)
            Spacer()
            if (fique == selectedItem) {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.PTAccentColor)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            selectedItem = fique
        }
    }
}

#Preview {
    FiqueSettingsView()
}
