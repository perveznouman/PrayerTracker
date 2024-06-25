//
//  Stats.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 10/05/24.
//

import SwiftUI


//enum Stats: String, CaseIterable, Identifiable {
//    var id: String {
//        UUID().uuidString
//    }
//    case weekly
//    case monthly
//    case yearly
//}

enum PTStats: String, CaseIterable, Equatable {
    
    case weekly = "weekly"
    case monthly = "monthly"
    case yearly = "yearly"
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}


struct PTStatsView: View {
    
    init() {
        
//        UINavigationBar.appearance().backgroundColor = .systemPink
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.PTAccentColor]
//        UISegmentedControl.appearance().backgroundColor = .white
        UISegmentedControl.appearance().selectedSegmentTintColor = .PTAccentColor
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.PTWhite], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.PTAccentColor], for: .normal)
//        UISegmentedControl.appearance().setTitleTextAttributes([.font: UIFont.boldFont(ofSize: 19)], for: .normal)
    }
    
    @State private var selectedParameter: PTStats = .weekly
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color.PTViewBackgroundColor
                    .ignoresSafeArea()
                
                VStack {
                    PickerView(selectedSegment: $selectedParameter)
                    Spacer()
                }
                Text(LocalizedStringKey(selectedParameter.rawValue))
                    .foregroundColor(.white)

                //                NavigationLink(LocalizedStringKey("makeNewEntry")) {
                //                    TempView()
                //
                //                }
            }
            .navigationTitle(LocalizedStringKey("statistics"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.PTAccentColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .accentColor(.PTAccentColor)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct PickerView: View {
    
    @Binding var selectedSegment: PTStats
    var body: some View {
        Picker("", selection: $selectedSegment) {
            ForEach(PTStats.allCases, id: \.self) { stats in
                Text(LocalizedStringKey(stats.rawValue))
                    .font(.PTButtonTitle)
            }
        }
        .tint(.PTAccentColor)
        .pickerStyle(.segmented)
        .padding(.top, 20)
        .padding(.leading, 15)
        .padding(.trailing, 15)
    }
}

#Preview {
//    PickerView(selectedSegment: .constant(.weekly))
    PTStatsView()
}