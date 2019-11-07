//
//  PostGame.swift
//  MusicWiz
//
//  Created by Austin Wood on 11/6/19.
//  Copyright © 2019 Adriana Graybill. All rights reserved.
//

import UIKit

class PostGame: UIViewController {

    @IBOutlet weak var ScoresLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let defaults = UserDefaults.standard
        guard let scoreboard = defaults.object(forKey:"UserScoreboard") as? [String]? ?? [String]() else {return}
//        ScoresLabel.text = (scoreboard as! String)
        print("SCOREEEESSSS",scoreboard)
        
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
