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

    var body: some View {
        NavigationView {
            ZStack {
//                Rectangle()
//                    .fill(Gradient(colors: [.almond, .gray]))
//                    .ignoresSafeArea()
                Color.viewBackgroundColor
                    .ignoresSafeArea()
                
                VStack {
                    
                    Button(action: {
                        showDatePicker.toggle()
                    }, label: {
                        Text(Date.newEntryFormatter(date: selectedDate))
                    })
                    .font(.custom("Mukta-Bold", size: 20))
                    .padding()
                    Spacer()
                    
                    if showDatePicker {
                        
                        DatePicker(
                            "",
                            selection: $selectedDate,
                            displayedComponents: .date
                        )
                        .labelsHidden()
                        .datePickerStyle(.graphical)
                        .frame(maxHeight: 400)
                    }
                    
                    //                NavigationLink(LocalizedStringKey("makeNewEntry")) {
                    //                    TempView()
                    //
                    //                }
                    
                }
            }
            .navigationTitle(LocalizedStringKey("newEntry"))
            .navigationBarTitleDisplayMode(.large)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    PTMarkPrayer()
}
