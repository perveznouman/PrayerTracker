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

    init() {
//        UINavigationBar.appearance().backgroundColor = .systemPink
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.PTAccentColor]
    }
    var body: some View {
        NavigationView {
            ZStack {
//                Rectangle()
//                    .fill(Gradient(colors: [.almond, .gray]))
//                    .ignoresSafeArea()
                Color.PTViewBackgroundColor
                    .ignoresSafeArea()
                
                VStack(spacing:0) {
                    HStack {
                        DateSection(shouldShowDatePicker: $showDatePicker, buttonTitle: "<")
                        DateSection(shouldShowDatePicker: $showDatePicker, buttonTitle: Date.newEntryFormatter(date: selectedDate))
                        DateSection(shouldShowDatePicker: $showDatePicker, buttonTitle: ">")

//                        Spacer()
//                        Button(action: {
//                            showDatePicker.toggle()
//                        }, label: {
//                            Text("<")
//                        })
//                        .font(.PTButtonTitle)
//                        .padding(.top, 10)
//                        
//                        Spacer()
//                        Button(action: {
//                            showDatePicker.toggle()
//                        }, label: {
//                            Text(Date.newEntryFormatter(date: selectedDate))
//                        })
//                        .font(.PTButtonTitle)
//                        .padding(.top, 10)
//                        
//                        Spacer()
//                        Button(action: {
//                            showDatePicker.toggle()
//                        }, label: {
//                            Text(">")
//                        })
//                        .font(.PTButtonTitle)
//                        .padding(.top, 10)
                        
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
                    
                    List {
                        PrayerListCell()
                        PrayerListCell()
                        PrayerListCell()
                        PrayerListCell()
                        PrayerListCell()
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
    
    var body: some View {
        HStack {
            Text("Isha")
                .foregroundColor(.PTWhite)
                .font(.PTPrayerCell)
            Toggle("", isOn: .constant(true))
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
