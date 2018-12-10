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
        viewModel.images.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.collageImage.reload()
        })
        .disposed(by: viewModel.disposeBag)
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
