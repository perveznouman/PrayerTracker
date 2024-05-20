//
//  TempView.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 17/05/24.
//

import SwiftUI

struct TempView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    TempView()
}


//struct MarkPrayer: View {
//    var body: some View {
//        NavigationView {
//            VStack {
//                NavigationLink(LocalizedStringKey("makeNewEntry")) {
//                    TempView()
//                }
//            }
//            .navigationTitle(LocalizedStringKey("makeNewEntry"))
//        }
//        .edgesIgnoringSafeArea(.bottom)
//    }
//}

//struct MarkPrayer: View {
//    @State private var navigateToDestination = false
//
//    var body: some View {
//
//        NavigationView {
//            VStack {
//                Button(action: {
//                    navigateToDestination = true
//                    print("Action")
//                }, label: {
//                    Text(LocalizedStringKey("makeNewEntry"))
//                })
//
//                NavigationLink(
//                    destination: TempView(),
//                    isActive: $navigateToDestination,
//                    label: {
//                        // EmptyView is used here to keep the NavigationLink hidden
//                        EmptyView()
//                    })
//            }
//            .navigationTitle("Home")
//        }
//        .edgesIgnoringSafeArea(.bottom)
//    }
//}
