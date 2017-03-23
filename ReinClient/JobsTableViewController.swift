//
//  JobsTableViewController.swift
//  ReinClient
//
//  Created by Alex on 3/7/17.
//  Copyright © 2017 ads2alpha. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

class JobsTableViewController: UITableViewController {
    
    // MARK: - Model
    
    var user: User? {
        didSet {
            loadJobs()
        }
    }
    
    var jobs = Array<Array<Job>>() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private struct JobKeys {
        static let id = "_id"
        static let name = "name"
        static let details = "details"
        static let creator = "creator"
        static let creatorContact = "creatorContact"
        static let mediator = "mediator"
        static let mediatorContact = "mediatorContact"
        static let tags = "tags"
        static let expiresAt = "expiresAt"
    }
    
    private func loadJobs() {
        user!.getAllJobs {
            [weak weakSelf = self] data, error in
            var jobsFromAPI = [Job]()
            let jsonResult = (JSON(data!).dictionaryObject! as [String: Any])
            let jsonJobs = jsonResult["jobs"] as! [Any]
            for jsonJob in jsonJobs {
                let job = Job()
                let mutableJsonJob = (jsonJob as! [String: Any])
                // TODO - Create a struct with all the keys
                job.id = mutableJsonJob[JobKeys.id] as! String
                job.name = mutableJsonJob[JobKeys.name] as! String
                job.details = mutableJsonJob[JobKeys.details] as! String
                job.creator = mutableJsonJob[JobKeys.creator] as! String
                job.creatorContact = mutableJsonJob[JobKeys.creatorContact] as! String
                job.mediator = mutableJsonJob[JobKeys.mediator] as! String
                job.mediatorContact = mutableJsonJob[JobKeys.mediatorContact] as! String
                for jsonTag in (mutableJsonJob[JobKeys.tags] as! String).components(separatedBy: ", ") {
                    let tag = RealmString()
                    tag.value = jsonTag
                    job.tags.append(tag)
                }
                job.expiresAt = mutableJsonJob[JobKeys.expiresAt] as! Int
                jobsFromAPI.append(job)
            }
            weakSelf?.jobs.insert(jobsFromAPI, at: 0)
        }
    }

    
    
    // MARK: - View
    
    private struct Storyboard {
        static let JobCell = "JobTableViewCell"
        static let ShowJobDetails = "ShowJobDetailsSegue"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return jobs.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobs[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.JobCell, for: indexPath)
        
        let job = jobs[indexPath.section][indexPath.row]
        if let jobCell = cell as? JobTableViewCell {
            jobCell.job = job
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let job = jobs[indexPath.section][indexPath.row]
        performSegue(withIdentifier: Storyboard.ShowJobDetails, sender: job)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.ShowJobDetails {
            if let job = sender as? Job {
                if let destination = segue.destination as? JobDetailsViewController {
                    destination.job = job
                }
            }
        }
    }

}
