//
//  GradientView.swift
//  My Clerkie
//
//  Created by Jeyashri Natarajan on 11/18/17.
//  Copyright © 2017 Clerkie. All rights reserved.
//

import UIKit

@IBDesignable

class GradientView: UIView {
    
    @IBInspectable var FirstColor : UIColor = UIColor.clear{
        
        didSet{
            
            updateView()
            
        }
        
    }
    
    @IBInspectable var SecondColor : UIColor = UIColor.clear{
        
        didSet{
            
            updateView()
            
        }
        
    }
    
    override class var layerClass: AnyClass{
        
        get {
            
            return CAGradientLayer.self
            
        }
        
    }
    
    func updateView(){
        
        let layer = self.layer as! CAGradientLayer
        
        layer.colors = [FirstColor.cgColor,SecondColor.cgColor]
        
        layer.locations = [0.4]
        
    }
    
}
