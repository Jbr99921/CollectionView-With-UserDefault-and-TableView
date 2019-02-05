//
//  RegistrationViewController.swift
//  collectionViewDemo
//
//  Created by XongoLab on 01/10/18.
//  Copyright © 2018 XongoLab. All rights reserved.
//

import UIKit

public var mydata = [[String:Any]]()

class RegistrationViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    //MARK:-- ============= Outlet ==================//
    @IBOutlet weak var BtnClose: UIButton!
    @IBOutlet weak var BtnClick: UIButton!
    @IBOutlet weak var RegistrationView: UIView!
    @IBOutlet weak var ImgView: UIImageView!
    @IBOutlet weak var TxtName: UITextField!
    @IBOutlet weak var TxtEmail: UITextField!
    @IBOutlet weak var TxtCity: UITextField!
    @IBOutlet weak var TxtState: UITextField!
    
    let imagePicker = UIImagePickerController()
    var Named:String?
    var Emails:String?
    var City:String?
    var State:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // title = "Registration Page"
        Named = TxtName.text!
        Emails = TxtEmail.text!
        City = TxtCity.text!
        State = TxtState.text!
        
        imagePicker.delegate = self
        ImgView.layer.cornerRadius = ImgView.frame.size.height/2
        ImgView.clipsToBounds = false
        ImgView.layer.masksToBounds = true
        }
    
        func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
  
    //MARK:-- ============= Select Image from Gallary ==================//
    
    @IBAction func BtnSelectImage(_ sender: UIButton) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            ImgView.image = pickedImage
        }
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func BtnRegister(_ sender: UIButton) {
        if (TxtName.text == "" || TxtEmail.text == "" || TxtCity.text == "" || TxtState.text == ""){
            alertaction()
        }else if !isValidEmail(testStr: TxtEmail.text!){
            validation()
        }
        else if isValidEmail(testStr: TxtEmail.text!){
                
                for get in mydata{
                    
                    for search in get {
                        
                        if(search.value as? String == TxtEmail.text){
                            emailAlreadyExist()
                            return
                        }
                    }
                }
                
           
            let imageData:NSData = UIImageJPEGRepresentation(ImgView.image!,1)! as NSData
            
            let Dictionry:[String:Any] = ["Name":(TxtName.text)!,"Email":(TxtEmail.text)!,"City":(TxtCity.text)!,"State":(TxtState.text)!,"img":(imageData)]
            
            mydata.append(Dictionry)
            
            // print(mydata)
            let VC:DetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
            
            VC.arraydata = mydata
            UserDefaults.standard.set(mydata, forKey: "arr")
            self.navigationController?.pushViewController(VC, animated: true)
            TxtName.text = ""
            TxtCity.text = ""
            TxtEmail.text = ""
            TxtState.text = ""
        }
        else {
            alertaction()
        }
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
    func emailAlreadyExist(){
        
        let alertEmail = UIAlertController(title: "Error", message: "Email is Already Exist", preferredStyle: .alert)
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
               print("succeffully done")
        }
        alertEmail.addAction(okAction)
        self.present(alertEmail, animated: true, completion: nil)
    }
    
    func alertaction(){
        if (TxtName.text == "" || TxtEmail.text == "" || TxtCity.text == "" || TxtState.text == "" ){
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
    
    @IBAction func BtnClear(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        TxtName.text = nil
        TxtEmail.text = nil
        TxtCity.text = nil
        TxtState.text = nil
        ImgView.image = UIImage(named: "Image")
    }
    @IBAction func BtnShowAllData(_ sender: UIBarButtonItem) {
        let show:DetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        self.navigationController?.pushViewController(show, animated: true)
    }
}
