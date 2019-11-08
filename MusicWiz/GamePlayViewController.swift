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
    
    
    let defaults = UserDefaults.standard
    
    // MARK: - IBOutlet References
//    ? is guard rails for accessing a value that may or may not be
    @IBOutlet weak var navigationBar: UINavigationItem?
    
    @IBOutlet weak var scoreBoard: UILabel!
    @IBOutlet weak var timerView: UIView?
    @IBOutlet weak var totalScore: UILabel!
    
    @IBOutlet weak var albumImageView: UIImageView?
    
//blur stuff 🐷
    let visualEffectView = UIVisualEffectView(effect:UIBlurEffect(style: UIBlurEffect.Style.extraLight))
//    play with the last value in style for more blur options
    
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
        defaults.set(500, forKey: "currentScore")
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
    }
    
        @objc func updateTimer() {
            
            
            if secondsPassed < totalTime {
                secondsPassed += 1
                progressBar.progress = Float(secondsPassed) / Float(totalTime)
                var updatedScore = defaults.integer(forKey: "currentScore") - 10
                defaults.set(updatedScore, forKey: "currentScore")
                scoreBoard.text = String(defaults.integer(forKey: "currentScore"))
                print(Float(secondsPassed) / Float(totalTime))
            } else {
                let timeUp = defaults.integer(forKey: "totalScore") - 80
                defaults.set(timeUp, forKey: "totalScore")
                timer.invalidate()
    
            }
        }
    
//   *** Buttons for Play ***
    

    
//   *** end buttons ***
    
    
    // MARK: - Override Methods
    
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // If correct, highlight green then move to the next song
        if let songTitle = tableView.dataSource[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath)
        if songTitle == mediaPlayer?.nowPlayingItem?.title {
            // user got it right
            var updateScore = defaults.integer(forKey: "totalScore") + defaults.integer(forKey: "currentScore")
            defaults.set(updateScore, forKey: "totalScore")
            totalScore.text = String(updateScore)
            cell?.backgroundColor = .green
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaults.set(500, forKey: "currentScore")
        defaults.set(500, forKey: "totalScore")
        totalScore.text = String(defaults.integer(forKey: "totalScore"))
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
            
            
//         ******   blurrr 🐷*****
            visualEffectView.alpha = 0.8
//            ☝️play with alpha values for blurriness
            view.addSubview(visualEffectView)
            visualEffectView.frame = albumImageView.frame
//        *******    end blurrrr *****
            
            
        } else {
            albumImageView.image = UIImage(named: "defaultArtwork")
        }
        
        guard let tableViewController = tableViewController else { return }
        tableViewController.dataSource = tableViewController.initializeSongTitles()
        tableViewController.tableView.reloadData()
    }
        
    
    // MARK: - Actions

    @IBAction func unblurButtonPress(_ sender: Any) {
        var newCurrent = defaults.integer(forKey: "totalScore") - 50
        defaults.set(newCurrent, forKey: "totalScore")
        totalScore.text = String(newCurrent)
//        print("you pressed blur")🐷
        visualEffectView.removeFromSuperview()
    }
    
    @IBAction func hintButtonPressed(_ sender: Any) {
        hintBtn.setTitle(mediaPlayer.nowPlayingItem?.artist, for: .normal)
        var newCurrent = defaults.integer(forKey: "totalScore") - 50
        defaults.set(newCurrent, forKey: "totalScore")
        totalScore.text = String(newCurrent)
        
    }
    
    @IBAction func skipButtonPressed(_ sender: Any) {
        var newCurrent = defaults.integer(forKey: "totalScore") - 100
        defaults.set(newCurrent, forKey: "totalScore")
        totalScore.text = String(newCurrent)
        self.startSongShuffle()
        defaults.set(500, forKey: "currentScore")
        
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tableViewController = segue.destination as? SongTableViewController {
            self.tableViewController = tableViewController
            tableViewController.mediaPlayer = mediaPlayer
        }
    }
    
}

