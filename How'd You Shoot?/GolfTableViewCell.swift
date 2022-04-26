//
//  GolfTableViewCell.swift
//  How'd You Shoot?
//
//  Created by Chris Bond on 4/25/22.
//

import UIKit


private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    return dateFormatter
}()

class GolfTableViewCell: UITableViewCell {

    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!

    var golfData: GolfData! {
        didSet {
            courseNameLabel.text = golfData.course
            scoreLabel.text = "\(golfData.score)"
            dateLabel.text = dateFormatter.string(from: golfData.date)
        }
    }
}
