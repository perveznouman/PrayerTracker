//
//  PTNetworkManager.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 17/07/24.
//

import Foundation


struct Resource<T> {
    let url: URL
    let parse: (Data) -> T?
}

final class PTNetworkManager {
    
    func load<T> (resource: Resource<T>, completion: @escaping (T?) -> () ) {
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    completion(resource.parse(data))
                }
            }
            else {
                completion(nil)
            }
        }.resume()
    }
}
