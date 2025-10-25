//
//  PTUserDefaults.swift
//  PrayerTracker
//
//  Created by Nouman Pervez on 29/06/24.
//

import Foundation


extension UserDefaults {
    
    func save<T:Encodable>(customObject object: T, inKey key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(object) {
            self.set(encoded, forKey: key)
        }
    }
    
    func retrieve<T:Decodable>(object type:T.Type, fromKey key: String) -> T? {
        if let data = self.data(forKey: key) {
            let decoder = JSONDecoder()
            if let object = try? decoder.decode(type, from: data) {
                return object
            }else {
                print("Couldnt decode object")
                return nil
            }
        }else {
            return nil
        }
    }
    
}
