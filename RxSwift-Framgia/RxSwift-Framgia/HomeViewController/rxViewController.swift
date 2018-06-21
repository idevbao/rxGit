//
//  rxViewController.swift
//  RxSwift-Framgia
//
//  Created by nguyen.van.bao on 12/06/2018.
//  Copyright © 2018 nguyen.van.bao. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class rxViewController: UIViewController {
    
    @IBOutlet weak private var preview: UIImageView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var addButton: UIButton!
    private let bag = DisposeBag()
    private let images = Variable<[UIImage]>([])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        images.asObservable()
            .subscribe(onNext: { [weak self] photos in
                guard let previewIMG = self?.preview else { return }
                previewIMG.image = UIImage.collage(images: photos, size: previewIMG.frame.size)
            })
            .disposed(by: bag)
        images.asObservable()
            .subscribe(onNext: { [weak self] photos in
               self?.updateUI(photos: photos)
            })
            .disposed(by: bag)
    }
    @IBAction func actionAdd(_ sender: Any) {
        images.value.append(UIImage(named: "rx.png")!)
        let photosViewController = storyboard!.instantiateViewController(
            withIdentifier: "PhotosViewController") as! photoViewController
        self.navigationController?.pushViewController(photosViewController, animated: false)
    }
    
    @IBAction func acctionClear(_ sender: Any) {
        images.value = []
    }
    private func updateUI(photos:[UIImage]){
       
        clearButton.isEnabled = photos.count > 0
    
        
    }
}
