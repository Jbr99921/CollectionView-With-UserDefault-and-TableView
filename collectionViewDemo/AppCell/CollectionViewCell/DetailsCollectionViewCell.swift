//
//  DetailsCollectionViewCell.swift
//  collectionViewDemo
//
//  Created by XongoLab on 01/10/18.
//  Copyright © 2018 XongoLab. All rights reserved.
//

import UIKit

protocol MyCellDelegate: AnyObject {
    func btnCloseTapped(indx:Int)
}
class DetailsCollectionViewCell: UICollectionViewCell,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @IBOutlet weak var ImgViews: UIImageView!
    @IBOutlet weak var LblName: UILabel!
    @IBOutlet weak var LblCity: UILabel!
    @IBOutlet weak var LblState: UILabel!
    @IBOutlet weak var LblEmail: UILabel!
    @IBOutlet weak var BtnCLose: UIButton!
    
    var delegates:MyCellDelegate?
    var indexs:IndexPath?
    
    @IBAction func BtnCloseCell(_ sender: UIButton) {
        
        delegates?.btnCloseTapped(indx: (indexs?.row)!)
        
    }
}
