//
//  PTPrayerTimingRequester.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 17/07/24.
//

import Foundation

class PTPrayerTimingRequester {
    
    func getPrayerTimings(_ lat: Double, _ longs: Double, completion: @escaping (PTPrayerTimeResponse) -> Void) {
        
//    https://api.aladhan.com/v1/timings/17-07-2007?latitude=12.6825&longitude=-78.6167&method=1
//    https://api.aladhan.com/v1/calendar/2024/08?latitude=51.508515&longitude=-0.1254872&method=2
        var url: URL
        let month = Date().BHMonth
        let year = Date().BHYear
        
            url = URL(string: "https://api.aladhan.com/v1/calendar/\(year.escaped())\(month.escaped())?latitude=\(lat)&longitude=\(longs)&method=1")!
            
            let prayerTimeResource = Resource<PTPrayerTimeResponse>(url: url) { data in
                
                let prayerTimeResponse = try! JSONDecoder().decode(PTPrayerTimeResponse.self, from: data)
                return prayerTimeResponse
            }
            
            PTNetworkManager().load(resource: prayerTimeResource) { result in
                if let _ = result {
                    completion(result!)
                }
            }
    }
}
