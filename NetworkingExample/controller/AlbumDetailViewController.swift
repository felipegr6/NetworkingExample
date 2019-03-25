//
//  AlbumDetailViewController.swift
//  NetworkingExample
//
//  Created by LOWCOST on 25/03/2019.
//  Copyright © 2019 PagSeguro. All rights reserved.
//

import UIKit
import Kingfisher

class AlbumDetailViewController: UIViewController {
    
    var album: Album?
    var photos: [Photo] = [] {
        didSet {
            photosCollectionView?.reloadData()
        }
    }
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = album?.title ?? "No Value"
        
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        
        photosCollectionView.register(
            UINib(nibName: "PhotoCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "photoCell"
        )
        
        Photo.getAlbumPhotos(album?.id ?? 0) { [weak self] (photos, error) in
            for p in photos {
                print(p.thumbnailUrl)
            }
            
            self?.photos = photos
        }
    }
}

extension AlbumDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photosCollectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionViewCell
        
        let photo = photos[indexPath.row]
        
        if let urlString = photo.thumbnailUrl, let url = URL(string: urlString) {
            cell.ivPhoto.kf.setImage(with: url)
        }
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
