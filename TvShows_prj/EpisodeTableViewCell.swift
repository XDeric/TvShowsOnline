//
//  EpisodeTableViewCell.swift
//  TvShows_prj
//
//  Created by EricM on 9/10/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {
    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var episodeName1Label: UILabel!
    @IBOutlet weak var episodeSeason1Label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
