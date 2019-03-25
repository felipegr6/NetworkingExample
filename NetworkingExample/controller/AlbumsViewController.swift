//
//  AlbumViewController.swift
//  NetworkingExample
//
//  Created by LOWCOST on 25/03/2019.
//  Copyright © 2019 PagSeguro. All rights reserved.
//

import UIKit

class AlbumsViewController: UIViewController {
    
    var albums: [Album] = [] {
        didSet {
            albumsTable?.reloadData()
        }
    }
    
    @IBOutlet weak var albumsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumsTable.register(
            UINib(nibName: "AlbumTableViewCell", bundle: nil),
            forCellReuseIdentifier: "albumCell"
        )
        
        albumsTable.delegate = self
        albumsTable.dataSource = self
        
        Album.getAlbums { [weak self] albums, error in
            self?.albums = albums
            
            for a in albums {
                print(a.title)
                print("***")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        
        if identifier == "goToAlbum" {
            let detailVC = segue.destination as? AlbumDetailViewController
            detailVC?.album = sender as? Album
        }
    }
}

extension AlbumsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = albumsTable.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as! AlbumTableViewCell
        
        cell.lblAlbumTitle.text = albums[indexPath.row].title
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToAlbum", sender: albums[indexPath.row])
    }
}
