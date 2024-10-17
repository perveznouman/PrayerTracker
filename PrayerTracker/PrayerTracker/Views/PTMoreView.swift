//
//  PTMoreView.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 15/10/24.
//

import SwiftUI

struct PTMoreView: View {
    
    
    @ObservedObject var notificationVM = PTNotificationSettingsViewModel()
    @State var isNotificationSecOpen = false
    @State var isReminderSecOpen = true

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
                        header: PTNotificationSectionHeader(
                            title: NSLocalizedString("notification", comment: ""),
                            description: NSLocalizedString("notificationDescription", comment: ""),
                            isExpanded: $isNotificationSecOpen, otherSection: $isReminderSecOpen,
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
                        header: PTReminderSectionHeader(
                            title: NSLocalizedString("reminder", comment: ""),
                            description: NSLocalizedString("reminderDescription", comment: ""),
                            isExpanded: $isReminderSecOpen, otherSection: $isNotificationSecOpen,
                            toggleON: $notificationVM.isAuthorized
                        )
                    ) {
                        if (notificationVM.isAuthorized && !isNotificationSecOpen) {
                            PTReminderView()
                        }
                    }.textCase(.none)
                }
                .padding(.bottom, 35)
                .colorMultiply(Color.PTWhite)
            }
            .onAppear {
                notificationVM.isNotificationAuthorized()
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
    
    var body: some View {
        
        ZStack {
            Color.PTViewBackgroundColor
                .ignoresSafeArea()
               
            VStack {
                Spacer()
                DatePicker("", selection: $selectedHour, displayedComponents: .hourAndMinute)
                    .onChange(of: selectedHour) { oldValue, newValue in
                        PTNotificationSettingsViewModel().updateReminderTime(newValue)
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

struct PTReminderSectionHeader: View {
    
    var id: String {
        return title
    }
    @State var title: String
    @State var description: String
    @Binding var isExpanded: Bool
    @Binding var otherSection: Bool
    @Binding var toggleON: Bool
    
    var body: some View {
        
        VStack(alignment:.leading, spacing: 0) {
            HStack {
                
                Button(action: {}, label: {
                    Text(title)
                })
                .foregroundColor(.PTWhite)
                .font(.PTPrayerCell)
                .frame(alignment: .leading)
                
                Spacer()
                
                Toggle("", isOn: $toggleON)
                    .onChange(of: toggleON) { oldValue, newValue in
                        if(newValue) {
                            isExpanded = true
                            otherSection = false
                        }
                        else {
                            isExpanded = false
                        }
                    }
                    .tint(.PTAccentColor)
            }
            
            Button(action: {}, label: {
                Text(description)
            })
            .foregroundColor(.PTGray)
            .font(.PTCellDetailedText)
            
        }
    }
}

struct PTNotificationSectionHeader: View {
    
    var id: String {
        return title
    }
    @State var title: String
    @State var description: String
    @Binding var isExpanded: Bool
    @Binding var otherSection: Bool
    @State var openImage: String
    @State var closeImage: String
    
    var body: some View {
        
        VStack(alignment:.leading, spacing: 0) {
            HStack {
                
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                        otherSection = false
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
                        isExpanded.toggle()
                        otherSection = false
                    }
                }, label: {
                    if isExpanded {
                        Image(systemName: openImage)
                    } else {
                        Image(systemName: closeImage)
                    }
                })
                .foregroundColor(.accentColor)
                .frame(alignment: .trailing)
            }
            
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                    otherSection = false
                }
            }, label: {
                Text(description)
            })
            .foregroundColor(.PTGray)
            .font(.PTCellDetailedText)
            
        }
    }
}


#Preview {
    PTMoreView()
}
