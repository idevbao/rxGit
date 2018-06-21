//
//  photoViewController.swift
//  RxSwift-Framgia
//
//  Created by nguyen.van.bao on 13/06/2018.
//  Copyright © 2018 nguyen.van.bao. All rights reserved.
//

import UIKit
import RxSwift
import Photos
class photoViewController: UIViewController {
    
    @IBOutlet weak var collectionViewPhotos: UICollectionView!
    fileprivate let selectedPhotosSubject = PublishSubject<UIImage>()
    
    private lazy var photos = photoViewController.loadPhotos()
    private lazy var imageManager = PHCachingImageManager()
    private lazy var thumbnailSize: CGSize = {
        let cellSize = (self.collectionViewPhotos.collectionViewLayout as! UICollectionViewFlowLayout).itemSize
        return CGSize(width: cellSize.width * UIScreen.main.scale,
                      height: cellSize.height * UIScreen.main.scale)
    }()
    var selectedPhotos : Observable<UIImage>{
        return selectedPhotosSubject.asObserver()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionViewPhotos.delegate = self
        self.collectionViewPhotos.dataSource = self

    }
    static func loadPhotos() -> PHFetchResult<PHAsset> {
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        return PHAsset.fetchAssets(with: allPhotosOptions)
    }
}

extension photoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let asset = photos.object(at: indexPath.item)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? Cell else {
            return UICollectionViewCell()
        }
        cell.representedAssetIdentifier = asset.localIdentifier
        imageManager.requestImage(for: asset, targetSize: thumbnailSize, contentMode: .aspectFill, options: nil, resultHandler: { image, _ in
            if cell.representedAssetIdentifier == asset.localIdentifier {
                cell.imgCell.image = image
                print("1")
            }
        })
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        
    }
    
    
}
