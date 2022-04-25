//
//  DetailViewController.swift
//  How'd You Shoot?
//
//  Created by Chris Bond on 4/25/22.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var courseTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var scoreTextField: UITextField!
    @IBOutlet weak var p2NameTextField: UITextField!
    @IBOutlet weak var p2ScoreTextField: UITextField!
    @IBOutlet weak var p3NameTextField: UITextField!
    @IBOutlet weak var p3ScoreTextField: UITextField!
    @IBOutlet weak var p4NameTextField: UITextField!
    @IBOutlet weak var p4ScoreTextField: UITextField!
    
    
    var golfData: GolfData!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if golfData == nil {
            golfData = GolfData(course: "", score: nil, date: Date().addingTimeInterval(24*60*60), p2Name: "", p2Score: nil, p3Name: "", p3Score: nil, p4Name: "", p4Score: nil)
            courseTextField.becomeFirstResponder()
        }
    }
    
    
    func updateUserInterface() {
        courseTextField.text = golfData.course
        datePicker.date = golfData.date
//        scoreTextField.text = "\(golfData.score)"
        p2NameTextField.text = golfData.p2Name
        p3NameTextField.text = golfData.p3Name
        p4NameTextField.text = golfData.p4Name
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        golfData = GolfData(course: golfData.course, score: golfData.score, date: datePicker.date, p2Name: golfData.p2Name, p2Score: golfData.p2Score, p3Name: golfData.p3Name, p3Score: golfData.p3Score, p4Name: golfData.p4Name, p4Score: golfData.p4Score)
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
    }
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
    }
    

}
