//
//  myTableViewCell.swift
//  CustomTabCenterBig
//
//  Created by Xibo Zhang on 17/4/22.
//  Copyright © 2017年 Nitin Gohel. All rights reserved.
//

import UIKit

class myTableViewCell: UITableViewCell {
    
    var title:UILabel!
    var clickBtn:UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if !self.isEqual(nil) {
            title = UILabel(frame: CGRect(x:20,y:20,width:200,height:30))
            self.contentView.addSubview(title)
            clickBtn = UIButton(frame: CGRect(x:200,y:20,width:60,height:30 ))
            clickBtn.setTitle("app", for: UIControlState.normal)
            clickBtn.setTitleColor(UIColor.blue, for: UIControlState.normal)
            clickBtn.setTitleColor(UIColor.white, for: UIControlState.highlighted)
            self.contentView.addSubview(clickBtn)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
