//
//  CollageViewModel.swift
//  RxFood
//
//  Created by Hira on 12/10/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct CollageViewModel {
    let images = BehaviorRelay<[UIImage]>.init(value: [])
    let disposeBag = DisposeBag()

    func initialImages() {
        let imageArray = [#imageLiteral(resourceName: "heart_selected"), #imageLiteral(resourceName: "album_selected"), #imageLiteral(resourceName: "home_selected")]
        images.accept(imageArray)
    }

    func addImage(image: UIImage) -> Observable<Void> {

        return Observable.create({ (observer) -> Disposable in
            self.images.accept(self.images.value + [image])
            observer.onCompleted()
            return Disposables.create()
        })
    }

    func deleteImage(at index: Int) {
        var imageArray = images.value
        imageArray.remove(at: index)
        images.accept(imageArray)
    }

    func removeAllImages() {
        images.accept([])
    }
}
