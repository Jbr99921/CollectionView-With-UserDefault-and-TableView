//
//  EditViewController.swift
//  collectionViewDemo
//
//  Created by XongoLab on 03/10/18.
//  Copyright © 2018 XongoLab. All rights reserved.
//

import UIKit

public var MyIndex:Int?

class EditViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var ImgVieew: UIImageView!
    @IBOutlet weak var TxtNames: UITextField!
    @IBOutlet weak var TxtEmail: UITextField!
    @IBOutlet weak var TxtCity: UITextField!
    @IBOutlet weak var TxtState: UITextField!
    
    let imagePicker = UIImagePickerController()
    
    
    var Names:String?
    var Email:String?
    var Cities:String?
    var States:String?
    var myimgs:UIImage?
    var MyIndex:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit Details"
        TxtNames.text = Names
        TxtEmail.text = Email
        TxtCity.text = Cities
        TxtState.text = States
        ImgVieew.image = myimgs
        
        imagePicker.delegate = self
        ImgVieew.layer.cornerRadius = ImgVieew.frame.size.height/2
        ImgVieew.clipsToBounds = false
        ImgVieew.layer.masksToBounds = true
    }
    
    @IBAction func ChoseImg(_ sender: UIButton) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            ImgVieew.image = pickedImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func BtnUpdate(_ sender: UIButton) {
        chacked = false

    let imageData:NSData = UIImageJPEGRepresentation(ImgVieew.image!,1)! as NSData
    
    
    let Dictionries:[String:Any] = ["Name":(TxtNames.text)!,"Email":(TxtEmail.text)!,"City":(TxtCity.text)!,"State":(TxtState.text)!,"img":(imageData)]
    
        mydata[MyIndex!] = Dictionries
        
        UserDefaults.standard.set(mydata, forKey: "arr")
        
       // print(Dictionries)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func BtnClose(_ sender: UIButton) {
        chacked = false
        self.dismiss(animated: true, completion: nil)
    
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    func validation(){
        let alertController = UIAlertController(title: "Error", message: "Please Enter Valid Email Address", preferredStyle: .alert)
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            print("succeffully done")
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func alreadyExist(){
        let Validation = UIAlertController(title: "Error", message: "Email is already Exist", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
        }
        Validation.addAction(okAction)
        self.present(Validation, animated: true, completion: nil)
    }
    func alertaction(){
        if (TxtNames.text == "" || TxtEmail.text == "" || TxtCity.text == "" || TxtState.text == "" ){
            let alertController = UIAlertController(title: "Error", message: "Please Enter Valid Details", preferredStyle: .alert)
            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                //     print("OK Pressed")
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
                //  print("Cancel Pressed")
            }
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    
}
