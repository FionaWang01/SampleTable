//
//  ViewController.swift
//  SampleTable
//
//  Created by babykang on 16/4/7.
//  Copyright © 2016年 babykang. All rights reserved.
//

import UIKit
import Foundation
import CoreData

protocol viewController: UISearchResultsUpdating,NSFetchedResultsControllerDelegate {
     func filterContensFromSearchbar (searchText: String)
    func updateSearchResultFromSearchController(searchController: UISearchController)
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var searchController: UISearchController!
    var searchResault : [Restaurant] = []
    

    var restaurants:[Restaurant] = [
        Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "Hong Kong",
            image: "cafedeadend.jpg", isVisited: false),
        Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Hong Kong",
            image: "cafeloisl.jpg", isVisited: false),
       
        Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Hong Kong", image:
            "forkeerestaurant.jpg", isVisited: false),
        Restaurant(name: "Po's Atelier", type: "Bakery", location: "Hong Kong", image:
            "posatelier.jpg", isVisited: false),
        Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "Sydney", image:
            "bourkestreetbakery.jpg", isVisited: false),
        Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "NewYork", image: "grahamavenuemeats.jpg", isVisited: false),
        Restaurant(name: "Cafe Lore", type: "Latin American", location: "New York", image:
                "cafelore.jpg", isVisited: false),
        Restaurant(name: "Confessional", type: "Spanish", location: "New York", image:
                "confessional.jpg", isVisited: false),
        Restaurant(name: "Barrafina", type: "Spanish", location: "London", image:
                "barrafina.jpg", isVisited: false),
        Restaurant(name: "Donostia", type: "Spanish", location: "London", image:
                "donostia.jpg", isVisited: false),
        Restaurant(name: "Royal Oak", type: "British", location: "London", image:
                "royaloak.jpg", isVisited: false)]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(red:
            231.0/255.0, green: 95.0/255.0, blue: 53.0/255.0, alpha: 0.3)
        if let barFont = UIFont(name: "AvenirNextCondensed-DemiBold",
                                size: 22.0) {
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor(),
                 NSFontAttributeName:barFont]
        }
        
        self.navigationItem.title = "FOOD POD"
        self.navigationController?.navigationBar.tintColor =
            UIColor.whiteColor()
        
        // searchbar
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        
        definesPresentationContext = true
        
        //searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = UIColor.grayColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showRestaurantDetail"{
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let destinationController = segue.destinationViewController as! DetailViewController
                destinationController.restaurant = (searchController.active) ? searchResault[indexPath.row] : restaurants [indexPath.row]
            }
        }
    }
    
    func filterContensFromSearchbar (searchText: String){
        searchResault = restaurants.filter({(restaurant: Restaurant)-> Bool in
            let nameMatch = restaurant.name.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return nameMatch != nil
        })
    }
    
    func updateSearchResultFromSearchController(searchController: UISearchController){
        let searchText = searchController.searchBar.text
        filterContensFromSearchbar(searchText!)
        tableView.reloadData()
    }
    

    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.active{
            return searchResault.count
        }else{
        return restaurants.count
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return  110.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let imageItem = cell.viewWithTag(1000) as! UIImageView
        let textItem = cell.viewWithTag(2000) as! UILabel
        let locationItem = cell.viewWithTag(3000) as! UILabel
        let typeItem = cell.viewWithTag(4000) as! UILabel
        
        if searchController.active{
            imageItem.image = UIImage(named:searchResault[indexPath.row].image)
            textItem.text = searchResault[indexPath.row].name
            locationItem.text = searchResault[indexPath.row].location
            typeItem.text = searchResault[indexPath.row].type
        }else{
        imageItem.image = UIImage(named:restaurants[indexPath.row].image)
        textItem.text = restaurants[indexPath.row].name
        locationItem.text = restaurants[indexPath.row].location
        typeItem.text = restaurants[indexPath.row].type
        }
        imageItem.layer.cornerRadius = imageItem.frame.size.width / 2
        imageItem.clipsToBounds = true
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let alert = UIAlertController(title: "What do you want to do ?", message: nil, preferredStyle: .ActionSheet)
        let numberAction = UIAlertAction(title: "Call"+"123-000-\(indexPath.row)", style: .Default, handler: {(action:UIAlertAction)-> Void in
             let alertInside = UIAlertController(title: "Warring", message: "The Phone you called is busy ,please try later!?", preferredStyle: .Alert)
             let alertAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alertInside.addAction(alertAction)
            self.presentViewController(alertInside, animated: true, completion: nil)
        })
        let isVisitedAction = UIAlertAction(title: "I am here!", style: .Default, handler: {(action:UIAlertAction)-> Void in
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            cell?.accessoryType = .Checkmark
        })
        
        let cancellAction = UIAlertAction(title: "Cancell", style: .Cancel, handler: nil)
        alert.addAction(numberAction)
        alert.addAction(isVisitedAction)
        alert.addAction(cancellAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete{
//            self.restaurantImage.removeAtIndex(indexPath.row)
//            self.restaurantNames.removeAtIndex(indexPath.row)
//            
//            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//            
//            self.tableView.reloadData()
//            
//       }
//    }
   
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let shareController = UITableViewRowAction(style: .Default, title: "Shera", handler: {(action:UITableViewRowAction, indexPath: NSIndexPath)->Void in
             let actionSheet = UIAlertController(title: "For Share", message: nil, preferredStyle: .ActionSheet)
            let twitter = UIAlertAction(title: "twitter", style: .Default, handler: nil)
            let facebook = UIAlertAction(title: "facebook", style: .Default, handler: nil)
            let email = UIAlertAction(title: "Email", style: .Default, handler: nil)
            let cancell = UIAlertAction(title: "cancell", style: .Cancel, handler: nil)
            actionSheet.addAction(twitter)
            actionSheet.addAction(facebook)
            actionSheet.addAction(email)
            actionSheet.addAction(cancell)
            self.presentViewController(actionSheet, animated: true, completion: nil)
        })
        
        let deleteController = UITableViewRowAction(style: .Default, title: "Delate", handler: {(action:UITableViewRowAction, indexPath:NSIndexPath)-> Void in
            
                self.restaurants.removeAtIndex(indexPath.row)
            
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                
                self.tableView.reloadData()

        })
        
        shareController.backgroundColor = UIColor(red: 255.0/255.0, green: 166.0/255.0, blue:
            51.0/255.0, alpha: 1.0)  //黄色
        deleteController.backgroundColor = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue:
            51.0/255.0, alpha: 1.0)  //黑色
        return [shareController, deleteController]
    }
    
    // searchController
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if searchController.active{
            return false
        }else{
            return true
        }
    }
    
}

