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
                        header: SectionHeader(
                            title: NSLocalizedString("notification", comment: ""),
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
                    }
                    
                    Section(
                        header: SectionHeader(
                            title: NSLocalizedString("reminder", comment: ""),
                            isOn: $isReminderSecOpen, otherSection: $isNotificationSecOpen,
                            openImage: "chevron.up",
                            closeImage: "chevron.down"
                        )
                    ) {
                        if isReminderSecOpen {
                            ForEach($notificationVM.reminders) { $reminder in
                                PTPrayerReminderCellView(reminder: $reminder)
                            }
                        }
                    }
                }
                .padding(.bottom, 35)
                .colorMultiply(Color.PTWhite)
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

struct SectionHeader: View {
    
    @State var title: String
    @Binding var isOn: Bool
    @Binding var otherSection: Bool
    @State var openImage: String
    @State var closeImage: String
    
    var body: some View {
        
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
            .foregroundColor(.accentColor)
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
    }
}


#Preview {
    PTMoreView()
}
