//
//  ApiRxViewController.swift
//  RxSwift-Framgia
//
//  Created by nguyen.van.bao on 20/06/2018.
//  Copyright © 2018 nguyen.van.bao. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class ApiRxViewController: UIViewController {
    let bag = DisposeBag()
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        ApiViewController.shared.currentWeather(city: "RxSwift")
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { data in
                self.tempLabel.text = "\(data.temperature)° C"
                //   self.iconLabel.text = data.icon
                self.humidityLabel.text = "\(data.humidity)%"
                self.cityNameLabel.text = data.cityName
            }).disposed(by: bag)
    }
}
