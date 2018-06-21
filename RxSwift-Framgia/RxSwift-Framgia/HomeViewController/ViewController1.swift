//
//  ViewController.swift
//  RxSwift-Framgia
//
//  Created by nguyen.van.bao on 07/06/2018.
//  Copyright © 2018 nguyen.van.bao. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class ViewController1: UIViewController {
    @IBOutlet weak var buttonTap: UIButton!
    let one = 1
    let two = 2
    let three = 3
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Just
        // From []
        // Empty
        // Nerver
        // DisposeBag
//                let observable12: Observable<Int> = Observable<Int>.just(one)
//
//                let observable4 = Observable.from([one, two, three])
//                let observable = Observable<Void>.empty()  // rong
//                observable12
//                    .subscribe(
//                        onNext: { element in
//                            print(element)
//                    },
//                        onCompleted: {
//                            print("Completed")
//                    }
//                )
//        let observable = Observable<Any>.never()
//        observable
//            .subscribe(
//                onNext: { element in
//                    print(element)
//            },
//                onCompleted: {
//                    print("Completed")
//            }
//        )
//
//
//        let observable2 = Observable<Int>.range(start: 1, count: 10)
//        observable2
//            .subscribe(onNext: { i in
//                let n = Double(i)
//                let fibonacci = Int(((pow(1.61803, n) - pow(0.61803, n)) /
//                    2.23606).rounded())
//            print(fibonacci)
//    })
//        enum myErr: Error {
//            case anErr
//        }
//        let disposeBag = DisposeBag()

        // 2
//        Observable.of("A", "B", "C")
//            .subscribe { // 3
//                print($0)
//            }
//            .disposed(by: disposeBag) //
//        Observable<String>.create { observer in
//            // 1
//            observer.onNext("1")
//
//            // 2
//            observer.onError(myErr.anErr)
//           observer.onCompleted()
//
//            // 3
//            observer.onNext("?")
//
//            // 4
//            return Disposables.create()
//
//        }.subscribe(
//                onNext: { print($0) },
//                onError: { print($0) },
//                onCompleted: { print("Completed") },
//                onDisposed: { print("Disposed") }
//            )
//            .disposed(by: disposeBag)
// MARK: PublishSubject
      
        //subject.on(.next("1"))
//        let subject = PublishSubject<String>()
//        subject.onNext("First")
//        let subscriptionOne =
//            subject.subscribe(onNext: { event in
//                print("sub1 \(event)")
//            })
//        subject.onNext("Second")
//
//        let subscriptionTwo =
//            subject.subscribe(onNext: { event in
//               print("sub2 \(event)")
//            })
//        subscriptionOne.dispose()
//        subject.on(.next("Third"))
//        subject.onCompleted()
//        subject.onNext("Fourth")
//
//        let subscriptionThree = subject.subscribe { event in
//            print("sub3",(event.element ?? event))
//        }
//        let subscriptionFour = subject.subscribe {
//            print("sub3",($0.element ?? $0))
//     }
//        subject.onNext("check emit")
        enum MyError: Error {
            case anError
        }
        // MARK: - BehaviorSubject

        //   show lại latest value
//            let subject = BehaviorSubject(value: "Initial value")
//
//            let disposeBag = DisposeBag()
//
//            subject.onNext("X")
//            subject
//                .subscribe {
//                    prints(label: "1)", event: $0)
//                }
//                .disposed(by: disposeBag)
//            subject.onNext("22")
//            // 1
//            subject.onError(MyError.anError)
//
//          //   2
//            subject
//                .subscribe {
//                    prints(label: "2)", event: $0)
//                }
//                .disposed(by: disposeBag)
        
        // MARK: - ReplaySubject
//        let subject = ReplaySubject<String>.create(bufferSize: 5)
        let disposeBag = DisposeBag()
//        subject.onNext("1")
//        subject.onNext("2")
//        subject.onNext("3")
//        subject.onNext("4")
//        subject.onNext("5")
//        subject.onNext("6")
//        subject
//            .subscribe {
//              self.printEX(label: "sub1", event: $0)
//        } .disposed(by: disposeBag)
//        print("............")
//        subject
//            .subscribe {
//                self.printEX(label: "sub2", event: $0)
//            } .dispose()
//
//
        // MARK: - Variable
        
      /* 1) new init value
         1) ss
         2) ss
         1) ssssss
         2) ssssss
         1) completed
         2) completed
*/
//        var variable = Variable("init variable")
//        variable.value = "new init value"
//        variable.asObservable()
//            .subscribe{
//                self.printEX(label: "1)", event: $0)
//        }.disposed(by: disposeBag)
//        variable.value = "ss"
//        variable.asObservable()
//            .subscribe{
//                self.printEX(label: "2)", event: $0)
//            }.disposed(by: disposeBag)
//        variable.value = "ssssss"
}
    func printEX<T: CustomStringConvertible>(label: String , event: Event<T>) {
        print(label, event.element ?? event.error ?? event)
    }

@IBAction func buttonTapp(_ sender: UIButton) {
//    let observable2 = Observable.of(one,two,three)
//    observable2.subscribe { (event) in
//        print(event.element)
//    }
//
//    observable2.subscribe(onNext: { (next) in
//        print(next)
//    }, onError: { (err) in
//
//    }, onCompleted: {
//        print("completed")
//    }) {
//        print("done")
//    }
//    let disposeBag = DisposeBag()
//
//    // 1
//    var flip = false
//
//    // 2
//    let factory: Observable<Int> = Observable.deferred {
//
//        // 3
//        flip = !flip
//
//        // 4
//        if flip {
//            return Observable.of(1, 2, 3)
//        } else {
//            return Observable.of(4, 5, 6)
//        }
//    }
//    for _ in 0...3 {
//        factory.subscribe(onNext: {
//            print($0, terminator: "")
//
//        })
//            .disposed(by: disposeBag)
//        print()
//    }
}
}

