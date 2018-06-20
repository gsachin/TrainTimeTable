//
//  ViewController.swift
//  Assignment1
//
//  Created by Sachin Gupta on 5/12/18.
//  Copyright © 2018 Sachin Gupta. All rights reserved.
//

import UIKit
import SWXMLHash
import CoreLocation
public typealias SuccessHandler = (AnyObject?) -> Void
public typealias FailureHandler = (URLResponse?, AnyObject?, Error?) -> Void

class StationViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate,UITableViewDataSource {
    var stationList:StationList
    var filterStationList:[Station]
    var stationDataByCode:StationDataByCode
    var userLocation = CLLocation()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
   
    public required init?(coder aDecoder: NSCoder) {
        stationList = StationList()
        stationDataByCode = StationDataByCode()
        filterStationList = [Station]()
        super.init(coder: aDecoder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        filterStationList = [Station]()
        let sv = UIViewController.displaySpinner(onView: self.view)
        stationList.requestTheServer(success: { (response) in
        self.stationList.parse(response: response)
        print(self.stationList.stationItems)
        self.filterStationList = self.stationList.stationItems
        self.tableView.reloadData()
           UIViewController.removeSpinner(spinner: sv)
        }, failure: { (response, object, error) in
            UIViewController.removeSpinner(spinner: sv)
            self.alert(message:"Getting error while trying to fetch the Station details. please try after some time.", title: "Error")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.filterStationList.count
    }
   
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
            let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "StationCell")
            cell.textLabel?.text =  self.filterStationList[indexPath.row].name
        
        return cell
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.isEmpty) {
            self.filterStationList = self.stationList.stationItems
        }else{
            let searchTextinLowercase = searchText.lowercased()
            self.filterStationList = self.stationList.stationItems.filter { (station) -> Bool in
            return station.name.lowercased().contains(searchTextinLowercase)
        }
        }
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "StationDataSegu", sender: indexPath)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StationDataSegu" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! StationDataViewController
                controller.station = self.filterStationList[indexPath.row]
            }
        }
    }

}

