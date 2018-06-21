//
//  Chap8ViewController.swift
//  RxSwift-Framgia
//
//  Created by nguyen.van.bao on 18/06/2018.
//  Copyright © 2018 nguyen.van.bao. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher
func cachedFileURL(_ fileName: String) -> URL {
    return FileManager.default
        .urls(for: .cachesDirectory, in: .allDomainsMask)
        .first!
        .appendingPathComponent(fileName)
}

class Chap8ViewController: UIViewController {
    let repo = "ReactiveX/RxSwift"
    
    fileprivate let events = Variable<[Events]>([])
    fileprivate let bag = DisposeBag()
    fileprivate let lastModified = Variable<NSString?>(nil)
    private let eventsFileURL = cachedFileURL("events.plist")
     private let modifiedFileURL = cachedFileURL("modified.txt")
    var refreshControl = UIRefreshControl()
    @IBOutlet weak var tableviewChap8: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableviewChap8.delegate = self
        self.tableviewChap8.addSubview(refreshControl)
        refreshControl.backgroundColor = UIColor(white: 0.98, alpha: 1.0)
        refreshControl.tintColor = UIColor.darkGray
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        let cellCustom = UINib(nibName: "cell", bundle: nil)
        self.tableviewChap8.register(cellCustom, forCellReuseIdentifier: "cell")
        self.tableviewChap8.dataSource =  self
        let eventsArray = (NSArray(contentsOf: eventsFileURL)
            as? [[String: Any]]) ?? []
        events.value = eventsArray.flatMap(Events.init)
        
        lastModified.value = try? NSString(contentsOf: modifiedFileURL, usedEncoding: nil)

        refresh()
    }
}

extension Chap8ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return events.value.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableviewChap8.dequeueReusableCell(withIdentifier: "cell") as? cell else {
            return UITableViewCell()
        }
        let event = events.value[indexPath.row]
        
        cell.textLabel?.text = event.name
        cell.detailTextLabel?.text = event.repo + ", " + event.action.replacingOccurrences(of: "Event", with: "").lowercased()
        cell.imageView?.kf.setImage(with: event.imageUrl, placeholder: UIImage(named: "blank-avatar"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.size.height/5
    }
    
    @objc func refresh() {
        fetchEvents(repo: repo)
    }
    
    func fetchEvents(repo: String) {
        let response = Observable.from([repo])
            // 1. chuyen doi tu string sang url
            .map { urlString -> URL in
                return  URL(string: "https://api.github.com/repos/\(urlString)/events")!
            }
            // 2. chuyen doi tu url sang urlRequest
            .map { [weak self] url -> URLRequest in
                var request = URLRequest(url: url)
                                if let modifiedHeader = self?.lastModified.value {
                                    request.addValue(modifiedHeader as String,
                                                     forHTTPHeaderField: "Last-Modified")
                                }
                return request
            }
            .flatMap { request -> Observable<(response: HTTPURLResponse, data: Data)> in
                return URLSession.shared.rx.response(request: request)
            }
            .shareReplay(1)
        
        
        response
            .filter { response, _ in
                return 200..<300 ~= response.statusCode
            }
            .map { _, data -> [[String: Any]] in
                guard let jsonObject = try? JSONSerialization.jsonObject(with: data,
                                                                         options: []),
                    let result = jsonObject as? [[String: Any]] else {
                        return [] }
                return result
            }
            .filter { objects in
                return objects.count > 0
            }
            .map { objects in
                return objects.map(Events.init)
            }
            .subscribe(onNext: { [weak self] newEvents in
                print(newEvents)
                self?.processEvents(newEvents: newEvents)
            })
            .disposed(by: bag)
        
    }
    
    func processEvents( newEvents: [Events]) {
        var updatedEvents = newEvents + events.value
        if updatedEvents.count > 50 {
            updatedEvents = Array<Events>(updatedEvents.prefix(upTo: 50))
        }
        events.value = updatedEvents
        DispatchQueue.main.async {
            self.tableviewChap8.reloadData()
            self.refreshControl.endRefreshing()
        }
        let eventsArray = updatedEvents.map{ $0.dictionary } as NSArray
        eventsArray.write(to: eventsFileURL, atomically: true)
    }
}
