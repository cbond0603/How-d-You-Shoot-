//
//  GolfTableViewCell.swift
//  How'd You Shoot?
//
//  Created by Chris Bond on 4/25/22.
//

import UIKit



class GolfTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    var golfData: GolfData! {
        didSet {
            courseNameLabel.text = golfData.course
            dateLabel.text = "\(golfData.date)"
            scoreLabel.text = "\(golfData.score)"
        }
    }
    

    
}
