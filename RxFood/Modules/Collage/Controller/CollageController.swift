//
//  CollageController.swift
//  RxFood
//
//  Created by Hira on 12/10/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import CollageView

class CollageController: UIViewController {

    @IBOutlet weak var collageImage: CollageView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var noImageLabel: UILabel!

    let viewModel = CollageViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupRx()
    }

    fileprivate func setupView() {
        navigationItem.title = "Collage"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        collageImage.dataSource = self
        collageImage.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
    }

    @objc func handleAdd() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary

        present(imagePicker, animated: true)
    }

    fileprivate func setupRx() {
        viewModel.images.subscribe(onNext: { [weak self] imageArray in
            guard let self = self else { return }
            self.noImageLabel.isHidden = imageArray.isEmpty ? false : true
            self.collageImage.reload()
        })
        .disposed(by: viewModel.disposeBag)

        clearButton.rx.tap
            .subscribe({ [unowned self] _ in
                self.removeAllImage()
            })
            .disposed(by: viewModel.disposeBag)

        saveButton.rx.tap
            .subscribe { [unowned self] _ in
                self.saveImage()
            }
            .disposed(by: viewModel.disposeBag)

        viewModel.images
            .map({ !$0.isEmpty })
            .bind(to: saveButton.rx.isEnabled)
            .disposed(by: viewModel.disposeBag)

        viewModel.images
            .map({ !$0.isEmpty })
            .bind(to: clearButton.rx.isEnabled)
            .disposed(by: viewModel.disposeBag)

    }

    fileprivate func removeAllImage() {
        AlertMessage.showWithCancel(on: self, title: nil, message: "Are you sure you want to clear all images?", onOk: {
            self.viewModel.removeAllImages()
        }, onCancel: nil)
    }

    fileprivate func saveImage() {
        guard let finalImage = image(with: collageImage) else { return }
        UIImageWriteToSavedPhotosAlbum(finalImage, self, #selector(imageSave(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    @objc func imageSave(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            AlertMessage.show(on: self, title: "Error", message: error.localizedDescription)
        } else {
            AlertMessage.show(on: self, title: "Success", message: "Image saved")
        }
    }

    func image(with view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }

}

extension CollageController: CollageViewDataSource {
    func collageViewNumberOfRowOrColoumn(_ collageView: CollageView) -> Int {
        let photosCount = viewModel.images.value.count
        let maxRow = 2
        return photosCount > maxRow ? maxRow : photosCount
    }

    func collageViewNumberOfTotalItem(_ collageView: CollageView) -> Int {
        return viewModel.images.value.count
    }

    func collageViewLayoutDirection(_ collageView: CollageView) -> CollageViewLayoutDirection {
        return .horizontal
    }

    func collageView(_ collageView: CollageView, configure itemView: CollageItemView, at index: Int) {
        itemView.image = viewModel.images.value[index]
        itemView.layer.borderWidth = 3
    }

}

extension CollageController: CollageViewDelegate {
    func collageView(_ collageView: CollageView, didSelect itemView: CollageItemView, at index: Int) {
        print("Item selected at \(index)")
        AlertMessage.showWithCancel(on: self, title: nil   , message: "Are you sure you want to delete this image?", onOk: { [weak self] in
            guard let self = self else { return }
            self.viewModel.deleteImage(at: index)
        },
        onCancel: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension CollageController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            viewModel.addImage(image: pickedImage)
                .subscribe { [weak self] in
                    guard let self = self else { return }
                    self.dismiss(animated: true, completion: nil)
                }
                .disposed(by: viewModel.disposeBag)
        }
    }
}
