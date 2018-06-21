//
//  Chap5ViewController.swift
//  RxSwift-Framgia
//
//  Created by nguyen.van.bao on 14/06/2018.
//  Copyright © 2018 nguyen.van.bao. All rights reserved.
//

import UIKit
import RxSwift
class Chap5ViewController: UIViewController {
    var searchResult = PublishSubject<Int>()
    let disposebag = DisposeBag()
    @IBOutlet weak var searchBar: UISearchBar!
    let contacts = [            "111-111-1111": "Florent",
                                "222-222-2222": "Junior",
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
 
    }
    

    
    func searchSubject() {
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
        searchResult
            .skipWhile { $0 == 0 }
            .filter { $0 < 10 }
            .take(10)
            .toArray()
            .subscribe(onNext: {
                let phone = phoneNumber(from: $0)
                
                if let contact = self.contacts[phone] {
                    print("Dialing \(contact) (\(phone))...")
                } else {
                    print("Contact not found \(phone)")
                }
            }, onCompleted: {
                print("completed")
                self.searchSubject()
            })
            .disposed(by: disposebag)
    }
    
    
    func fathMap() {
        struct Student {
            var score: Variable<Int>
        }
        let ryan = Student(score: Variable(80))
     //   let charlotte = Student(score: Variable(90))
        // 2
        let student = PublishSubject<Student>()
        // 3
        student.asObservable()
            .flatMap {
                $0.score.asObservable()
            }
            // 4
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: self.disposebag)
        student.onNext(ryan)
        ryan.score.value = 111
        student.onNext(ryan)
    }
}

extension Chap5ViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        let result = searchBar.text

        guard let arrResult = result else {
            return
        }
        if arrResult.count == 10 {
            for char in arrResult {
                
                guard let asc = Int("\(char)")else {
                    
                    return
                }
                searchResult.onNext(asc) }
        } else {
           print("!number")
        }

    }
    
    func chap7baitap() {
        
        let convert: (String) -> UInt? = { value in
            if let number = UInt(value),
                number < 10 {
                return number
            }
            let convert: [String: UInt] = [
                "abc": 2, "def": 3, "ghi": 4,
                "jkl": 5, "mno": 6, "pqrs": 7,
                "tuv": 8, "wxyz": 9
            ]
            var converted: UInt? = nil
            convert.keys.forEach {
                if $0.contains(value.lowercased()) {
                    converted = convert[$0]
                }
            }
            return converted
        }
        let test = convert("11")
        print(test)
        Observable.of(1, 2, nil, 3)
            .flatMap { $0 == nil ? Observable.empty() : Observable.just($0!) }
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposebag)
      
    }
}
