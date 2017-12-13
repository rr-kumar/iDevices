//
//  DeviceViewController.swift
//  iDevices
//
//  Created by Apple on 23/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class DeviceViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var deviceNameTextField: UITextField!
    @IBOutlet weak var deviceImageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    var iDevice : Device? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        if iDevice != nil {
            deviceImageView.image = UIImage(data: iDevice!.image!)
            deviceNameTextField.text = iDevice?.title
            updateButton.setTitle("Update", for:.normal)

        }else{
            deleteButton.isHidden = true
        }
        

       
    }
    @IBAction func cameraButton(_ sender: Any) {
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func galleryButton(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let pullimage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        deviceImageView.image = pullimage
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func addButton(_ sender: Any) {
        
     if iDevice != nil{
        iDevice!.title = deviceNameTextField.text
        iDevice!.image = UIImagePNGRepresentation(deviceImageView.image!)
        
            
         } else {
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let iDevice = Device(context: context)
            iDevice.title = deviceNameTextField.text
            iDevice.image = UIImagePNGRepresentation(deviceImageView.image!)
        }
        
       
        
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
        
        
    
    }
    @IBAction func deleteButton(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(iDevice!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
