//
//  PTMoreView.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 15/10/24.
//

import SwiftUI

struct PTMoreView: View {
    
    
    @ObservedObject var notificationVM: PTNotificationSettingsViewModel = .init()
    @State var isNotificationSecOpen = false
    @State var isReminderSecOpen = true
    @State var isReminderToggleON = false
    @State var isNotificationEnabled = true

    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.PTAccentColor]
    }
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color.PTViewBackgroundColor
                    .ignoresSafeArea()
                
                VStack {
                    
                    if (!isNotificationEnabled) {
                        PTHeaderView(message: "notificationDisabledMessage")
                    }
                    
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
                                toggleON: $isReminderToggleON, isLocationEnabled: $isNotificationEnabled
                            )
                        ) {
                            if (isReminderToggleON && !isNotificationSecOpen) {
                                PTReminderView(reminderTime: notificationVM.getReminderTime())
                            }
                        }.textCase(.none)
                    }
                    .padding(.bottom, 35)
                    .colorMultiply(Color.PTWhite)
                }
            }
            .onDisappear {
                UIDatePicker.appearance().minuteInterval = 1
            }
            .onAppear(perform: { notificationVM.isNotificationAuthorized { authorized in
                    isNotificationEnabled = authorized
                    isReminderToggleON = authorized && notificationVM.getReminderPermission()
                }
                UIDatePicker.appearance().minuteInterval = 15
            })
            .environmentObject(notificationVM)
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
    
    var reminderTime: [String]
    @State var selectedHour = Date()
    @EnvironmentObject var notificationVM: PTNotificationSettingsViewModel
    
    var body: some View {
        
        ZStack {
            Color.PTViewBackgroundColor
                .ignoresSafeArea()
               
            VStack {
                Spacer()
                DatePicker("", selection: $selectedHour, displayedComponents: .hourAndMinute)
                    .onChange(of: selectedHour) { oldValue, newValue in
                        notificationVM.updateReminderTime(newValue)
                    }
                    .preferredColorScheme(.dark)
                    .colorMultiply(.PTWhite)
                    .labelsHidden()
                    .datePickerStyle(.wheel)
                    .frame(maxHeight: 400)
            }
        }.onAppear {
            let calendar = Calendar(identifier: .gregorian)
            let components = DateComponents(hour: Int(reminderTime[0])!, minute: Int(reminderTime[1])!)
            if let customDate = calendar.date(from: components) {
                self.selectedHour = customDate
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
    @Binding var isLocationEnabled: Bool
    @EnvironmentObject var notificationVM: PTNotificationSettingsViewModel

    
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
                        notificationVM.updateReminderPermission(newValue)
                        if(newValue) {
                            isExpanded = true
                            otherSection = false
                        }
                        else {
                            isExpanded = false
                        }
                    }
                    .disabled(!isLocationEnabled)
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

/*
struct PTNotificationBanner: View {

  @State private var showView: Bool = false

  var body: some View {
    ZStack(alignment: .top) {

      VStack {
        Spacer()
        Button("Show Alert") {
          withAnimation { showView.toggle() }
        }
        Spacer()
      }

      if showView {
        RoundedRectangle(cornerRadius: 15)
          .fill(Color.blue)
          .frame(
            width: UIScreen.main.bounds.width * 0.9,
            height: UIScreen.main.bounds.height * 0.1
          )
          .transition(.asymmetric(
            insertion: .move(edge: .top),
            removal: .move(edge: .top)
          ))
      }
    }
  }
}
*/

#Preview {
    PTMoreView()
}
