//
//  MarkPrayer.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 10/05/24.
//

import SwiftUI
import Charts

struct PTMarkPrayer: View {
    let date = Date()
    let calendar = Calendar.current
    @State private var showDatePicker = false
    @State private var selectedDate = Date()
    @State private var offered = true
    @StateObject private var prayerVM: PrayerViewModel = PrayerViewModel()

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
                    
                    List($prayerVM.prayers) { $prayer in
                        PrayerListCell(prayer: $prayer)
                    }
                    .scrollDisabled(true)
                    .contentMargins(.vertical, 10) //To remove spacing in header section
                    .frame(maxHeight: 225)
                    .preferredColorScheme(.dark)
                    .colorMultiply(Color.PTWhite)
                    
                    Spacer()
                    TodaysPrayerPieChartView(aggregatedPrayers: prayerVM.aggregatedData)
                    Spacer()
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

struct TodaysPrayerPieChartView: View {
    var aggregatedPrayers: [TodaysPrayerAggregatedData]
    let colorMapping: [String: Color] = [
        "Offered": .PTAccentColor,
        "Not Offered": .PTRed,
        "Wait": .PTGray
    ]
    var body: some View {
        
        Chart {
            ForEach(aggregatedPrayers) { prayer in
                SectorMark(angle: .value("Count", prayer.count))
                    .foregroundStyle(colorMapping[prayer.category] ?? .PTGray)
            }
        }
//        .frame(height: 300)
        .padding(.horizontal, 15)
        .padding(.top, 10)
        .scaledToFit()
        
        // Legend
        HStack {
            ForEach(aggregatedPrayers) { prayer in
                HStack {
                    Rectangle()
                        .fill(colorMapping[prayer.category] ?? .PTGray)
                        .frame(width: 10, height: 10)
                    Text(LocalizedStringKey(prayer.category))
                        .foregroundColor(colorMapping[prayer.category] ?? .PTGray)
                        .font(.PTGraphLegand)
                }
                .padding(.horizontal, 4)
            }
        }
        .padding(.top, 16)
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
            Text(LocalizedStringKey(prayer.name))
                .foregroundColor(.PTWhite)
                .font(.PTPrayerCell)
            Toggle("", isOn: $prayer.isOffered)
                .disabled(!prayer.isEnabled)
                .tint(.PTAccentColor)

        }
        .listRowBackground(Color.PTViewBackgroundColor)
    }
}

#Preview {
//    TodaysPrayerPieChartView()
//    DateSection(shouldShowDatePicker: true, buttonTitle: "<")
//    PrayerListCell()
    PTMarkPrayer()
        .environment(\.locale, .init(identifier: "ur"))
}
