//
//  ViewController.swift
//  AndroidLoaderForiOS
//
//  Created by Nishigandha on 03/10/17.

//  Copyright © 2017 Nishigandha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let myLoader = AndroidLoaderView()
    let mybar = AndroidSnackBar()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func startBtnClicked(_ sender: Any) {
        
        // To call SnackBar :-
        mybar.showSnackBarView(currentView: self.view, withText: "Profile updated successfully", snackBarType:SnackBarType.SnackBarForSuccess)
        // To call loader :-
        myLoader.showLoaderOnView(currentView: self.view, text: "Loading...")
    }

    @IBAction func stopBtnClicked(_ sender: Any) {
        // to remove snackbar :-
        mybar.hideSnackBarFromView()
        // to remove loader :-
        myLoader.hideLoaderFromView()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  }
