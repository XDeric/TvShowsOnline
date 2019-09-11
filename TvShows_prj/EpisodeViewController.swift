//
//  EpisodeViewController.swift
//  TvShows_prj
//
//  Created by EricM on 9/10/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var episodeTableViewOutlet: UITableView!
    var epInfo: TVShows!
    var episodes = [SeasonEpisodes](){
        didSet {
            episodeTableViewOutlet.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let epNumber = episodes[indexPath.row]
        if let cell = episodeTableViewOutlet.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as? EpisodeTableViewCell {
            
            func loadImage(site: String){
                let urlStr = site
                guard let url = URL(string: urlStr) else{return}
                DispatchQueue.global(qos: .userInitiated).async {
                    do {
                        let data = try Data(contentsOf: url)
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            cell.episodeImage.image = image
                        }
                    } catch {
                        fatalError()
                    }
                }
            }
            loadImage(site: epNumber.image?.medium ?? "no image")
            cell.episodeName1Label.text = epNumber.name
            cell.episodeSeason1Label.text = "Season: \(epNumber.season) Episode: \(epNumber.number)"
            
        }
        return UITableViewCell()
    }
    
    private func loadData() {
        NetworkManager.shared.getEpisode(tvShow: epInfo!.id){ (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let epFromOnline):
                    self.episodes = epFromOnline
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        episodeTableViewOutlet.dataSource = self
        episodeTableViewOutlet.delegate = self
        loadData()
        // Do any additional setup after loading the view.
    }
}
