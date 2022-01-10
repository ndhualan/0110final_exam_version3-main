//
//  Restaurant.swift
//  FoodPin
//
//  Created by NDHU_CSIE on 2021/11/8.
//

import Foundation
import CoreData
import UIKit


// The Restaurant class is required for modeling core data objects

public class Restaurant: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Restaurant> {
        return NSFetchRequest<Restaurant>(entityName: "Restaurant")
    }

    @NSManaged public var name: String
    //@NSManaged public var type: String
    //@NSManaged public var location: String
    //@NSManaged public var phone: String
    @NSManaged public var summary: String
    //@NSManaged public var image: Data
    //@NSManaged public var rating: String?
    @NSManaged public var isFavorite: Bool
    
    @NSManaged public var address: String
    @NSManaged public var city: String
    @NSManaged public var image1: String
    @NSManaged public var image2: String
    @NSManaged public var image3: String
    @NSManaged public var photoCount: Int32
    
//    @NSManaged public var imageData1: Data
//    @NSManaged public var imageData2: Data
//    @NSManaged public var imageData3: Data
    
    // implement one customized managed object constructor
    convenience init(name: String, city: String, address: String, summary: String, photoCount: Int32, image1: String, image2: String, image3: String) {
  
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        // call the original constructor to create one managed object
        self.init(context: appDelegate!.persistentContainer.viewContext)
        // fill the data fields from the passing parameters
        self.name = name
        self.city = city
        self.address = address
        self.summary = summary
        self.photoCount = photoCount
        self.image1 = image1
        self.image2 = image2
        self.image3 = image3
        //self.image = UIImage(named: image)!.pngData()!
    }
    
}


// This structure becomes useless in core data
// The Hashable protocol is needed for Diffable Data Source

//struct RestaurantTM: Hashable {
//    var name: String = ""
//    var type: String = ""
//    var location: String = ""
//    var phone: String = ""
//    var summary: String = ""
//    var image: String = ""
//    var isFavorite: Bool = false
//    var rating: String?
//}


//extend the definition of an existing structure or class

extension Restaurant {
    
    static func generateData() {
        
        // create some managed objects for testing
        _ = [
            Restaurant(name: "Taipei 101", city: "Taipei", address: "Taipei 101, Taipei", summary: "The Taipei 101 (台北101) is a supertall skyscraper designed by C.Y. Lee and C.P. Wang in Xinyi, Taipei, Taiwan. This building was officially classified as the world's tallest from its opening in 2004 until the 2010 completion of the Burj Khalifa in Dubai, UAE.", photoCount: 2, image1: "photo0_0", image2: "photo0_1", image3: ""),
            Restaurant(name: "Taroko National Park", city: "Hualien", address: "Taroko National Park, Hualien, Taiwan", summary: "Taroko National Park (太魯閣國家公園) is one of the nine national parks in Taiwan and was named after the Taroko Gorge, the landmark gorge of the park carved by the Liwu River. The park spans Taichung Municipality, Nantou County, and Hualien County and is located at Xiulin Township, Hualien County, Taiwan.",photoCount: 3, image1: "photo1_0", image2: "photo1_1", image3: "photo1_2"),
            Restaurant(name: "Kenting National Park", city: "Pingtung", address: "Kenting National Park, Taiwan",summary: "Kenting National Park (墾丁國家公園) is a national park located on the Hengchun Peninsula of Pingtung County, Taiwan, covering Hengchun, Checheng, and Manzhou Townships. Established on 1 January 1984, it is Taiwan's oldest and the southernmost national park on the main island, covering the southernmost area of the Taiwan island along Bashi Channel.", photoCount: 2, image1: "photo2_0", image2: "photo2_1", image3: "")
            ]

        //write all managed objects into the database
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        appDelegate.saveContext()

    }
}
