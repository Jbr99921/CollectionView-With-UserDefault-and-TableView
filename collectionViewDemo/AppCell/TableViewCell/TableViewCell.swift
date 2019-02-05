//
//  TableViewCell.swift
//  collectionViewDemo
//
//  Created by XongoLab on 04/10/18.
//  Copyright © 2018 XongoLab. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var ImgViewT: UIImageView!
    @IBOutlet weak var LblNameT: UILabel!
    @IBOutlet weak var LblCityT: UILabel!
    @IBOutlet weak var LblStateT: UILabel!
    @IBOutlet weak var LblEmailT: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        UIView.animate(withDuration: 25.0, delay: 0.2, options: ([.curveLinear, .repeat]), animations: {() -> Void in
            self.LblEmailT.center = CGPoint(x: self.LblEmailT.bounds.size.width/2, y: self.LblEmailT.center.y)//(0 - self.LblEmailT.bounds.size.width / 2, self.LblEmailT.center.y)
        }, completion:  { _ in })
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
