//
//  IgnoringOperators.swift
//  RxSwift-Framgia
//
//  Created by nguyen.van.bao on 13/06/2018.
//  Copyright © 2018 nguyen.van.bao. All rights reserved.
//

import UIKit
import RxSwift
class IgnoringOperators: UIViewController {
    let strikes = PublishSubject<Int>()
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        // 2
//        strikes
//            .elementAt(0)
//            .subscribe(onNext: { event in
//                print("\(event)You're out!")
//            })
//            .disposed(by: disposeBag)
//
//        strikes.onNext("0")
//        strikes.onNext("1")
//        strikes.onNext("2")
//        strikes.onCompleted()
        
//            strikes
//            .filter { integer in
//                integer % 2 == 0
//            }
//            .subscribe(onNext: {
//                print($0)
//            })
//            .disposed(by: disposeBag)
//        for i in 0...10 {
//             strikes.onNext(i)
//        }
//        strikes.onCompleted()
        
//        Observable.of("A", "B", "C", "D", "E", "F")
//            // 2
//            .skip(3)
//            .subscribe(onNext: {
//                print($0) })
//            .disposed(by: disposeBag)
        
//        let disposeBag = DisposeBag()
//        // 1
//        Observable.of(2, 2, 4, 4, 6, 6)
//            // 2
//            .takeWhileWithIndex { integer, index in
//                // 3
//                integer % 2 == 0 && index <= 3
//            }
//            // 4
//            .subscribe(onNext: {
//                print($0)
//            })
//            .disposed(by: disposeBag)
        
        
        
//        let disposeBag = DisposeBag()
//
//        // 1
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .spellOut
//
//        // 2
//        Observable<NSNumber>.of(10, 110, 20, 200, 210, 310)
//            // 3
//            .distinctUntilChanged { a, b in
//                // 4
//                guard let aWords = formatter.string(from: a)?.components(separatedBy: " "),
//                    let bWords = formatter.string(from: b)?.components(separatedBy: " ")
//                    else {
//                        return false
//                }
//
//                var containsMatch = false
//
//                // 5
//                for aWord in aWords {
//                    for bWord in bWords {
//                        if aWord == bWord {
//                            containsMatch = true
//                            break
//                        }
//                    }
//                }
//
//                return containsMatch
//            }
//            // 4
//            .subscribe(onNext: {
//                print($0)
//            })
//            .disposed(by: disposeBag)
        
        let disposeBag = DisposeBag()
        
        let contacts = [            "603-555-1212": "Florent",
            "212-555-1212": "Junior",
            "408-555-1212": "Marin",
            "617-555-1212": "Scott"
        ]
        
        func phoneNumber(from inputs: [Int]) -> String {
            var phone = inputs.map(String.init).joined()
            
            phone.insert("-", at: phone.index(
                phone.startIndex,
                offsetBy: 3)
            )
            
            phone.insert("-", at: phone.index(
                phone.startIndex,
                offsetBy: 7)
            )
            
            return phone
        }
        
        let input = PublishSubject<Int>()
        
        // Add your code here
        input
            .skipWhile { $0 == 0 }
            .filter { $0 < 10 }
            .take(10)
            .toArray()
            .subscribe(onNext: {
                let phone = phoneNumber(from: $0)
                
                if let contact = contacts[phone] {
                    print("Dialing \(contact) (\(phone))...")
                } else {
                    print("Contact not found")
                }
            })
            .disposed(by: disposeBag)
        
        input.onNext(0)
        input.onNext(603)

        input.onNext(2)
        input.onNext(1)

        // Confirm that 7 results in "Contact not found", and then change to 2 and confirm that Junior is found
        input.onNext(7)
        let chuoi = "6175551212"
        for char in chuoi {
            let asc = Int("\(char)")
            input.onNext(asc!) }
       
        
        input.onNext(9)
        
        
    }

}
