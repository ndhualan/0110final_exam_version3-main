//
//  NewRestaurantController.swift
//  FoodPin
//
//  Created by 羅壽之 on 2021/12/13.
//

import UIKit
import CoreData

class NewRestaurantController: UITableViewController {
    
    var editedRestaurant: Restaurant?
    
    var imgTag = 0
    @IBAction func addImg1(sender: UIButton) {
        imgTag = 1
    }
    @IBAction func addImg2(sender: UIButton) {
        imgTag = 2
    }
    @IBAction func addImg3(sender: UIButton) {
        imgTag = 3
    }
    @IBAction func minImg1(sender: UIButton) {
        imgTag = 0
        photoImageView1.image = UIImage(systemName: "doc.fill")
    }
    @IBAction func minImg2(sender: UIButton) {
        imgTag = 0
        photoImageView2.image = UIImage(systemName: "doc.fill")
    }
    @IBAction func minImg3(sender: UIButton) {
        imgTag = 0
        photoImageView3.image = UIImage(systemName: "doc.fill")
    }
    @IBOutlet var photoImageView1: UIImageView!
    @IBOutlet var photoImageView2: UIImageView!
    @IBOutlet var photoImageView3: UIImageView!
    
    
    @IBOutlet var nameTextField: RoundedTextField! {
        didSet {
            nameTextField.tag = 1
            nameTextField.becomeFirstResponder()
            nameTextField.delegate = self
        }
    }
    @IBOutlet var cityTextField: RoundedTextField! {
        didSet {
            cityTextField.tag = 2
            cityTextField.delegate = self
        }
    }
    @IBOutlet var addressTextField: RoundedTextField! {
        didSet {
            addressTextField.tag = 3
            addressTextField.delegate = self
        }
    }
    @IBOutlet var descriptionTextView: UITextView! {
        didSet {
            descriptionTextView.tag = 4
            descriptionTextView.layer.cornerRadius = 10.0
            descriptionTextView.layer.masksToBounds = true
        }
    }
    //@IBOutlet var photoImageView: UIImageView!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Dismiss keyboard when users tap any blank area of the view
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        // if update data, load the old data first
        if editedRestaurant != nil {
            navigationItem.title = "Update Restaurant"
            loadOldData()
        }
    }

   
    // MARK: - UITableViewDelegate methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 && imgTag != 0 {  // select the first cell contained one image view

            let photoSourceRequestController = UIAlertController(title: "", message: "Choose your photo source", preferredStyle: .actionSheet)

            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .camera
                    imagePicker.delegate = self

                    self.present(imagePicker, animated: true, completion: nil)
                }
            })

            let photoLibraryAction = UIAlertAction(title: "Photo library", style: .default, handler: { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .photoLibrary
                    imagePicker.delegate = self

                    self.present(imagePicker, animated: true, completion: nil)
                }
            })

            photoSourceRequestController.addAction(cameraAction)
            photoSourceRequestController.addAction(photoLibraryAction)

            // For iPad only
            if let popoverController = photoSourceRequestController.popoverPresentationController {
                if let cell = tableView.cellForRow(at: indexPath) {
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                }
            }

            present(photoSourceRequestController, animated: true, completion: nil)

        }
    }
    
    @IBAction func saveButtonTapped(sender: UIButton) {
        //Check empty fields and trigger an alert message
        if nameTextField.text == "" || cityTextField.text == "" || addressTextField.text == ""  || descriptionTextView.text == ""{
            let alertController = UIAlertController(title: "Oops", message: "We can't proceed because one of the fields is blank. Please note that all fields are required.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            
            return
        }
        
        //Create a managed object in the context
        var restaurant: Restaurant
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        if editedRestaurant == nil { //add new data
            restaurant = Restaurant(context: appDelegate.persistentContainer.viewContext)
        }
        else { // edit old data
            restaurant = editedRestaurant!
        }
   
        // Set the property values from the edit text fields
        restaurant.name = nameTextField.text!
        restaurant.city = cityTextField.text!
        restaurant.address = addressTextField.text!
        restaurant.summary = descriptionTextView.text
//        if let imgData1 = photoImageView1.image?.pngData() {  //having a default image already
//            restaurant.imageData1 = imgData1
//        }
//        if let imgData2 = photoImageView2.image?.pngData() {  //having a default image already
//            restaurant.imageData2 = imgData2
//        }
//        if let imgData3 = photoImageView3.image?.pngData() {  //having a default image already
//            restaurant.imageData3 = imgData3
//        }
        // Save the data to the data store
        appDelegate.saveContext()
        
        // Dismiss the current view controller
        dismiss(animated: true, completion: nil)
    }
    
    private func loadOldData() {
        nameTextField.text = editedRestaurant?.name
        cityTextField.text = editedRestaurant?.city
        addressTextField.text = editedRestaurant?.address
        descriptionTextView.text = editedRestaurant?.summary
//        if let restaurantImageName1 = editedRestaurant?.imageData1 {
//            photoImageView1.image = UIImage(data: restaurantImageName1 as Data)
//            photoImageView1.contentMode = .scaleAspectFill
//            photoImageView1.clipsToBounds = true
//        }
//        if let restaurantImageName2 = editedRestaurant?.imageData2 {
//            photoImageView2.image = UIImage(data: restaurantImageName2 as Data)
//            photoImageView2.contentMode = .scaleAspectFill
//            photoImageView2.clipsToBounds = true
//        }
//        if let restaurantImageName3 = editedRestaurant?.imageData3 {
//            photoImageView3.image = UIImage(data: restaurantImageName3 as Data)
//            photoImageView3.contentMode = .scaleAspectFill
//            photoImageView3.clipsToBounds = true
//        }
    }
    

}

// MARK: - UITextFieldDelegate methods

extension NewRestaurantController: UITextFieldDelegate  {
  
    // auto return to the next input textfield
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        
        return true
    }
}


// MARK: - UIImagePickerControllerDelegate methods
//
extension NewRestaurantController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // Retrieve the image picked up by the usr
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        switch imgTag {
        case 1:
            if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                photoImageView1.image = selectedImage
                photoImageView1.contentMode = .scaleAspectFill
                photoImageView1.clipsToBounds = true
            }
            dismiss(animated: true, completion: nil)
        case 2:
            if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                photoImageView2.image = selectedImage
                photoImageView2.contentMode = .scaleAspectFill
                photoImageView2.clipsToBounds = true
            }
            dismiss(animated: true, completion: nil)
        case 3:
            if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                photoImageView3.image = selectedImage
                photoImageView3.contentMode = .scaleAspectFill
                photoImageView3.clipsToBounds = true
            }
            dismiss(animated: true, completion: nil)
        default: ()
        }
        
        //set constraints here

        // get the selectedImageName
        //if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
        //selectedImageName = url.path
        //print(selectedImageName)
        //}
    }
//
}
