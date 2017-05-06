//
//  JobDetailsViewController.swift
//  ReinClient
//
//  Created by Alex on 3/7/17.
//  Copyright © 2017 ads2alpha. All rights reserved.
//

import UIKit

class JobDetailsViewController: UITableViewController {
    
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var jobDetails: UILabel!
    @IBOutlet weak var taglist: UILabel!
    @IBOutlet weak var expiresOn: UILabel!
    @IBOutlet weak var employerName: UILabel!
    @IBOutlet weak var employerContact: UILabel!
    @IBOutlet weak var mediatorName: UILabel!
    @IBOutlet weak var mediatorContact: UILabel!
    
    var job: Job?
    
    private func setJobOnUI() {
        jobTitle.text = job?.name
        jobDetails.text = job?.details
        employerName.text = job?.creator
        employerContact.text = job?.creatorContact
        taglist.text = ""
        for tag in (job?.tags)! {
            taglist.text?.append(tag.value + " ")
        }
        mediatorName.text = job?.mediator
        mediatorContact.text = job?.mediatorContact
        expiresOn.text = Date(timeIntervalSince1970: Double((job?.expiresAt)!)).description
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
        setJobOnUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
