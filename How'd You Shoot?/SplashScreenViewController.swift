//
//  SplashScreenViewController.swift
//  How'd You Shoot?
//
//  Created by Chris Bond on 4/25/22.
//

import UIKit
import Foundation

class SplashScreenViewController: UIViewController {

    @IBOutlet weak var bestLabel: UILabel!
    @IBOutlet weak var bestStaticLabel: UILabel!
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var averageStaticLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var totalStaticLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    var golfData: GolfData!
    var golfDataArray: [GolfData] = []
    var getGolfData = GetGolfData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.frame.origin.y = self.view.frame.height
        bestLabel.alpha = 0.0
        bestStaticLabel.alpha = 0.0
        averageLabel.alpha = 0.0
        averageStaticLabel.alpha = 0.0
        totalLabel.alpha = 0.0
        totalStaticLabel.alpha = 0.0
        
        getGolfData.loadData {
        }
        
        totalLabel.text = "\(getGolfData.golfDataArray.count)"
        bestLabel.text = "\(calc().1)"
        averageLabel.text = "\(calc().0/(getGolfData.golfDataArray.count))"

        
        
        UIView.animate(withDuration: 1.0, animations: {
            self.imageView.frame.origin.y = 0
        })
        
        UIView.animate(withDuration: 1.0, delay: 1.0, animations:
                        {self.bestLabel.alpha = 1.0; self.bestStaticLabel.alpha = 1.0; self.averageLabel.alpha = 1.0; self.averageStaticLabel.alpha = 1.0; self.totalLabel.alpha = 1.0; self.totalStaticLabel.alpha = 1.0 })
        
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "ShowTableView", sender: sender)
    }
    
    

    
    func calc() -> (Int, Int) {

        var sum = 0
        for rounds in getGolfData.golfDataArray {
            sum += rounds.score
        }

        var min = 200
        for rounds in getGolfData.golfDataArray {
            if rounds.score < min {
                min = rounds.score
            }
        }
        let calcSum = sum
        let calcMin = min

        return (calcSum, calcMin)
    }
}
