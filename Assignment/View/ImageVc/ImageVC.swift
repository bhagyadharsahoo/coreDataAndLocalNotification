//
//  ImageVC.swift
//  Assignment
//
//  Created by Bhagyadhar Sahoo on 22/06/25.
//

import UIKit
import UIKit

final class ImageVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private let imageView = UIImageView()
    private let cameraButton = UIButton(type: .system)
    private let galleryButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    private func setupUI() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.systemGray5
        view.addSubview(imageView)
        cameraButton.setTitle("Take Photo", for: .normal)
        galleryButton.setTitle("Choose from Gallery", for: .normal)
        cameraButton.addTarget(self, action: #selector(openCamera), for: .touchUpInside)
        galleryButton.addTarget(self, action: #selector(openGallery), for: .touchUpInside)

        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        galleryButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cameraButton)
        view.addSubview(galleryButton)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),

            cameraButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            cameraButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            galleryButton.topAnchor.constraint(equalTo: cameraButton.bottomAnchor, constant: 10),
            galleryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc private func openCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("Camera not available")
            return
        }
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
    }

    @objc private func openGallery() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            imageView.image = selectedImage
        }
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
