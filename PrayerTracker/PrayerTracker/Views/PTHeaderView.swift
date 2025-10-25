//
//  PTHeaderView.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 28/10/24.
//

import SwiftUI

struct PTHeaderView: View {
    
    @State var message: String
    
    var body: some View {
        HStack {
            Text(NSLocalizedString(message, comment: ""))
                .underline()
                .foregroundColor(.PTBlack)
                .font(.PTNotificationDisabledBanner)
                .multilineTextAlignment(.center)
        }
        .onTapGesture {
            if let url = URL(string: UIApplication.openNotificationSettingsURLString) {
                UIApplication.shared.open(url)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 25)
        .background(Color.PTBannerYellow)
    }
}

#Preview {
    PTHeaderView(message: "notificationDisabledMessage")
}
