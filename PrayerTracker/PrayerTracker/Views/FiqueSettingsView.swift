//
//  FiqueSettingsView.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 17/11/24.
//

import SwiftUI

struct FiqueSettingsView: View {
    
    @StateObject var fiqueVM: PTFiqueSettingsViewModel = .init()
    
    var body: some View {
        
        NavigationStack {
            List {
                
                Section(header: Text(NSLocalizedString("school", comment: ""))) {
                    ForEach($fiqueVM.schools) { school in
                        PTSchoolSettingsRow(school: school, selectedItem: $fiqueVM.selectedSchool)
                    }
                }
                
                Section(header: Text(NSLocalizedString("fique", comment: ""))) {
                    ForEach($fiqueVM.fiques) { fique in
                        PTFiqueSettingsRow(fique: fique, selectedItem: $fiqueVM.selectedFique)
                    }
                }
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.PTAccentColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .accentColor(.PTAccentColor)
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle(NSLocalizedString("fiqueSettings", comment: ""))
        }.onDisappear {
            fiqueVM.saveUserPreference()
        }
    }
}

struct PTSchoolSettingsRow: View {
    
    @Binding var school: PTSchool
    @Binding var selectedItem: PTSchool?

    var body: some View {
        HStack {
            Text(NSLocalizedString(school.title, comment: ""))
                .foregroundColor(.PTWhite)
                .font(.PTCellDetailedText)
                .frame(alignment: .leading)
            Spacer()
            if (school == selectedItem) {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.PTAccentColor)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            selectedItem = school
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
