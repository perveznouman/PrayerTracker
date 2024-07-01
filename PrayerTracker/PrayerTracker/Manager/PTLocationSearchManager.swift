//
//  PTLocationSearchManager.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 01/07/24.
//

import Foundation
import MapKit
import Combine


class PTLocationSearchManager : NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    @Published var searchQuery = ""
    var completer: MKLocalSearchCompleter
    @Published var completions: [MKLocalSearchCompletion] = []
    var cancellable: AnyCancellable?
    
    override init() {
        completer = MKLocalSearchCompleter()
        super.init()
        cancellable = $searchQuery.assign(to: \.queryFragment, on: self.completer)
        completer.delegate = self
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        print(#function, completer.results)
        self.completions = completer.results
    }
}

extension MKLocalSearchCompletion: Identifiable {}
