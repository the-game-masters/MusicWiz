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
    
    @IBOutlet weak var hintBtn: UIButton!
    
    
    // MARK: - Public Variables
    
    let mediaPlayer = MPMusicPlayerApplicationController.applicationQueuePlayer
    
    weak var tableViewController: SongTableViewController?
    
    var timer = Timer()
    var timez = Timer()
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
            }else{
                self?.mediaPlayer.play()
            }
        }
        
    }
    
    func startSongShuffle() {
        timez.invalidate()
        mediaPlayer.stop()
        mediaPlayer.play()
        mediaPlayer.skipToNextItem()
        progress()
        timez = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { [weak self] (timer) in
            self?.mediaPlayer.skipToNextItem()
            self?.progress()
        }
    }
    
    

    
    
    
    
    
    
    
    
    
    
    @objc func updateInterface() {
        hintBtn.setTitle("hint", for: .normal)
        guard let albumImageView = albumImageView else { return }
        
        if let artwork = mediaPlayer.nowPlayingItem?.artwork {
            albumImageView.image = artwork.image(at: albumImageView.bounds.size)
        } else {
            albumImageView.image = UIImage(named: "defaultArtwork")
        }
        
        guard let tableViewController = tableViewController else { return }
        tableViewController.dataSource = tableViewController.initializeSongTitles()
        tableViewController.tableView.reloadData()
    }
        
    
    // MARK: - Actions
            
    @IBAction func unblurButtonPressed(_ sender: Any) {
    }
    
    @IBAction func hintButtonPressed(_ sender: Any) {
        hintBtn.setTitle(mediaPlayer.nowPlayingItem?.artist, for: .normal)
        print(hintBtn.titleLabel)
    }
    
    @IBAction func skipButtonPressed(_ sender: Any) {
        
        self.startSongShuffle()
//        self.progress()
//        self.mediaPlayer.skipToNextItem()
//        timez.invalidate()

        
        
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
