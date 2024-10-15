//
//  PTMoreView.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 15/10/24.
//

import SwiftUI

struct PTMoreView: View {
    
    let notifications = [
        "Fajr",
        "Dohar",
        "Asar",
        "Maghrib",
        "Isha"
    ]
    
    
    @ObservedObject var notificationVM = PTNotificationSettingsViewModel()
    @State var isNotificationSecOpen = false
    @State var isReminderSecOpen = false
    @State private var showTimePicker = false

    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.PTAccentColor]
    }
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color.PTViewBackgroundColor
                    .ignoresSafeArea()
                
                List {

                    Section(
                        header: PTMoreSectionHeader(
                            title: NSLocalizedString("notification", comment: ""),
                            description: NSLocalizedString("notificationDescription", comment: ""),
                            isOn: $isNotificationSecOpen, otherSection: $isReminderSecOpen,
                            openImage: "chevron.up",
                            closeImage: "chevron.down"
                        )
                    ) {
                        if isNotificationSecOpen {
                            ForEach($notificationVM.prayerReminder) { $reminder in
                                PTPrayerReminderCellView(reminder: $reminder)
                            }
                        }
                    }.textCase(.none)
                    
                    Section(
                        header: PTMoreSectionHeader(
                            title: NSLocalizedString("reminder", comment: ""),
                            description: NSLocalizedString("reminderDescription", comment: ""),
                            isOn: $isReminderSecOpen, otherSection: $isNotificationSecOpen,
                            openImage: "chevron.up",
                            closeImage: "chevron.down"
                        )
                    ) {
                        if isReminderSecOpen {
                            PTReminderView(shouldShowPicker: $showTimePicker)
//                            ForEach($notificationVM.reminders) { $reminder in
//                                PTPrayerReminderCellView(reminder: $reminder)
//                            }
                        }
                    }.textCase(.none)
                }
                .padding(.bottom, 35)
                .colorMultiply(Color.PTWhite)
            }
            .onAppear {
                UIDatePicker.appearance().minuteInterval = 15
            }
            .onDisappear {
                UIDatePicker.appearance().minuteInterval = 1
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.PTAccentColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .accentColor(.PTAccentColor)
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle(LocalizedStringKey("more"))
        }
    }
}

struct PTReminderView: View {
    @State var selectedHour = Date()
    @Binding var shouldShowPicker: Bool
    
    var body: some View {
        
        ZStack {
            Color.PTViewBackgroundColor
                .ignoresSafeArea()
                .onTapGesture {
                    shouldShowPicker.toggle()
                }
            VStack {
                Spacer()
                DatePicker("", selection: $selectedHour, displayedComponents: .hourAndMinute)
                    .onChange(of: selectedHour) { oldValue, newValue in
                    }
                    .preferredColorScheme(.dark)
                    .colorMultiply(.PTWhite)
                    .labelsHidden()
                    .datePickerStyle(.wheel)
                    .frame(maxHeight: 400)
            }
        }
    }
}

struct PTPrayerReminderCellView: View {
    
    @Binding var reminder: PTNotificationSettings
    
    var body: some View {
        HStack {
            VStack(alignment:.leading, spacing: 0) {
                Text(LocalizedStringKey(reminder.title))
                    .foregroundColor(.PTWhite)
                    .font(.PTPrayerCell)
            }
            Toggle("", isOn: $reminder.isON)
                .onChange(of: reminder.isON) { oldValue, newValue in
                    
                }
                .tint(.PTAccentColor)

        }
        .listRowBackground(Color.PTViewBackgroundColor)
    }
}

struct PTMoreSectionHeader: View {
    
    @State var title: String
    @State var description: String
    @Binding var isOn: Bool
    @Binding var otherSection: Bool
    @State var openImage: String
    @State var closeImage: String
    
    var body: some View {
        
        VStack(alignment:.leading, spacing: 0) {
            HStack {
                
                Button(action: {
                    withAnimation {
                        isOn.toggle()
                    }
                }, label: {
                    Text(title)
                })
                .foregroundColor(.PTWhite)
                .font(.PTPrayerCell)
                .frame(alignment: .leading)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        isOn.toggle()
                        otherSection = false
                    }
                }, label: {
                    if isOn {
                        Image(systemName: openImage)
                    } else {
                        Image(systemName: closeImage)
                    }
                })
                .foregroundColor(.accentColor)
                .frame(alignment: .trailing)
            }
   
            Text(description)
                .foregroundColor(.PTGray)
                .font(.PTCellDetailedText)

        }
    }
}


#Preview {
    PTMoreView()
}
