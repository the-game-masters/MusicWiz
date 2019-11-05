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
//    ? is guard rails for accessing a value that may or may not be
    @IBOutlet weak var navigationBar: UINavigationItem?
    
    @IBOutlet weak var timerView: UIView?
    
    @IBOutlet weak var albumImageView: UIImageView?
    
    // MARK: - Public Variables
    
    let mediaPlayer = MPMusicPlayerApplicationController.applicationQueuePlayer
    
    weak var tableViewController: UITableViewController?
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add a playback queue containing all songs on the device
        mediaPlayer.setQueue(with: .songs())
        // Start playing from the beginning of the queue
        mediaPlayer.play()
        
        // Print the now-playing item, need to write recursive func that calls until loaded
        print("Title: \(mediaPlayer.nowPlayingItem?.title), Artist: \(mediaPlayer.nowPlayingItem?.artist)")
        print("Index: \(mediaPlayer.indexOfNowPlayingItem)")
        
        //get songs
        var query = MPMediaQuery.songs()
        print("query is \(query)")
        //
        var collection = MPMediaItemCollection(items: query.items!)
        let player = MPMusicPlayerController.applicationMusicPlayer

        player.setQueue(with:collection)

        print("mediaplayer info: \(collection.items[1].title)")

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
