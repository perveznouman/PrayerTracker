//
//  PTPrayerTimingRequester.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 17/07/24.
//

import Foundation

class PTPrayerTimingRequester {
    
    func getPrayerTimings(_ lat: Double, _ longs: Double, completion: @escaping (PTPrayerTimeResponse) -> Void) {
        
        let year = Date().BHYear
        let method = UserDefaults.standard.retrieve(object: Int.self, fromKey: PTConstantKey.selectedFique) ?? 3
        let school = UserDefaults.standard.retrieve(object: Int.self, fromKey: PTConstantKey.selectedSchool) ?? 1
        let url = URL(string: "https://api.aladhan.com/v1/calendar/\(year.escaped())?latitude=\(lat)&longitude=\(longs)&method=\(method)&school=\(school)")!
            
            let prayerTimeResource = Resource<PTPrayerTimeResponse>(url: url) { data in
                
                let prayerTimeResponse = try? JSONDecoder().decode(PTPrayerTimeResponse.self, from: data)
                return prayerTimeResponse
            }
            
            PTNetworkManager().load(resource: prayerTimeResource) { result in
                if let _ = result {
                    completion(result!)
                }
            }
    }
}
