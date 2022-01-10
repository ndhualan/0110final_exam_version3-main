//
//  PageViewController.swift
//  SlideImage
//
//  Created by 羅壽之 on 2020/12/17.
//

import UIKit
import CoreData

protocol PageIndexDelegate: AnyObject {
    func didUpdatePageIndex(currentIndex: Int)
}

class PageViewController: UIPageViewController {
    
    var restaurant = Restaurant()
    var photoSet : [String?] = [nil, nil, nil]
//    var photoDataSet : [Data?] = [nil, nil, nil]
    var currentIndex = 0
    
    weak var indexDelegate: PageIndexDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // copy the image paths to the photoSet array
        photoSet[0] = restaurant.image1
        photoSet[1] = restaurant.image2
        photoSet[2] = restaurant.image3
        
//        if (photoSet[0] == nil && photoSet[1] == nil && photoSet[2] == nil){
//            photoDataSet[0] = restaurant.imageData1
//            photoDataSet[1] = restaurant.imageData2
//            photoDataSet[2] = restaurant.imageData3
//        }
        // Set the data source and delegate to itself
        dataSource = self
        delegate = self
        
        
        // Create the first image content screen
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
        
    }
    
    func contentViewController(at index: Int) -> ContentViewController? {
        if index < 0 || index >= restaurant.photoCount {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        if let pageContentViewController = storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as? ContentViewController {
            
            pageContentViewController.imageName = photoSet[index]!
//            pageContentViewController.imgData = photoDataSet[index]!
            pageContentViewController.index = index
            
            return pageContentViewController
        }
        
        return nil
    }
    
    // triggered by the next button
    func forwardPage() {
        currentIndex += 1
        if let nextViewController = contentViewController(at: currentIndex) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
}


// MARK: - UIPageViewControllerDataSource methods

extension PageViewController: UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        //get the current page index
        var index = (viewController as! ContentViewController).index
        index -= 1   // get the previous page index
        
        return contentViewController(at: index)  //Create a contentViewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! ContentViewController).index
        index += 1
        
        return contentViewController(at: index)
    }
    
    
    
}


// MARK: - UIPageViewControllerDelegate methods

extension PageViewController: UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed {
            if let contentViewController = pageViewController.viewControllers?.first as? ContentViewController {
                
                currentIndex = contentViewController.index
                
                indexDelegate?.didUpdatePageIndex(currentIndex: currentIndex)
            }
            
        }
        
    }
}
