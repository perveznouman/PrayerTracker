//
//  FiqueSettingsView.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 17/11/24.
//

import SwiftUI

struct FiqueSettingsView: View {
    
    @State var fiques = PTFique.allCases
    @State var selectedFique: PTFique?
    @State var existingFique: PTFique?
    
    @State var schools = PTSchool.allCases
    @State var selectedSchool: PTSchool?
    @State var existingSchool: PTSchool?
    
    var body: some View {
        
        NavigationStack {
            List {
                
                Section(header: Text(NSLocalizedString("school", comment: ""))) {
                    ForEach($schools) { school in
                        PTSchoolSettingsRow(school: school, selectedItem: $selectedSchool)
                    }
                }
                
                Section(header: Text(NSLocalizedString("fique", comment: ""))) {
                    ForEach($fiques) { fique in
                        PTFiqueSettingsRow(fique: fique, selectedItem: $selectedFique)
                    }
                }
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.PTAccentColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .accentColor(.PTAccentColor)
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle(NSLocalizedString("fiqueSettings", comment: ""))
        }.onAppear {
            loadData()
        }.onDisappear {
            saveData()
        }
    }
    
    private func loadData() {
        selectedFique = fiques[UserDefaults.standard.retrieve(object: Int.self, fromKey: PTConstantKey.selectedFique) ?? 3]
        selectedSchool = schools[UserDefaults.standard.retrieve(object: Int.self, fromKey: PTConstantKey.selectedSchool) ?? 1]
        existingFique = selectedFique
        existingSchool = selectedSchool
    }
    
    private func saveData() {
        if(existingFique != selectedFique) {
            UserDefaults.standard.save(customObject: selectedFique?.rawValue, inKey: PTConstantKey.selectedFique)
            PTLocationManager().callPrayerTimingAPI()
            PTAnalyticsManager.logEvent(eventName:PTAnalyticsConstant.fiqueSetting.caseValue, parameter: [PTAnalyticsConstant.fiqueSetting.caseValue: selectedFique?.id ?? 3])
        }
        if(existingSchool != selectedSchool) {
            UserDefaults.standard.save(customObject: selectedSchool?.rawValue, inKey: PTConstantKey.selectedSchool)
            PTLocationManager().callPrayerTimingAPI()
            PTAnalyticsManager.logEvent(eventName:PTAnalyticsConstant.schoolSetting.caseValue, parameter: [PTAnalyticsConstant.schoolSetting.caseValue: selectedSchool?.id ?? 1])
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
