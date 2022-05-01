//
//  GetGolfData.swift
//  How'd You Shoot?
//
//  Created by Chris Bond on 4/25/22.
//

import Foundation

class GetGolfData {
    
    var golfDataArray: [GolfData] = []
    
    func loadData(completed: @escaping ()->() ) {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("golf").appendingPathExtension("json")
        
        guard let data = try? Data(contentsOf: documentURL) else {return}
        let jsonDecoder = JSONDecoder()
        do {
            golfDataArray = try jsonDecoder.decode(Array<GolfData>.self, from: data)

        } catch {
            print("ERROR: Could not load Data \(error.localizedDescription)")
        }
        completed()
    }
    
    func saveData() {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("golf").appendingPathExtension("json")
        let jsonEncoder = JSONEncoder()
        let data = try? jsonEncoder.encode(golfDataArray)
        do {
            try data?.write(to: documentURL, options: .noFileProtection)
        } catch {
            print("ERROR: could not save data \(error.localizedDescription)")
        }
    }
}
