//
//  JobTableViewCell.swift
//  ReinClient
//
//  Created by Alex on 3/18/17.
//  Copyright © 2017 ads2alpha. All rights reserved.
//

import UIKit

class JobTableViewCell: UITableViewCell {

    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var jobPoster: UILabel!
    
    var job: Job? {
        didSet {
            setCellContents()
        }
    }
    
    private func setCellContents() {
        jobTitle.text = job?.name
        jobTitle.font = UIFont(name: "OpenSans-Bold", size: 18)
        jobPoster.text = job?.creator
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
