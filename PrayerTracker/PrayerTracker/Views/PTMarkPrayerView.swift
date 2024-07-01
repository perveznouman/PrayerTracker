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
    @State private var showLocationSearchView = false
    @State private var selectedDate = Date()
    @State private var offered = true
    @StateObject private var prayerVM: PTTodaysPrayerViewModel = PTTodaysPrayerViewModel()
    @StateObject var locationManager = PTLocationManager()
    let locationSearchService = PTLocationSearchManager()

    var userCity: String {
        return locationManager.cityName ?? String(localized: "unknown")
    }

    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.PTAccentColor]
    }
    var body: some View {
        NavigationStack {
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button (action: {
                        showLocationSearchView.toggle()
                    }) {
                        HStack(spacing:0) {
                            Image(systemName: "location.fill")
                                .font(.system(size: 13))
                            Text(userCity)
                                .font(.PTLocationButton)
                        }
                        .frame(maxWidth:150)
                    }
                    .sheet(isPresented: $showLocationSearchView) {
                        PTLocationSearchView(locationSearchService: locationSearchService, selectedData: "", showLocationSearchView: showLocationSearchView)
                        
                    }
                    .foregroundColor(.PTWhite)
                    .controlSize(.small)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.PTAccentColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .accentColor(.PTAccentColor)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct PTLocationSearchView: View {
    
    @ObservedObject var locationSearchService: PTLocationSearchManager
    @State var selectedData: String
    @State var showLocationSearchView: Bool
    
    var body: some View {
        
        ZStack {
            Color.PTViewBackgroundColor.opacity(0.8)
                .ignoresSafeArea()
            VStack(spacing:0) {
                SearchBar(text: $locationSearchService.searchQuery)
                List(locationSearchService.completions) { completion in
                    PTSearchResultCellView(cellText: completion.title.description, subtitle: completion.subtitle.description)
                        .frame(maxHeight:40)
//                    VStack(alignment: .leading, spacing: 0) {
//                        Text(completion.title)
//                        Text(completion.subtitle)
//                            .font(.subheadline)
//                            .foregroundColor(.gray)
//                    }
                }
                
                //                .onTapGesture {
                //                    selectedData = locationSearchService.completions[0].title
                //                    print("Selected data: \($selectedData)")
                //                }
                //                .onAppear(perform: {
                //                    selectedData = locationSearchService.completions[0].title
                //                })
                .scrollDisabled(false)
                .contentMargins(.vertical, 0) //To remove spacing in header section
                .frame(maxHeight: .infinity)
                .preferredColorScheme(.dark)
                .colorMultiply(Color.PTWhite)
                
            }
        }
//        .onAppear(perform: {
//            showLocationSearchView.toggle()
//        })
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
    
    var aggregatedPrayers: [PTTodaysPrayerAggregatedData]
    let colorMapping: [String: Color] = [ "Offered": .PTAccentColor,
                                          "Not Offered": .PTRed,
                                          "Wait": .PTGray]
    
    var body: some View {
        
        Chart {
            ForEach(aggregatedPrayers) { prayer in
                
                SectorMark(angle: .value("Count", prayer.count), innerRadius: .ratio(0.6), angularInset: 1.0)
                    .foregroundStyle(colorMapping[prayer.category] ?? .PTGray)
                    .cornerRadius(6.0)
                    .annotation(position: .overlay) {
                        if(prayer.count > 0) {
                            Text("\(prayer.count)")
                                .font(.PTPrayerCell)
                                .foregroundStyle(.white)
                    }
                }
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
    @Binding var prayer: PTTodaysPrayer
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

struct PTSearchResultCellView : View {
     var cellText: String
     var subtitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(cellText)
                .foregroundColor(.PTWhite)
                .font(.PTLocationButton)
            Text(subtitle)
                .font(.PTCellDetailedText)
                .foregroundColor(.PTGray)
        }
    }
}
#Preview {
//    PTSearchResultCellView(cellText: .constant("Vaniymabadi"), subtitle: .constant("Tamil Nadu"))
//    PTLocationSearchView(locationSearchService: PTLocationSearchManager(), selectedData: "")
//    PTDatePickerView(currentSelectedDate: .constant(Date()), shouldShowPicker: .constant(true))
//    PTTodaysPrayerPieChartView()
//    PTDateSectionView(shouldShowDatePicker: true, buttonTitle: "<")
//    PTPrayerListCellView()
    PTMarkPrayerView()
//        .environment(\.locale, .init(identifier: "ur"))
}
