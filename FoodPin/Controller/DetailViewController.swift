//
//  ImageTableViewController.swift
//  SlideImage
//
//  Created by 羅壽之 on 2020/12/17.
//

import UIKit
import CoreData

class DetailViewController: UITableViewController {
    
    @IBOutlet var placeTitle: UILabel!
    @IBOutlet var pageIndicator: UIPageControl!

    var restaurant = Restaurant()

    override func viewDidLoad() {
        super.viewDidLoad()
        placeTitle.text = restaurant.name
        pageIndicator.numberOfPages = Int(restaurant.photoCount)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
   
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "datacell", for: indexPath)
    
        cell.textLabel?.text = restaurant.summary
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPager"{
            let des = segue.destination as! PageViewController
            des.restaurant = restaurant
            des.indexDelegate = self
        }
        if segue.identifier == "showWeather"{
            let des = segue.destination as! WeatherViewController
            des.restaurant = restaurant
        }
        if segue.identifier == "showMap" {
            let des = segue.destination as! MapViewController
            des.restaurant = restaurant
        }
    }
  
}



extension DetailViewController: PageIndexDelegate{
    func didUpdatePageIndex(currentIndex: Int) {
        pageIndicator.currentPage = currentIndex
    }
    
    
}
