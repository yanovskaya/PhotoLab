//
//  ViewController.swift
//  PhotoLab
//
//  Created by Elena Yanovskaya on 27/01/2019.
//  Copyright © 2019 Elena Yanovskaya. All rights reserved.
//

import UIKit
import Photos
//import PKHUD

class ViewController: UIViewController {
    
    // MARK: - Constants
    
    @IBOutlet var loadButton: UIButton!
    @IBOutlet var nameTextField: UITextField!
    
    private enum Constants {
        static let cancel = "Отмена"
        static let removePhoto = "Удалить"
        static let chooseFromLibrary = "Выбрать из библиотеки"
        static let takePhoto = "Сделать фото"
    }
    
    var presentationModel = AddPhotoPresentationModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        bindEvents()
        hideKeyboardWhenTappedAround()
        loadButton.layer.cornerRadius = 3
    }

    @IBAction func chooseImage(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let libraryAction = UIAlertAction(title: Constants.chooseFromLibrary, style: .default) { _ in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            alertController.addAction(libraryAction)
        }
        let cameraAction = UIAlertAction(title: Constants.takePhoto, style: .default) { _ in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(cameraAction)
        }
//        let removeAction = UIAlertAction(title: Constants.removePhoto, style: .destructive)
//        { _ in
//            self.imageToAttach = nil
//        }
//        if imageToAttach != nil {
//            alertController.addAction(removeAction)
//        }
        let cancelAction = UIAlertAction(title: Constants.cancel, style: .cancel)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Private Methods
    
    private func bindEvents() {
        presentationModel.changeStateHandler = { status in
            switch status {
            case .loading:
                break
                //HUD.show(.progress)
            case .rich:
                let secondViewController = PhotoViewController()
                secondViewController.photoLink = self.presentationModel.photoViewModel.photoURL
                
                self.present(secondViewController, animated: true, completion: nil)
                //HUD.hide()
                self.dismiss(animated: true)
            case .error (let code):
                break
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            presentationModel.addPhoto(title: nameTextField.text!, image: image)
        }
        dismiss(animated: true, completion: nil)
    }
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
    

// MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return false
    }
}
