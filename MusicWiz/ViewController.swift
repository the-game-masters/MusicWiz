//
//  GamePlayViewController.swift
//  MusicWiz
//
//  Created by Adriana Graybill on 11/3/19.
//  Copyright © 2019 Adriana Graybill. All rights reserved.
//

import UIKit

class GamePlayViewController: UIViewController {
    
    // MARK: - IBOutlet References
    
    @IBOutlet weak var navigationBar: UINavigationItem?
    
    @IBOutlet weak var timerView: UIView?
    
    @IBOutlet weak var albumImageView: UIImageView?
    
    // MARK: - Public Variables
    
    weak var tableViewController: UITableViewController?
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func unblurButtonPressed(_ sender: Any) {
    }
    
    @IBAction func hintButtonPressed(_ sender: Any) {
    }
    
    @IBAction func skipButtonPressed(_ sender: Any) {
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tableViewController = segue.destination as? UITableViewController {
            self.tableViewController = tableViewController
        }
    }
    
}
