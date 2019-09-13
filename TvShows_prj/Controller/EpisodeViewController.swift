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
            if let image = epNumber.image?.medium { loadImage(site: image) } else {cell.episodeImage.image = UIImage(named: "noPic")}
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ShowsDetailViewController") as! ShowsDetailViewController
        vc.epDetail = episodes[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        guard let epVC = segue.destination as? ShowsDetailViewController
//            else { fatalError("Unexpected segue")}
//        guard let selectedIndexPath = episodeTableViewOutlet.indexPathForSelectedRow
//            else { fatalError("No row selected")}
//
//        epVC.epDetail = episodes[selectedIndexPath.row]
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let segueIdentifier = segue.identifier else { fatalError("No identifier in segue") }
//
//        switch segueIdentifier {
//        case "episodeSegue" :
//            guard let epVC = segue.destination as? ShowsDetailViewController else {
//                fatalError("Unexpected segue VC")
//            }
//            guard let selectedIndexPath = episodeTableViewOutlet.indexPathForSelectedRow else {
//                fatalError("No row was selected")
//            }
//            epVC.epDetail = episodes[selectedIndexPath.row]
//        default:
//            fatalError("Unexpected segue identifier")
//        }
//    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        episodeTableViewOutlet.dataSource = self
        episodeTableViewOutlet.delegate = self
        loadData()
        // Do any additional setup after loading the view.
    }
}
