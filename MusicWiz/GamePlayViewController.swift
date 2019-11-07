//
//  GamePlayViewController.swift
//  MusicWiz
//
//  Created by Adriana Graybill on 11/3/19.
//  Copyright © 2019 Adriana Graybill. All rights reserved.
//

import UIKit
import MediaPlayer

//Global Var option
//struct GlobalVar {
//    static var highScore = 0
//}


class GamePlayViewController: UIViewController {

    
    // MARK: - IBOutlet References
//    ? is guard rails for accessing a value that may or may not be
    @IBOutlet weak var navigationBar: UINavigationItem?
    
    @IBOutlet weak var timerView: UIView?
    
    @IBOutlet weak var albumImageView: UIImageView?
    
    // MARK: - Public Variables
    
    let mediaPlayer = MPMusicPlayerApplicationController.applicationQueuePlayer
    
    
    weak var tableViewController: SongTableViewController?
    
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //User defaults settings
        let defaults = UserDefaults.standard
        let scoresArray = ["BRUH","FUCKIN BRUH"]
        defaults.set(scoresArray, forKey:"UserScoreboard")
        
        // Register for the ready to play notification
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateInterface),
                                               name: .MPMusicPlayerControllerNowPlayingItemDidChange,
                                               object: nil)

        // Add a playback queue containing all songs on the device
        mediaPlayer.setQueue(with: .songs())

        // Start playing from the beginning of the queue
        mediaPlayer.prepareToPlay { [weak self] (error) in
            if error == nil {
                self?.startSongShuffle()
            }
        }
        
    }
    
    func startSongShuffle() {
        mediaPlayer.play()
        
        Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { [weak self] (timer) in
            self?.mediaPlayer.skipToNextItem()
        }
    }
    
    @objc func updateInterface() {
        guard let albumImageView = albumImageView else { return }
        
        if let artwork = mediaPlayer.nowPlayingItem?.artwork {
            albumImageView.image = artwork.image(at: albumImageView.bounds.size)
        } else {
            // this is the case where there is no album artwork
            // albumImageView.image = mediaPlayer.nowPlayingItem?.artwork?.image(at: albumImageView.bounds.size)
        }
        
        guard let tableViewController = tableViewController else { return }
        tableViewController.dataSource = tableViewController.initializeSongTitles()
        tableViewController.tableView.reloadData()
    }
        
    
    // MARK: - Actions
                
//    @IBAction func btnOne(_ sender: Any) {
//        var guess: String! = buttonOne.titleLabel?.text
//        print("button one is",guess)
//        var song = mediaPlayer.nowPlayingItem?.title
//        print("song is", song)
//        if guess == song {
//            print("BINGO🌟")
//        } else {
//            print("nopes😵")
//        }
//    }
    
                
    //            ***end button Fns***
    
    @IBAction func unblurButtonPressed(_ sender: Any) {
    }
    
    @IBAction func hintButtonPressed(_ sender: Any) {
    }
    
    @IBAction func skipButtonPressed(_ sender: Any) {
    }
    
    @IBAction func EndGame(_ sender: UIButton) {
        performSegue(withIdentifier: "GoToScores", sender: self)
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tableViewController = segue.destination as? SongTableViewController {
            self.tableViewController = tableViewController
            tableViewController.mediaPlayer = mediaPlayer
        }
    }
    
}
