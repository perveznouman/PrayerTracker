//
//  MarkPrayer.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 10/05/24.
//

import SwiftUI
import Charts

struct PTMarkPrayerView: View {
    let date = Date()
    let calendar = Calendar.current
    @State private var showDatePicker = false
    @State private var selectedDate = Date()
    @State private var offered = true
    @StateObject private var prayerVM: PrayerViewModel = PrayerViewModel()

    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.PTAccentColor]
    }
    var body: some View {
        NavigationView {
            ZStack {
                Color.PTViewBackgroundColor
                    .ignoresSafeArea()
                
                VStack(spacing:0) {
                    HStack {
                        PTDateSectionView(shouldShowDatePicker: $showDatePicker, buttonTitle: "<")
                        PTDateSectionView(shouldShowDatePicker: $showDatePicker, buttonTitle: Date.newEntryFormatter(date: selectedDate))
                        PTDateSectionView(shouldShowDatePicker: $showDatePicker, buttonTitle: ">")
                        Spacer()
                    }
                    
                    List($prayerVM.prayers) { $prayer in
                        PTPrayerListCellView(prayer: $prayer)
                    }
                    .scrollDisabled(true)
                    .contentMargins(.vertical, 10) //To remove spacing in header section
                    .frame(maxHeight: 225)
                    .preferredColorScheme(.dark)
                    .colorMultiply(Color.PTWhite)
                    
                    Spacer()
                    PTTodaysPrayerPieChartView(aggregatedPrayers: prayerVM.aggregatedData)
                    Spacer()
                }
                
                if showDatePicker {
                    PTDatePickerView(currentSelectedDate: $selectedDate, shouldShowPicker: $showDatePicker)
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

struct PTDatePickerView: View {
    
    @Binding var currentSelectedDate: Date
    @Binding var shouldShowPicker: Bool
    
    var body: some View {
        ZStack {
            Color.PTViewBackgroundColor.opacity(0.8)
                .ignoresSafeArea()
                .onTapGesture {
                    shouldShowPicker.toggle()
                }
            VStack {
                Spacer()
                DatePicker(
                    "",
                    selection: $currentSelectedDate,
                    in: ...Date(),
                    displayedComponents: .date
                )
                .onChange(of: currentSelectedDate) { oldValue, newValue in
                    print(oldValue)
                    print(newValue)
                    shouldShowPicker.toggle()
                }
                .preferredColorScheme(.dark)
                // .tint(.red)
                .colorMultiply(.PTWhite)
                .labelsHidden()
                .datePickerStyle(.graphical)
                .frame(maxHeight: 400)
            }
        }
    }
}

struct PTTodaysPrayerPieChartView: View {
    
    var aggregatedPrayers: [TodaysPrayerAggregatedData]
    let colorMapping: [String: Color] = [ "Offered": .PTAccentColor,
                                          "Not Offered": .PTRed,
                                          "Wait": .PTGray]
    
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

struct PTDateSectionView: View {
    
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

struct PTPrayerListCellView: View {
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
//    PTDatePickerView(currentSelectedDate: .constant(Date()), shouldShowPicker: .constant(true))
//    PTTodaysPrayerPieChartView()
//    PTDateSectionView(shouldShowDatePicker: true, buttonTitle: "<")
//    PTPrayerListCellView()
    PTMarkPrayerView()
//        .environment(\.locale, .init(identifier: "ur"))
}
