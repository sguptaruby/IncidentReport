//
//  CustomViews.swift
//  EventApp
//
//  Created by roy on 4/9/19.
//  Copyright © 2019 roy. All rights reserved.
//

import UIKit

//MARK: UIView
class RoundView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = self.frame.width/2
        self.backgroundColor = UIColor.lightGray
    }
    
}

class RoundCornerView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        
    }
    
}

class ShadowView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        
        self.layer.masksToBounds =  false
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.layer.shadowOpacity = 1.0
        self.backgroundColor = UIColor.clear
        
    }
    
}



//MARK: UIButton
class RoundCornerButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
        self.backgroundColor = appThemeColor
        
    }
    
}

//MARK: UIImageView
class RoundImageView: UIImageView {
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.width/2
        //        self.backgroundColor = UIColor.lightGray
    }
    
}

//MARK: UIImageView
class BorderImageView: UIImageView {
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.clipsToBounds = true
        self.layer.cornerRadius = 3.0
        self.layer.borderColor = appThemeColor.cgColor
        self.layer.borderWidth = 0.3
    }
    
}
