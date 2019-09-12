//
//  ViewController.swift
//  TvShows_prj
//
//  Created by EricM on 9/10/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import UIKit

class TVShowsViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate{
    var tvShows = [Television]()
    @IBOutlet weak var tvShowsTableViewOutlet: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchString: String? = nil {
        didSet{
            self.tvShowsTableViewOutlet.reloadData()
        }
    }
    
    var tvSearchResults: [Television]{
        guard let _ = searchString else{
            return tvShows
        }
        guard searchString != "" else {
            return tvShows
        }
        let results = tvShows.filter{$0.show.name.lowercased().contains(searchString!.lowercased())}
        return results
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchString = searchBar.text
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchBar.text
        loadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvSearchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tv = tvSearchResults[indexPath.row]
        if let cell = tvShowsTableViewOutlet.dequeueReusableCell(withIdentifier: "tvCell", for: indexPath) as? TVShowsTableViewCell{
            
            func loadImage(site: String){
                let urlStr = site
                guard let url = URL(string: urlStr) else{return}
                DispatchQueue.global(qos: .userInitiated).async {
                    do {
                        let data = try Data(contentsOf: url)
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            cell.tvShowImage.image = image
                        }
                    } catch {
                        fatalError()
                    }
                }
            }
            if let image = tv.show.image?.medium { loadImage(site: image) } else {cell.tvShowImage.image = UIImage(named: "noPic")}
            cell.tvNameLabel.text = tv.show.name
            let test = "No rating"
            if let rating = tv.show.rating?.average { cell.ratingLabel.text = "Rating: \(rating)" } else { cell.ratingLabel.text = test }
            return cell
        }
        return UITableViewCell()
    }
    
    private func loadData() {
        NetworkManager.shared.getTVShow(query: searchString ?? ""){ (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let tvFromOnline):
                    self.tvShows = tvFromOnline
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier != nil else { fatalError("No identifier in segue")
        }
        guard let tvVC = segue.destination as? EpisodeViewController
            else { fatalError("Unexpected segue")}
        guard let selectedIndexPath = tvShowsTableViewOutlet.indexPathForSelectedRow
            else { fatalError("No row selected")}
        tvVC.epInfo = tvShows[selectedIndexPath.row]
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvShowsTableViewOutlet.dataSource = self
        tvShowsTableViewOutlet.delegate = self
        searchBar.delegate = self
        //loadData()
        // Do any additional setup after loading the view.
    }
}

