//
//  CustomUITableViewController.swift
//  SearchViewTest
//
//  Created by William Kinaan on 10/09/15.
//  Copyright © 2015 William Kinaan. All rights reserved.
//

import UIKit

class CustomUITableViewController: UITableViewController, UISearchResultsUpdating {
    let players = ["Totti", "Pirlo", "Nesta", "Buffon"]
    var filteredPlayers = [String]()
    var searchController: UISearchController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController = UISearchController(searchResultsController: nil)
        searchController!.searchResultsUpdater = self
        searchController!.searchBar.sizeToFit()
        self.tableView.tableHeaderView = searchController!.searchBar
    }
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if (self.searchController!.active && !self.searchController!.searchBar.text!.isEmpty) {
            let query = NSPredicate(format: "SELF CONTAINS [c] %@", self.searchController!.searchBar.text!)
            let results = (players as NSArray).filteredArrayUsingPredicate(query)
            filteredPlayers = results as! [String]
        }
        self.tableView.reloadData()
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController!.searchBar.text!.isEmpty{
            return players.count
        }
        if searchController!.active{
            return filteredPlayers.count
        }else{
            return players.count
        }
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        if searchController!.searchBar.text!.isEmpty{
           cell.textLabel!.text = players[indexPath.row]
        }else{
            if self.searchController!.active{
                cell.textLabel!.text = filteredPlayers[indexPath.row]
            }else{
                cell.textLabel!.text = players[indexPath.row]
            }
        }
        return cell;
    }
}
