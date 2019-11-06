//
//  GamePlayViewController.swift
//  MusicWiz
//
//  Created by Adriana Graybill on 11/3/19.
//  Copyright © 2019 Adriana Graybill. All rights reserved.
//

import UIKit
import MediaPlayer

class GamePlayViewController: UIViewController {
    
    // MARK: - IBOutlet References
    
    @IBOutlet weak var navigationBar: UINavigationItem?
    
    @IBOutlet weak var timerView: UIView?
    
    @IBOutlet weak var albumImageView: UIImageView?
    
    // MARK: - Public Variables
    
    let mediaPlayer = MPMusicPlayerApplicationController.applicationQueuePlayer
    
    
    weak var tableViewController: UITableViewController?
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let timeLimit = 15.0
        
        
        // Add a playback queue containing all songs on the device
        mediaPlayer.setQueue(with: .songs())
//        print(mediaPlayer.songs())
        
        // Start playing from the beginning of the queue
        mediaPlayer.prepareToPlay()
        mediaPlayer.shuffleMode = .songs
        mediaPlayer.play()
        

      
        
    Timer.scheduledTimer(withTimeInterval: timeLimit, repeats: true) { (timer) in
            //   self.mediaPlayer.stop()
        

        self.albumImageView!.image = self.mediaPlayer.nowPlayingItem?.artwork?.image(at: self.albumImageView!.bounds.size)
        
//        let alert = UIAlertController(title: "Song", message: " \(String(describing: self.mediaPlayer.nowPlayingItem?.title))", preferredStyle: .alert)
//
//        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//
//        self.present(alert, animated: true)
        
        print("Title: //\(String(describing: self.mediaPlayer.nowPlayingItem?.title))")
        
        self.mediaPlayer.skipToNextItem()
        
    }
        
        
        
        // Print the now-playing item, need to write recursive func that calls until loaded
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
