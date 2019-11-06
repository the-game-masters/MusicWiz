//
//  LandingScreen.swift
//  MusicWiz
//
//  Created by Austin Wood on 11/5/19.
//  Copyright © 2019 Adriana Graybill. All rights reserved.
//

import UIKit

class LandingScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func GoToMain(_ sender: Any) {
performSegue(withIdentifier: "GamePage", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
