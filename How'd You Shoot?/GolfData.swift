//
//  GolfData.swift
//  How'd You Shoot?
//
//  Created by Chris Bond on 4/25/22.
//

import Foundation

struct GolfData: Codable {
    var course: String
    var score: Int
    var date: Date
    var p2Name: String
    var p2Score: Int
    var p3Name: String
    var p3Score: Int
    var p4Name: String
    var p4Score: Int
}
