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
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    
    // MARK: - Public Variables
    
    let mediaPlayer = MPMusicPlayerApplicationController.applicationQueuePlayer
    
    
    weak var tableViewController: SongTableViewController?
    
    var timer = Timer()
    
        var totalTime = 0
        var secondsPassed = 0
    
        func progress() {
    
            timer.invalidate()
    
            totalTime = 10
            progressBar.progress = 0.0
            secondsPassed = 0
    
            timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
        }
    
        @objc func updateTimer() {
            if secondsPassed < totalTime {
                secondsPassed += 1
                progressBar.progress = Float(secondsPassed) / Float(totalTime)
                print(Float(secondsPassed) / Float(totalTime))
            } else {
                timer.invalidate()
    
            }
        }
    
//   *** Buttons for Play ***
    
    @IBOutlet weak var buttonOne: UIButton!
    
    @IBOutlet weak var buttonTwo: UIButton!
    
    @IBOutlet weak var buttonThree: UIButton!
    
    @IBOutlet weak var buttonFour: UIButton!
    
//   *** end buttons ***
    
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        progress()
        
        Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { [weak self] (timer) in
            self?.mediaPlayer.skipToNextItem()
            self?.progress()
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
    
                
    
    @IBAction func unblurButtonPressed(_ sender: Any) {
    }
    
    @IBAction func hintButtonPressed(_ sender: Any) {
    }
    
    @IBAction func skipButtonPressed(_ sender: Any) {

        self.mediaPlayer.skipToNextItem()
        self.progress()
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tableViewController = segue.destination as? SongTableViewController {
            self.tableViewController = tableViewController
            tableViewController.mediaPlayer = mediaPlayer
        }
    }
    
}


//-----------------------------


//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//           let timeLimit = 30.0
//        displayScore.text = String(500)
//
//
//
//             // Add a playback queue containing all songs on the device
//             mediaPlayer.setQueue(with: .songs())
////
////             // Start playing from the beginning of the queue
//             mediaPlayer.play()
//            progress()
//
//         Timer.scheduledTimer(withTimeInterval: timeLimit, repeats: true) { (timer) in
////            self.mediaPlayer.setQueue(with: .songs())
//                    self.mediaPlayer.stop()
//            self.mediaPlayer.play()
//            self.progress()
