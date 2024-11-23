//
//  PTMoreView.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 15/10/24.
//

import SwiftUI

enum PTMoreViewSectionHeader {
    case reminder
    case prayer
    case fique
    case about
}

struct PTMoreView: View {
    
    
    @ObservedObject var notificationVM: PTNotificationSettingsViewModel = .init()
    @State var isReminderToggleON = false
    @State var isNotificationEnabled = true
    @State var selectedSection: PTMoreViewSectionHeader = .about
    
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
                            header: PTFiqueSectionHeader()
                        ) {}.textCase(.none)
                        
                        Section(
                            header: PTReminderSectionHeader(
                                title: NSLocalizedString("reminder", comment: ""),
                                description: NSLocalizedString("reminderDescription", comment: ""),
                                expandedSection: $selectedSection,
                                toggleON: $isReminderToggleON, isLocationEnabled: $isNotificationEnabled
                            )
                        ) {
                            if (isReminderToggleON && (selectedSection != .prayer && selectedSection != .fique)) {
                                PTReminderView(reminderTime: notificationVM.getReminderTime())
                            }
                        }.textCase(.none)

                        Section(
                            header: PTPrayerNotificationSectionHeader(
                                title: NSLocalizedString("notification", comment: ""),
                                description: NSLocalizedString("notificationDescription", comment: ""),
                                expandedSection: $selectedSection,
                                openImage: "chevron.up",
                                closeImage: "chevron.down"
                            )
                        ) {
                            if selectedSection == .prayer {
                                ForEach($notificationVM.prayerReminder) { $reminder in
                                    PTPrayerReminderCellView(reminder: $reminder)
                                }
                            }
                        }.textCase(.none)
                        
                        Section(
                            header: PTAboutSectionHeader()
                        ) {}.textCase(.none)
                        
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

struct PTAboutSectionHeader: View {
    
    var body: some View {
        
        VStack(alignment:.leading, spacing: 0) {
            HStack {
                
                Button(action: {}, label: {
                    Text(NSLocalizedString("contactUs", comment: ""))
                })
                .foregroundColor(.PTWhite)
                .font(.PTPrayerCell)
                .frame(alignment: .leading)
                
                Spacer()

            }.contentShape(Rectangle())
         
            
            Button(action: {
                openMail(emailTo: "hibrisenouman@gmail.com",
                             subject: "App feedback",
                             body: "Hi")
            }, label: {
                Text("hibrisenouman@gmail.com")
            })
            .foregroundColor(.PTGray)
            .font(.PTCellDetailedText)
        }
    }
    
    func openMail(emailTo:String, subject: String, body: String) {
        if let url = URL(string: "mailto:\(emailTo)?subject=\(subject)&body=\(body)"),
           UIApplication.shared.canOpenURL(url)
        {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

struct PTPrayerReminderCellView: View {
    
    @Binding var reminder: PTNotificationSettings
    @EnvironmentObject var notificationVM: PTNotificationSettingsViewModel

    var body: some View {
        HStack {
            VStack(alignment:.leading, spacing: 0) {
                Text(LocalizedStringKey(reminder.title))
                    .foregroundColor(.PTWhite)
                    .font(.PTPrayerCell)
            }
            Toggle("", isOn: $reminder.isON)
                .onChange(of: reminder.isON) { oldValue, newValue in
                    notificationVM.updateReminderPermission(newValue, ofType: Notifications(rawValue: reminder.title)!)
                }
                .tint(.PTAccentColor)

        }
        .listRowBackground(Color.PTViewBackgroundColor)
    }
}

struct PTFiqueSectionHeader: View {
    
    @State var showingDetail = false

    var body: some View {
        
        VStack(alignment:.leading, spacing: 0) {
            HStack {
                
                Button(action: {
                    showingDetail.toggle()
                }, label: {
                    Text(NSLocalizedString("fique", comment: ""))
                }).sheet(isPresented: $showingDetail, content: {
                    FiqueSettingsView()
                })
                .foregroundColor(.PTWhite)
                .font(.PTPrayerCell)
                .frame(alignment: .leading)
                
                Spacer()
                
                Button(action: {
                    showingDetail.toggle()
                }, label: {
                    Image(systemName: "chevron.right")
                }).sheet(isPresented: $showingDetail, content: {
                    FiqueSettingsView()
                })
                .foregroundColor(.accentColor)
                .frame(alignment: .trailing)
            }.contentShape(Rectangle())
            .onTapGesture {
                showingDetail.toggle()
            }.sheet(isPresented: $showingDetail, content: {
                FiqueSettingsView()
            })
            
            Button(action: {
                showingDetail.toggle()
            }, label: {
                Text(NSLocalizedString("fiqueMessage", comment: ""))
            }).sheet(isPresented: $showingDetail, content: {
                FiqueSettingsView()
            })
            .foregroundColor(.PTGray)
            .font(.PTCellDetailedText)
        }
    }
}




struct PTReminderSectionHeader: View {
    
    var id: String {
        return title
    }
    @State var title: String
    @State var description: String
    @Binding var expandedSection: PTMoreViewSectionHeader
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
                            expandedSection = .reminder
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

struct PTPrayerNotificationSectionHeader: View {
    
    var id: String {
        return title
    }
    @State var title: String
    @State var description: String
    @Binding var expandedSection: PTMoreViewSectionHeader
    @State var openImage: String
    @State var closeImage: String
    
    var body: some View {
        
        VStack(alignment:.leading, spacing: 0) {
            HStack {
                
                Button(action: {
                    withAnimation {
                        if expandedSection == .prayer {
                            expandedSection = .reminder
                        }
                        else {
                            expandedSection = .prayer
                        }
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
                        if expandedSection == .prayer {
                            expandedSection = .reminder
                        }
                        else {
                            expandedSection = .prayer
                        }
                    }
                }, label: {
                    if expandedSection == .prayer {
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
                    expandedSection = .prayer
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
