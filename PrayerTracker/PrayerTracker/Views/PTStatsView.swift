//
//  Stats.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 10/05/24.
//

import SwiftUI
import Charts

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
//    @Environment(PTSwiftDataManager.self) private var dataManager
//    @Environment(\.modelContext) private var modelContext

    var body: some View {
//        @Bindable var dataManager = dataManager

        NavigationStack {
            ZStack {
                Color.PTViewBackgroundColor
                    .ignoresSafeArea()
                
                VStack {
                    PTStatsPickerView(selectedSegment: $selectedParameter)
                        .padding(.bottom)
                    PTBarChartView(selectedSegment: $selectedParameter)
                        .padding(.top)
                    Spacer()
                }
//                Text(LocalizedStringKey(selectedParameter.rawValue))
//                    .foregroundColor(.white)

                //                NavigationLink(LocalizedStringKey("makeNewEntry")) {
                //                    TempView()
                //
                //                }
            }
//            .onAppear(perform: {
//                dataManager.fetchWeeklyPrayers(forContext: modelContext)
//            })
            .navigationTitle(LocalizedStringKey("statistics"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.PTAccentColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .accentColor(.PTAccentColor)
        .edgesIgnoringSafeArea(.bottom)
    }
}


struct PTBarChartView: View {
    @Binding var selectedSegment: PTStats
    @Environment(PTSwiftDataManager.self) private var dataManager
    @Environment(\.modelContext) private var modelContext
    @StateObject var prayerData = PTWeeklyViewModel()

    var body: some View {
        
        @Bindable var dataManager = dataManager
        let _: [String: Color] = [ "Offered": .PTRed,
                                              "Not Offered": .PTRed,
                                              "Wait": .PTGray]
        
        ZStack {
            VStack {
                Chart {
                    ForEach(prayerData.xAxis.indices, id: \.self) { index in
                        LineMark(x: .value("Day", prayerData.xAxis[index]), y: .value("offered", prayerData.offered[index]))
                        PointMark(x: .value("Day", prayerData.xAxis[index]), y: .value("offered", prayerData.offered[index]))
                            .annotation {
                                Text("\(prayerData.offered[index])")
                                    .foregroundColor(.PTWhite)
                        }
                    }
                }
                .chartYAxis{
                    AxisMarks(position: .leading, values: prayerData.yValues) {
                        AxisTick()
                        AxisValueLabel()
                            .foregroundStyle(Color.PTWhite)
                    }
                }
                .chartXAxis {
                    AxisMarks(position: .bottom, values: prayerData.xAxis) {
                        AxisTick()
                        AxisValueLabel()
                            .foregroundStyle(Color.PTWhite)
                    }

                }
                .frame(maxHeight: 300)
                .chartOverlay { proxy in
                                    

                }
                .padding(.horizontal)
                
                // Legend
                HStack {
                    Rectangle()
                        .fill(Color.PTRed)
                        .frame(width: 10, height: 10)
                    Text(LocalizedStringKey("legands"))
                        .foregroundColor(Color.PTAccentColor)
                        .font(.PTGraphLegand)
                        .padding(.horizontal, 4)
                }
                .padding(.top, 16)
            }
        }
        .onAppear(perform: {
           let statsData = dataManager.fetchWeeklyPrayers(forContext: modelContext)
            prayerData.setupWeeklyData(dateCount: statsData)
        })
        
    }
    
    func barChart () {
        //                BarMark(x: .value("Day", prayerData.xAxis[index]), y: .value("offered", prayerData.offered[index]))
        ////                    .foregroundStyle(by: .value("Day", weekdays[index]))
        //                    .annotation {
        //                        Text("\(prayerData.offered[index])")
        //                            .foregroundColor(.PTWhite)
        //                }
    }
}

struct PTStatsPickerView: View {
    
    @Binding var selectedSegment: PTStats
    var body: some View {
        Picker("", selection: $selectedSegment) {
            ForEach(PTStats.allCases, id: \.self) { stats in
                Text(LocalizedStringKey(stats.rawValue))
                    .font(.PTButtonTitle)
            }
        }
        .onChange(of: selectedSegment, { oldValue, newValue in
            print(oldValue)
            print(newValue)
        })
        .tint(.PTAccentColor)
        .pickerStyle(.segmented)
        .padding(.top, 20)
        .padding(.leading, 15)
        .padding(.trailing, 15)
    }
}

#Preview {
//    PTBarChartView()
//    PickerView(selectedSegment: .constant(.weekly))
    PTStatsView()
}
