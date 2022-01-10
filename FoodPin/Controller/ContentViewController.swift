//
//  ImageContentViewController.swift
//  SlideImage
//
//  Created by 羅壽之 on 2020/12/17.
//

import UIKit
import CoreData

class ContentViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var index = 0
    var imageName: String = ""
//    var imgData: Data!
    override func viewDidLoad() {
        super.viewDidLoad()
        //if (imageName != ""){
            imageView.image = UIImage(named: imageName)
        //}
//        else{
//            imageView.image = UIImage(data: imgData)
//        }
        
    }
    
}
