//
//  MarkPrayer.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 10/05/24.
//

import SwiftUI

struct PTMarkPrayer: View {
    let date = Date()
    let calendar = Calendar.current
    @State private var showDatePicker = false
    @State private var selectedDate = Date()
    @State private var offered = true
    @State private var prayers: [Prayer] = [Prayer(name: "fajr", isOffered: false),
                                            Prayer(name: "zuhar", isOffered: true),
                                            Prayer(name: "asar", isOffered: false),
                                            Prayer(name: "maghrib", isOffered: true),
                                            Prayer(name: "esha", isOffered: false)]
    
    init() {
//        UINavigationBar.appearance().backgroundColor = .systemPink
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.PTAccentColor]
    }
    var body: some View {
        NavigationView {
            ZStack {
                Color.PTViewBackgroundColor
                    .ignoresSafeArea()
                
                VStack(spacing:0) {
                    HStack {
                        DateSection(shouldShowDatePicker: $showDatePicker, buttonTitle: "<")
                        DateSection(shouldShowDatePicker: $showDatePicker, buttonTitle: Date.newEntryFormatter(date: selectedDate))
                        DateSection(shouldShowDatePicker: $showDatePicker, buttonTitle: ">")
                        Spacer()
                    }
                    
                    if showDatePicker {
                        
                        DatePicker(
                            "",
                            selection: $selectedDate,
                            in: ...Date(),
                            displayedComponents: .date
                        )
                        .preferredColorScheme(.dark)
//                        .tint(.red)
                        .colorMultiply(.PTWhite)
                        .labelsHidden()
                        .datePickerStyle(.graphical)
                        .frame(maxHeight: 400)
                    }
                    
                    List($prayers) { $prayer in
                        PrayerListCell(prayer: $prayer)
                    }
                    .scrollDisabled(true)
                    .contentMargins(.vertical, 10) //To remove spacing in header section
                    .frame(maxHeight: 225)
                    .preferredColorScheme(.dark)
                    .colorMultiply(Color.PTWhite)
                    
                    Spacer()
                    //                NavigationLink(LocalizedStringKey("makeNewEntry")) {
                    //                    TempView()
                    //
                    //                }
                }
            }
            .navigationTitle(LocalizedStringKey("newEntry"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.PTAccentColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .accentColor(.PTAccentColor)
        .edgesIgnoringSafeArea(.bottom)
    }
    
}

struct DateSection: View {
    
    @Binding var shouldShowDatePicker: Bool
    var buttonTitle: String

    var body: some View {
        Spacer()
        Button(action: {
            shouldShowDatePicker.toggle()
        }, label: {
            Text(buttonTitle)
        })
        .font(.PTButtonTitle)
        .padding(.top, 10)
    }
}

struct PrayerListCell: View {
    @Binding var prayer: Prayer
    var body: some View {
        HStack {
            Text(NSLocalizedString(prayer.name, comment: ""))
                .foregroundColor(.PTWhite)
                .font(.PTPrayerCell)
            Toggle("", isOn: $prayer.isOffered)
                .tint(.PTAccentColor)

        }
        .listRowBackground(Color.PTViewBackgroundColor)
    }
}

#Preview {
//    DateSection(shouldShowDatePicker: true, buttonTitle: "<")
//    PrayerListCell()
    PTMarkPrayer()
}
