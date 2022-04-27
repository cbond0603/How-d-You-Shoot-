//
//  DetailViewController.swift
//  How'd You Shoot?
//
//  Created by Chris Bond on 4/25/22.
//

import UIKit
import GooglePlaces

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .short
    return dateFormatter
}()

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
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    
    var golfData: GolfData!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if golfData == nil {
            golfData = GolfData(course: "", score: 0 , date: Date().addingTimeInterval(24*60*60), p2Name: "", p2Score: 0, p3Name: "", p3Score: 0, p4Name: "", p4Score: 0)
        }
        updateUserInterface()
    }
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, MMM d"
        return dateFormatter
    }()
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        self.view.endEditing(true)
        golfData.date = datePicker.date
    }
    
    func updateUserInterface() {
        courseTextField.text = golfData.course
        datePicker.date = golfData.date
        scoreTextField.text = "\(golfData.score)"
        p2NameTextField.text = golfData.p2Name
        p3NameTextField.text = golfData.p3Name
        p4NameTextField.text = golfData.p4Name
        p2ScoreTextField.text = "\(golfData.p2Score)"
        p3ScoreTextField.text = "\(golfData.p3Score)"
        p4ScoreTextField.text = "\(golfData.p4Score)"
        
        enableDisableSaveButton(text: courseTextField.text!)

    }


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        golfData = GolfData(course: courseTextField.text!, score: Int(scoreTextField.text ?? "")!, date: datePicker.date, p2Name: p2NameTextField.text!, p2Score: Int(p2ScoreTextField.text ?? "")!, p3Name: p3NameTextField.text!, p3Score: Int(p3ScoreTextField.text ?? "")!, p4Name: p4NameTextField.text!, p4Score: Int(p4ScoreTextField.text ?? "")!)
    }
    
    func enableDisableSaveButton(text: String) {
        if text.count > 1 {
            saveBarButton.isEnabled = true
        } else {
            saveBarButton.isEnabled = false
        }
    }
    
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        enableDisableSaveButton(text: sender.text!)
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func lookupButtonPressed(_ sender: UIBarButtonItem) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
        
    }
    
}

extension DetailViewController: GMSAutocompleteViewControllerDelegate {

  // Handle the user's selection.
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
      
    golfData.course = place.name ?? "Unknown Course"
    updateUserInterface()
    dismiss(animated: true, completion: nil)
  }

  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    print("Error: ", error.localizedDescription)
  }

  // User canceled the operation.
  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    dismiss(animated: true, completion: nil)
  }

}
