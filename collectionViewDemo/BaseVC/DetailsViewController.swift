//
//  DetailsViewController.swift
//  collectionViewDemo
//
//  Created by XongoLab on 01/10/18.
//  Copyright © 2018 XongoLab. All rights reserved.
//

import UIKit

public var users = [[String:Any]]()
public var Data:Int?
public var chacked = false
class DetailsViewController:UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MyCellDelegate{
    
   
    //MARK:-- ============ All Outlet ===========================//
        @IBOutlet weak var DetailCollection: UICollectionView!
        @IBOutlet var NoIteamView: UIView!
        @IBOutlet weak var TblView: UITableView!
        @IBOutlet var ShowTable: UIView!
    
        var ColTab = false
        let imagePickers = UIImagePickerController()
        var arraydata = [[String:Any]]()
        let ImageWidth: CGFloat = UIScreen.main.bounds.size.height/2
        let imageHeight: CGFloat = UIScreen.main.bounds.size.width/2

    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        TblView.delegate = self
        TblView.dataSource = self
        TblView.rowHeight = 150
        DetailCollection.delegate = self
        DetailCollection.dataSource = self
        title = "Collection View"
        navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "Show Table", style: .done, target: self, action: #selector(barbutton))]

        user()
    }
    @objc func barbutton(sender : UIBarButtonItem){
//        if ColTab == false{
//            ColTab = true
//            btnforlabel()
//            TblView.reloadData()
//            DetailCollection.reloadData()
//
//        }else{
//            ColTab = true
//            btnforlabel()
//            TblView.reloadData()
//            DetailCollection.reloadData()
//        }

        if chacked == false{
        chacked = true
        self.view.addSubview(ShowTable)
            title = "Table View"
        navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "Show Collection", style: .done, target: self, action: #selector(barbutton))]
            return
        }else{
            chacked = false
            title = "Collection View"
            self.ShowTable.removeFromSuperview()
             navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "Show Table", style: .done, target: self, action: #selector(barbutton))]
            return
        }
        
}
    
    
    //MARK:--//=================== User Default ==================//
    func user(){
        
            if let users = UserDefaults.standard.array(forKey: "arr"){
                mydata = users as! [[String : Any]]
                UserDefaults.standard.synchronize()
                TblView.reloadData()
                DetailCollection.reloadData()
                }
        
        
    }

    //MARK:-- ============= Collectionview DataSource Mathod ==================//
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mydata.isEmpty {
//            TblView.reloadData()
//            DetailCollection.reloadData()
            DetailCollection.backgroundView = NoIteamView
        }
        return mydata.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
            let reference = mydata[indexPath.row] as NSDictionary
        
            let imgs:UIImage = UIImage(data:reference.value(forKey: "img") as! Data, scale: 1.0)!
     
            let Cell:DetailsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCollectionViewCell", for: indexPath) as! DetailsCollectionViewCell
            Cell.LblName.text = reference.value(forKey: "Name") as? String
            Cell.LblEmail.text = reference.value(forKey: "Email") as? String
            Cell.LblCity.text = reference.value(forKey: "City") as? String
            Cell.LblState.text = reference.value(forKey: "State") as? String
            Cell.ImgViews.image = imgs
            Cell.ImgViews.layer.cornerRadius = Cell.ImgViews.frame.size.height/2
            Cell.ImgViews.clipsToBounds = false
            Cell.ImgViews.layer.masksToBounds = true
            Cell.BtnCLose.layer.setValue(indexPath.row, forKey: "index")
            Cell.indexs = indexPath
            Cell.contentView.backgroundColor = UIColor.lightGray
            Cell.delegates = self
        return Cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
   chacked = true
        
            let ip = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        
            //var indexpath = collectionView.indexPathsForSelectedItems
            let celldetails = collectionView.cellForItem(at: indexPath) as! DetailsCollectionViewCell
            print(celldetails)
        
            ip.Names = celldetails.LblName.text
            ip.Email = celldetails.LblEmail.text
            ip.Cities = celldetails.LblCity.text
            ip.States = celldetails.LblState.text
            ip.myimgs = celldetails.ImgViews.image
            ip.MyIndex = indexPath.row
        
            navigationController?.present(ip, animated: true, completion: nil)
    
    }
    //MARK:-- ============= Delete Collectionview Cell ==================//
    
    func btnCloseTapped(indx: Int) {
        mydata.remove(at:indx)
        
        DetailCollection.reloadData()
        TblView.reloadData()
        
        UserDefaults.standard.set(mydata, forKey: "arr")
        
        
    }
    
}
extension DetailsViewController:UITableViewDelegate,UITableViewDataSource{
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return mydata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
     chacked = true
        
        let references = mydata[indexPath.row] as NSDictionary
        
        let imgs:UIImage = UIImage(data:references.value(forKey: "img") as! Data, scale: 1.0)!
        
        let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
       // let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.LblNameT.text = references.value(forKey: "Name") as? String
        cell.LblEmailT.text = references.value(forKey: "Email") as? String
        cell.LblCityT.text = references.value(forKey: "City") as? String
        cell.LblStateT.text = references.value(forKey: "State") as? String
        cell.ImgViewT.image = imgs
        cell.ImgViewT.layer.cornerRadius = cell.ImgViewT.frame.size.height/2
        cell.ImgViewT.clipsToBounds = false
        cell.ImgViewT.layer.masksToBounds = true
        cell.contentView.backgroundColor = UIColor.brown
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        DetailCollection.reloadData()
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete){
            if let tv = TblView{
                TblView.reloadData()
                DetailCollection.reloadData()
            mydata.remove(at: indexPath.row)
            
            tv.deleteRows(at: [indexPath], with: .left)
            
            UserDefaults.standard.set(mydata, forKey: "arr")
        
        }
        

        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        chacked = false
        
        let ip = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
       
  //      var indexpath = tableView.indexPathsForSelectedRows
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell

        ip.Names = cell.LblNameT.text
        ip.Email = cell.LblEmailT.text
        ip.Cities = cell.LblCityT.text
        ip.States = cell.LblStateT.text
        ip.myimgs = cell.ImgViewT.image
        ip.MyIndex = indexPath.row
        
        navigationController?.present(ip, animated: true, completion: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        DetailCollection.reloadData()
        TblView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        DetailCollection.reloadData()
        TblView.reloadData()
    }
    
}
