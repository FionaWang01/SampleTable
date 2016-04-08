//
//  DetailViewController.swift
//  SampleTable
//
//  Created by babykang on 16/4/7.
//  Copyright © 2016年 babykang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var restaurant:Restaurant!
    @IBOutlet weak var resturantImageView: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    var resturantImage : UIImage?
    
//    @IBAction func close (segue:UIStoryboardSegue){
//        
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.resturantImageView.image = UIImage(named: restaurant.image)
        
        self.tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue:
            240.0/255.0, alpha: 0.2)
        
        self.tableView.tableFooterView = UIView(frame:
            CGRectZero)
        
        self.tableView.separatorColor = UIColor(red:
            240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0,
                         alpha: 0.8)
        self.navigationController?.navigationBar.barTintColor = UIColor(red:
            231.0/255.0, green: 95.0/255.0, blue: 53.0/255.0, alpha: 0.3)
        if let barFont = UIFont(name: "AvenirNextCondensed-DemiBold",
                                size: 22.0) {
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor(),NSFontAttributeName:barFont]
            
//            self.tableView.estimatedRowHeight = 36.0   P190
//            self.tableView.rowHeight = UITableViewAutomaticDime
        }
        
        self.navigationController?.navigationBar.tintColor =
            UIColor.whiteColor()

      self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain,
                                                                target: nil, action: nil)
        
        title = self.restaurant.name
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 235.0/255.0, green: 73.0/255.0, blue:
            27.0/255.0, alpha: 1.0)
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 235.0/255.0, green: 73.0/255.0, blue:
            27.0/255.0, alpha: 1.0)

        self.navigationController?.toolbar.barTintColor = UIColor(red: 237.0/255.0, green: 240.0/255.0, blue:
            243.0/255.0, alpha: 0.5)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)

    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    

}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("detailCell", forIndexPath: indexPath) as! DetailTableViewCell
        
        switch indexPath.row{
        case 0 :
            cell.FieldLabel.text = "Name"
            cell.valueLabel.text = restaurant.name
        case 1 :
            cell.FieldLabel.text = "Loca"
            cell.valueLabel.text = restaurant.location
        case 2 :
            cell.FieldLabel.text = "Type"
            cell.valueLabel.text = restaurant.type
        case 3 :
            cell.FieldLabel.text = "Here"
            cell.valueLabel.text  = (restaurant.isVisited) ? "I had visited " : "I have not been there"
        default :
            print("not find item.")
        }
        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }

}