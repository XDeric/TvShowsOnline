//
//  ShowsDetailViewController.swift
//  TvShows_prj
//
//  Created by EricM on 9/10/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import UIKit

class ShowsDetailViewController: UIViewController {
    var epDetail: SeasonEpisodes!
    @IBOutlet weak var detailImageOutlet: UIImageView!
    @IBOutlet weak var epNameLabel: UILabel!
    @IBOutlet weak var epSeasonLabel: UILabel!
    @IBOutlet weak var summaryText: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage(site: epDetail.image!.medium)
        epNameLabel.text = epDetail.name
        epSeasonLabel.text = "Season: \(epDetail.season) Episode: \(epDetail.number)"
        summaryText.text = epDetail.summary

        // Do any additional setup after loading the view.
    }
    
    func loadImage(site: String){
        let urlStr = site
        guard let url = URL(string: urlStr) else{return}
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.detailImageOutlet.image = image
                }
            } catch {
                fatalError()
            }
        }
    }
}
