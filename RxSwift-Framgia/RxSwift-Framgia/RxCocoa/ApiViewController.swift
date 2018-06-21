//
//  ApiViewController.swift
//  RxSwift-Framgia
//
//  Created by nguyen.van.bao on 20/06/2018.
//  Copyright © 2018 nguyen.van.bao. All rights reserved.
//

import UIKit
import Foundation
import RxCocoa
import RxSwift

struct Weather {
    let cityName: String
    let temperature: Int
    let humidity: Int
    let icon: String
    
    static let empty = Weather(
        cityName: "Unknown",
        temperature: -1000,
        humidity: 0,
        icon: "e"
    )
}
class ApiViewController: NSObject {
    static let shared = ApiViewController()
    func currentWeather(city: String) -> Observable<Weather> {
        // Placeholder call
        return Observable.just(
            Weather(
                cityName: city,
                temperature: 20,
                humidity: 90,
                icon: "01d"
        ))
    }
}
