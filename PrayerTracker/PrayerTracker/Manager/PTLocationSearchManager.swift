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
    @Published var completions: [MKLocalSearchCompletion] = []
    @Published var error: Error!
    private var completer: MKLocalSearchCompleter
    private var cancellable: AnyCancellable?
    
    override init() {
        completer = MKLocalSearchCompleter()
        super.init()
        self.completer.resultTypes = .address
        cancellable = $searchQuery.assign(to: \.queryFragment, on: self.completer)
        completer.delegate = self
    }
   /* 
    Example to create error Object
    func triggerError() {
        self.error = NSError(domain: "com.example.error", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Simulated error"])
    }
    */
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.completions = completer.results
    }
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        self.error = error
    }
    func getCityLatLong(result: MKLocalSearchCompletion, completion: @escaping (PTLocation) -> Void) {
        var searchResult: PTLocation?
        let request = MKLocalSearch.Request(completion: result)
        let search = MKLocalSearch(request: request)
        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()

        search.start { (response, error) in
 
            defer {
                dispatchGroup.leave()
            }
            
            guard let response = response else {
                return
            }
            
            for item in response.mapItems {
                if let location = item.placemark.location {
                    let city = item.placemark.locality ?? ""
                    var country = item.placemark.country ?? ""
                    if country.isEmpty {
                        country = item.placemark.countryCode ?? ""
                    }
                    if !city.isEmpty {
                        searchResult = PTLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, city: city, country: country, isManualSaved: true)
                    }
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            completion(searchResult!)
        }
    }
}

extension MKLocalSearchCompletion: Identifiable {}
