//
//  AndroidSnackBar.swift
//  AndroidLoaderForiOS
//
//  Created by Nishigandha on 05/10/17.
//  Copyright © 2017 Nishigandha. All rights reserved.
//

import UIKit


enum SnackBarType
{
    case SnackBarForSuccess
    case SnackBarForFailure
    case SnackBarForWarning
    case SnackBarForMessage
}


extension AndroidSnackBar: UIGestureRecognizerDelegate
{
    typealias TapResponseClosure = (_ tap: UITapGestureRecognizer) -> Void
   
    private struct ClosureStorage {
        static var TapClosureStorage: [UITapGestureRecognizer : TapResponseClosure] = [:]
    }

    func addSingleTapGestureRecognizerWithResponder(responder: @escaping TapResponseClosure) {
        self.addTapGestureRecognizerForNumberOfTaps(withResponder: responder)
    }

    func addTapGestureRecognizerForNumberOfTaps(numberOfTaps: Int = 1, numberOfTouches: Int = 1, withResponder responder: @escaping TapResponseClosure) {
        let tap = UITapGestureRecognizer()
        tap.numberOfTapsRequired = numberOfTaps
        tap.numberOfTouchesRequired = numberOfTouches
        tap.addTarget(self, action: #selector(handleTap))
        self.addGestureRecognizer(tap)
        
        ClosureStorage.TapClosureStorage[tap] = responder
    }
    
    func handleTap(sender: UITapGestureRecognizer)
    {
        if let closureForTap = ClosureStorage.TapClosureStorage[sender] {
            closureForTap(sender)
        }

    }
}

class AndroidSnackBar: UIView
{
    let snackBarImgView = UIImageView()
    let snackBarLabel = UILabel()
    var parentView = UIView()
    
    //Properties
    
    let DEFAULT_SIZE_IMG: CGFloat = 50
    let REMAINING_SPACE_SELFVIEW: CGFloat = 40
    let SPACE_BETWEEN_LABEL_IMG: CGFloat = 5

    let LABEL_FONT: UIFont! = UIFont(name: "Arial", size: 15)
    let LABEL_TEXT_COLOR: UIColor! = UIColor.white
    let LABEL_BG_COLOR: UIColor! = UIColor.clear
    let LABEL_NO_OF_LINES: Int = 0

    let IMG_BG_COLOR: UIColor! = UIColor.clear
    let VIEW_BG_COLOR : UIColor! = UIColor.black.withAlphaComponent(0.85)
    
    let ANIMATION_DURATION:TimeInterval! = 0.3

    
    

    func showSnackBarView(currentView:UIView,withText: String, snackBarType:SnackBarType)
    {
        self.parentView = currentView
        if !self.isDescendant(of: self.parentView)
        {
            self.snackBarLabel.text = withText
            self.isUserInteractionEnabled = true
            self.addSingleTapGestureRecognizerWithResponder { (tap) -> Void in
                
                self.closeSnackBar()
            }
            
            switch snackBarType
            {
            case .SnackBarForSuccess:
                self.snackBarImgView.image = UIImage(named: "success.png")
                self.designWithImage()
                break
                
            case .SnackBarForFailure:
                self.snackBarImgView.image = UIImage(named: "failure.png")
                self.designWithImage()
                break
                
            case .SnackBarForWarning:
                self.snackBarImgView.image = UIImage(named: "warning.png")
                self.designWithImage()
                break
                
            case .SnackBarForMessage:
                self.designWithoutImage()
                break
            }
        }
    }
    
    func designWithImage()
    {
        // Designing the label
        self.snackBarLabel.backgroundColor = LABEL_BG_COLOR
        self.snackBarLabel.textColor = LABEL_TEXT_COLOR
        self.snackBarLabel.numberOfLines = LABEL_NO_OF_LINES
        self.snackBarLabel.font = LABEL_FONT
        
        let labelSizeWithFixedWith = CGSize(width: SCREEN_WIDTH-DEFAULT_SIZE_IMG-SPACE_BETWEEN_LABEL_IMG, height: DEFAULT_SIZE_IMG)
        let exactLabelsize = self.snackBarLabel.sizeThatFits(labelSizeWithFixedWith)
        self.snackBarLabel.frame.size = exactLabelsize
        
        // Designing the imageView of icon
        self.snackBarImgView.frame.size  = CGSize(width: DEFAULT_SIZE_IMG, height: DEFAULT_SIZE_IMG)
        self.snackBarImgView.backgroundColor = IMG_BG_COLOR
        
        // Designing the self view
        self.backgroundColor = VIEW_BG_COLOR
        
        //        self.alpha = 0.5
        let yOfMainView: CGFloat = SCREEN_HEIGHT-(exactLabelsize.height+REMAINING_SPACE_SELFVIEW)
        
        // Initially place the self view at the bottom for animating
        let frameOfBar: CGRect = CGRect(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: exactLabelsize.height+REMAINING_SPACE_SELFVIEW)
        self.frame = frameOfBar
        
        //animating selfview to present
        UIView.animate(withDuration:ANIMATION_DURATION, delay: 0.1, options: .curveEaseIn, animations: {
            
            let frameOfBar: CGRect = CGRect(x: 0, y: yOfMainView, width: SCREEN_WIDTH, height: exactLabelsize.height+self.REMAINING_SPACE_SELFVIEW)
            self.frame = frameOfBar
            
        }, completion:nil)
        
        self.parentView.addSubview(self)
        
        // rearranging the x and y co-ordinates of Imgview
        self.snackBarImgView.frame.origin = CGPoint(x: SPACE_BETWEEN_LABEL_IMG, y: (self.frame.size.height - self.snackBarImgView.frame.size.height) / 2)
        self.addSubview(self.snackBarImgView)
        
        // rearranging the x and y co-ordinates of label
        self.snackBarLabel.frame.origin = CGPoint(x: DEFAULT_SIZE_IMG+(2*SPACE_BETWEEN_LABEL_IMG), y: (self.frame.size.height - self.snackBarLabel.frame.size.height) / 2)
        
        self.addSubview(self.snackBarLabel)

    }
    
    func designWithoutImage()
    {
        // Designing the label
        self.snackBarLabel.backgroundColor = LABEL_BG_COLOR
        self.snackBarLabel.textColor = LABEL_TEXT_COLOR
        self.snackBarLabel.numberOfLines = LABEL_NO_OF_LINES
        self.snackBarLabel.font = LABEL_FONT
        
        let labelSizeWithFixedWith = CGSize(width: SCREEN_WIDTH-SPACE_BETWEEN_LABEL_IMG, height: DEFAULT_SIZE_IMG)
        let exactLabelsize = self.snackBarLabel.sizeThatFits(labelSizeWithFixedWith)
        self.snackBarLabel.frame.size = exactLabelsize

        // Designing the self view
        self.backgroundColor = VIEW_BG_COLOR
        let yOfMainView: CGFloat = SCREEN_HEIGHT-(exactLabelsize.height+REMAINING_SPACE_SELFVIEW)
        
        // Initially place the self view at the bottom for animating
        let frameOfBar: CGRect = CGRect(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: exactLabelsize.height+REMAINING_SPACE_SELFVIEW)
        self.frame = frameOfBar
        
        //animating selfview to present
        UIView.animate(withDuration:ANIMATION_DURATION, delay: 0.1, options: .curveEaseIn, animations: {
            
            let frameOfBar: CGRect = CGRect(x: 0, y: yOfMainView, width: SCREEN_WIDTH, height: exactLabelsize.height+self.REMAINING_SPACE_SELFVIEW)
            self.frame = frameOfBar
            
        }, completion:nil)
       self.parentView.addSubview(self)
        
        // rearranging the x and y co-ordinates of label
        self.snackBarLabel.frame.origin = CGPoint(x: SPACE_BETWEEN_LABEL_IMG, y: (self.frame.size.height - self.snackBarLabel.frame.size.height) / 2)
        self.addSubview(self.snackBarLabel)
        
    }
    
    func hideSnackBarFromView()
    {
        self.closeSnackBar()
    }

    func closeSnackBar()
    {
        UIView.animate(withDuration:ANIMATION_DURATION, delay: 0.1, options: .curveEaseIn, animations: {
            
            self.frame.origin.y = SCREEN_HEIGHT
            
        }, completion: { (Bool) in
            self.removeFromSuperview()
        })

    }
    
    
//    func animateIconImage()
//    {
//        UIView.animateKeyframes(withDuration: 1.2, delay: 0.0, options: .beginFromCurrentState, animations: {
//            
//            // scale the view down by half over 25% of the duration
//            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.6, animations: {
//             
//                self.iconMaskView.frame = CGRect(x: self.iconView.bounds.origin.x, y: self.iconView.bounds.origin.y, width: self.iconView.bounds.size.width/2, height: self.iconView.bounds.size.height)
//                
//            })
//            
//            // fade the view out starting at 10% of the duration until the end of the duration
//            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.6, animations: {
//                
//                self.iconMaskView.frame = CGRect(x: self.iconView.bounds.origin.x, y: self.iconView.bounds.origin.x, width: self.iconView.bounds.size.width, height: self.iconView.bounds.size.width)
//            })
//        }) { (Bool) in
//            
//        }
//    }
//    
//    
//    func initWithPosition(IconImage:UIImage)
//    {
//            self.iconView.frame.size = IconImage.size
//            self.iconMaskView.frame = CGRect(x: self.iconView.bounds.origin.x, y: self.iconView.bounds.origin.y, width: 0, height: 0)
//            snackBarImgView.image = IconImage
//            snackBarImgView.frame = self.iconView.bounds
//            self.iconMaskView.addSubview(snackBarImgView)
//            self.iconMaskView.clipsToBounds = true
//            self.iconView.clipsToBounds = true
//            self.iconView.addSubview(self.iconMaskView)
//    }
    
    
}
