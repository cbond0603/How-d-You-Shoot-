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
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var aboutButton: UIButton!
    
    var golfData: GolfData!
    var golfDataArray: [GolfData] = []
    var getGolfData = GetGolfData()
    
    var imagePickerController = UIImagePickerController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePickerController.delegate = self
        
        imageView.frame.origin.y = self.view.frame.height
        bestLabel.alpha = 0.0
        bestStaticLabel.alpha = 0.0
        averageLabel.alpha = 0.0
        averageStaticLabel.alpha = 0.0
        totalLabel.alpha = 0.0
        totalStaticLabel.alpha = 0.0
        cameraButton.alpha = 0.0
        aboutButton.alpha = 0.0
        
        getGolfData.loadData {
        }
        
        
        if getGolfData.golfDataArray.count == 0 {
            totalLabel.text = "N/A"
            bestLabel.text = "N/A"
            averageLabel.text = "N/A"
        } else {
            totalLabel.text = "\(getGolfData.golfDataArray.count)"
            bestLabel.text = "\(calc().1)"
            averageLabel.text = "\(calc().0/(getGolfData.golfDataArray.count))"
        }
                
        
        UIView.animate(withDuration: 1.0, animations: {
            self.imageView.frame.origin.y = 0
        })
        
        UIView.animate(withDuration: 1.0, delay: 1.0, animations:
                        {self.bestLabel.alpha = 1.0; self.bestStaticLabel.alpha = 1.0; self.averageLabel.alpha = 1.0; self.averageStaticLabel.alpha = 1.0; self.totalLabel.alpha = 1.0; self.totalStaticLabel.alpha = 1.0; self.cameraButton.alpha = 1.0; self.aboutButton.alpha = 1.0})
        
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "ShowTableView", sender: sender)
        
        
        getGolfData.saveData()
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
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }

    @IBAction func photoOrCameraPressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (_) in
            self.accessPhotoLibrary()
        }
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (_) in
            self.accessCamera()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cameraAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func unwindHomePressed(segue: UIStoryboardSegue) {
        if segue.identifier == "homePressedUnwind" {
            performSegue(withIdentifier: "ShowTableView", sender: nil)
        }
        getGolfData.saveData()

    }
    
    @IBAction func unwindBackFromAboutPressed(segue: UIStoryboardSegue) {
        if segue.identifier == "backPressedUnwind" {
            performSegue(withIdentifier: "ShowAbout", sender: nil)
        }
    }
}

extension SplashScreenViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageView.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = originalImage
        }
        dismiss(animated: true, completion: nil)
        getGolfData.saveData()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func accessPhotoLibrary() {
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func accessCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.sourceType = .camera
        } else {
            showAlert(title: "Camera Not Available", message: "There is no camera on this device")
        }
    }
}
