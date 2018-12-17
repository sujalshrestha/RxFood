//
//  ExamplesVC.swift
//  RxFood
//
//  Created by Hira on 12/12/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct Student {
    var score: BehaviorRelay<String>
}

class ExamplesVC: UIViewController {

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //filterExample()
//        transformExample()
        //mapExample()
        //combineExample()
        flatMapExample()
    }

    fileprivate func filterExample() {
        let marks = Observable.of(30,30,40,40,50,35,42,46,90,12,43,23,67,30,40,40)

        marks.filter({ $0 > 40 })
            .subscribe(onNext: { (marksValue) in
                print("pass: ", marksValue)
            })
            .disposed(by: disposeBag)

//        marks.skip(3)
//            .subscribe(onNext: {
//                print($0)
//            })
//            .disposed(by: disposeBag)

       marks.distinctUntilChanged()
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
    }

    fileprivate func transformExample() {
        let names = Observable.of(13,14,55,67)

        names.enumerated()
            .map({ (index, value) in
                index > 1 ? value * 2 : value
            })
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
    }

    fileprivate func mapExample() {
        let sjl = Student(score: BehaviorRelay.init(value: "Sjl"))
        let shr = Student(score: BehaviorRelay.init(value: "Shrestha"))

        let student = PublishSubject<Student>()

        student.flatMapLatest {
            $0.score.asObservable()
        }
            .subscribe(onNext: {
                print($0)
            })
        .disposed(by: disposeBag)

        student.onNext(sjl)
        sjl.score.accept("asdadsd")

        //student.onNext(shr)
        //shr.score.accept("Babsdbsadb")

        sjl.score.accept("New SSS")
        sjl.score.accept("BVBVBV")
        //student.onNext(shr)

        student.onNext(shr)
        shr.score.accept("adasdsadsad")

        sjl.score.accept("NEWWWW")

    }

    fileprivate func combineExample() {
        let numbers = Observable.of(2,3,4,5)

        numbers.startWith(1)
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
    }

    fileprivate func flatMapExample() {
        let seq1 = Observable.of(1,3,5,7)
        let seq2 = Observable.of(2,4,6,8)

        let sequences = Observable.of(seq1, seq2)

        sequences.flatMap{ return $0 }
            .subscribe {
                print($0)
        }
        .disposed(by: disposeBag)
    }
}
