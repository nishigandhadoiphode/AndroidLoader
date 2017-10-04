//
//  AndroidLoaderView.swift
//  AndroidLoaderForiOS
//
//  Created by Nishigandha on 28/09/17.
//  Copyright © 2017 Nishigandha. All rights reserved.
//

import UIKit


// MARK: -  Running Device
public let SCREEN_WIDTH = UIScreen.main.bounds.width
public let SCREEN_HEIGHT = UIScreen.main.bounds.height


open class AndroidLoaderView: UIView
{

    public let loader = UIActivityIndicatorView()
    public let loaderLabel = UILabel()
    
    //Properties
    
    public var DEFAULT_SIZE_LOADER: CGFloat = 50
    
    public var LABEL_FONT: UIFont! = UIFont(name: "Arial", size: 15)
    public var LABEL_TEXT_COLOR: UIColor! = UIColor.white
    public var LABEL_BG_COLOR: UIColor! = UIColor.clear
    public var LABEL_NO_OF_LINES: Int = 0
    public var VIEW_BG_COLOR: UIColor! = UIColor.darkGray
    
    
   public  func initializeLoaderView(parentView:UIView,withText: String)
    {
        // Desinging the label
        self.loaderLabel.backgroundColor = LABEL_BG_COLOR
        self.loaderLabel.textColor = LABEL_TEXT_COLOR
        self.loaderLabel.numberOfLines = LABEL_NO_OF_LINES
        self.loaderLabel.font = LABEL_FONT
        self.loaderLabel.text = withText
        let labelSizeWithFixedWith = CGSize(width: SCREEN_WIDTH-160, height: 50)
        let exactLabelsize = self.loaderLabel.sizeThatFits(labelSizeWithFixedWith)
        self.loaderLabel.frame.size = exactLabelsize

        // Designing the default loader
        self.loader.activityIndicatorViewStyle = .whiteLarge
        self.loader.alpha = 1.0
        self.loader.startAnimating()

        
        // Desinging the UIView
        self.backgroundColor = VIEW_BG_COLOR
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = VIEW_BG_COLOR.cgColor
        self.layer.masksToBounds = true
        
        var frameOfLoader: CGRect = CGRect()
        if exactLabelsize.height == 0
        {
            frameOfLoader.size.width = DEFAULT_SIZE_LOADER
            frameOfLoader.size.height = DEFAULT_SIZE_LOADER
        }
        else if exactLabelsize.height<DEFAULT_SIZE_LOADER
        {
            frameOfLoader.size.width = exactLabelsize.width + self.loader.frame.size.width + 55
            frameOfLoader.size.height = DEFAULT_SIZE_LOADER
        }
        else
        {
            frameOfLoader.size.width = exactLabelsize.width + self.loader.frame.size.width + 55
            frameOfLoader.size.height = exactLabelsize.height+10
        }
        
        self.frame = frameOfLoader
        self.center = parentView.center
        parentView.addSubview(self)

        // setting x and y of subviews
        
        self.loader.frame.origin.x = 25
        self.loader.frame.origin.y = (self.frame.size.height - self.loader.frame.size.height) / 2
        self.addSubview(self.loader)

        
        let xOfLabel: CGFloat = self.loader.frame.origin.x + self.loader.frame.size.width + 25
        self.loaderLabel.frame.origin.x = xOfLabel
        self.loaderLabel.center.y = self.loader.center.y
        self.addSubview(self.loaderLabel)

    }
    
   public  func hideLoaderFromView(parentView:UIView)
    {
        // make the parent view background back to active
      _ =   parentView.subviews.map {
            $0.alpha = 1
        }
        self.loader.stopAnimating()
        self.removeFromSuperview()
    }
    
   public  func showLoaderOnView(parentView:UIView, text:String)
    {
        // make the parent view background inactive
        if !self.loader.isAnimating
        {
            _ =  parentView.subviews.map {
                $0.alpha = 0.3
            }
            self.initializeLoaderView(parentView: parentView, withText: text)

        }
    }
}
