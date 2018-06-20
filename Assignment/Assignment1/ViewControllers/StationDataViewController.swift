//
//  StationDataViewController.swift
//  Assignment1
//
//  Created by Sachin Gupta on 5/13/18.
//  Copyright © 2018 Sachin Gupta. All rights reserved.
//
import UIKit
import SWXMLHash
import CoreLocation
class StationDataViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate,UITableViewDataSource
{
    var station: Station?
    var filterStationDataList:[StationData]
    var stationDataByCode:StationDataByCode
    @IBOutlet weak var tableView: UITableView!
    
    public required init?(coder aDecoder: NSCoder) {
        
        stationDataByCode = StationDataByCode()
        filterStationDataList = [StationData]()
        
        super.init(coder: aDecoder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        filterStationDataList = [StationData]()
       // tableView.register(StationDataCellTableViewCell.self, forCellReuseIdentifier: "StationDataCellTableViewCell")
        //tableView.register(UINib(nibName: "StationDataCellTableViewCell", bundle: nil), forCellReuseIdentifier: "StationDataCellTableViewCell")
        self.title = station?.name
        if let stationcode =  station?.code {
            print("statin code - \(stationcode)")
            stationDataByCode.code = stationcode
             let sv = UIViewController.displaySpinner(onView: self.view)
            stationDataByCode.requestTheServer(success: { (response) in
                    self.stationDataByCode.parse(response: response)
                    self.filterStationDataList = self.stationDataByCode.stationDataItems
                if self.filterStationDataList.count > 0 {
                    self.tableView.reloadData()
                }else{
                    self.alert(message:"No train available at the moment please try after some time." , title: "Message")
                }
                UIViewController.removeSpinner(spinner: sv)
                
                }, failure: { (response, object, error) in
                    UIViewController.removeSpinner(spinner: sv)
                    self.alert(message: "Getting error while trying to fetch the train details. please try after some time.", title: "Error" )
                })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.filterStationDataList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
       
        let cell = (tableView.dequeueReusableCell(withIdentifier: "StationDataCellTableViewCell", for: indexPath) as? StationDataCellTableViewCell)!
        let station = self.filterStationDataList[indexPath.row]
        if let dest = station.destination{
        cell.name.text = dest
        }
        if let type = station.trainType{
           cell.desc.text = type
        }
        
        if station.queryTime != nil &&  station.schreduleDeparture != nil {
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let queryTime = dateFormatter.date(from:station.queryTime!)
            
            dateFormatter.dateFormat = "HH:mm"
            let departure = dateFormatter.date(from:station.schreduleDeparture!)
            
            let diff = Calendar.current.dateComponents([.hour, .minute], from: queryTime!, to: departure!)
            let formattedString = "\(diff.hour! * 60 + diff.minute!)"
            
            cell.time.text = formattedString
        }
        
        return cell
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.isEmpty) {
            self.filterStationDataList = self.stationDataByCode.stationDataItems
        }else{
            let searchTextinLowercase = searchText.lowercased()
            self.filterStationDataList = self.stationDataByCode.stationDataItems.filter { (station) -> Bool in
                return (station.destination?.lowercased().contains(searchTextinLowercase))!
            }
        }
        tableView.reloadData()
    }
}

