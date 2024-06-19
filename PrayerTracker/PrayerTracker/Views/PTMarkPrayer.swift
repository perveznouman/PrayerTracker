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
                    
                    Button(action: {
                        showDatePicker.toggle()
                    }, label: {
                        Text(Date.newEntryFormatter(date: selectedDate))
                    })
                    .font(.PTButtonTitle)
                    .padding(.top, 10)
                    
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
                    .contentMargins(.vertical, 0) //To remove spacing in header section
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
        .edgesIgnoringSafeArea(.bottom)
    }
    
}

struct PrayerListCell: View {
    
    var body: some View {
        HStack {
            Text("Isha")
                .foregroundColor(.PTWhite)
                .font(.PTPrayerCell)
            Toggle("", isOn: .constant(true))
        }
        .listRowBackground(Color.PTViewBackgroundColor)
    }
}

#Preview {
//    PrayerListCell()
    PTMarkPrayer()
}
