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
    
//   *** Buttons for Play ***
    
    @IBOutlet weak var buttonOne: UIButton!
    
    @IBOutlet weak var buttonTwo: UIButton!
    
    @IBOutlet weak var buttonThree: UIButton!
    
    @IBOutlet weak var buttonFour: UIButton!
    
//   *** end buttons ***
    
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
           let timeLimit = 5.0

             // Add a playback queue containing all songs on the device
             mediaPlayer.setQueue(with: .songs())

             // Start playing from the beginning of the queue
             mediaPlayer.play()

        
         Timer.scheduledTimer(withTimeInterval: timeLimit, repeats: true) { (timer) in
                 //   self.mediaPlayer.stop()
            
            //            ************TRYING TO REGEX************
            do {
                let input: String! = self.mediaPlayer.nowPlayingItem?.title
                
                        let regex = try NSRegularExpression(pattern: "(.*)", options: NSRegularExpression.Options.caseInsensitive)
                        let matches = regex.matches(in: input!, options: [], range: NSRange(location: 0, length: input.utf16.count))
            
                        if let match = matches.first {
                            let range = match.range(at:1)
                            if let titleRange = Range(range, in: input) {
                                let name = input[titleRange]
                                

                                let alert = UIAlertController(title: "Song", message: " \(name) by \(name)", preferredStyle: .alert)

                                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

                                self.present(alert, animated: true)
                            }
                        }
                    } catch {
                        // CATCH NEEDED!
                    }
                       //           ************STOP TRYING************
            
//           Ai Commented out below and moved all into above 😬
            
//             let alert = UIAlertController(title: "Song", message: " \(String(describing: self.mediaPlayer.nowPlayingItem!.title))", preferredStyle: .alert)
            
//              let alert = UIAlertController(title: "Song", message: " \(name))", preferredStyle: .alert)
//
//             alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//
//             self.present(alert, animated: true)
        

             print("Title: //\(String(describing: self.mediaPlayer.nowPlayingItem?.title))")
            
            //get songs
                 var query = MPMediaQuery.songs()
                 print("query is \(query)")
                 //
                 var collection = MPMediaItemCollection(items: query.items!)
                 let player = MPMusicPlayerController.applicationMusicPlayer

                 player.setQueue(with:collection)
                 let playcount:Int! = collection.items.count
                 let rando = Int.random(in:1..<playcount)
                 print("how many? \(collection.items.count) and whats rando? \(rando)")

                 print("random song🪕: \(collection.items[rando].title) by \(collection.items[rando].artist)")
            
             //            ***Generate the buttons***
            self.buttonOne.setTitle(collection.items[rando].title, for:.normal)
            self.mediaPlayer.skipToNextItem()

         }
        
        // Print the now-playing item, need to write recursive func that calls until loaded
//        print("🤢Title: \(mediaPlayer.nowPlayingItem?.artwork), Artist: \(mediaPlayer.nowPlayingItem?.artist)")
        
     
    }
    
    // MARK: - Actions
    
    //            ***Generate the buttons***
                
    @IBAction func btnOne(_ sender: Any) {
        var guess: String! = buttonOne.titleLabel?.text
        print("button one is",guess)
        var song = mediaPlayer.nowPlayingItem?.title
        print("song is", song)
        if guess == song {
            buttonOne.backgroundColor = UIColor.green
            print("BINGO🌟")
        } else {
            buttonOne.backgroundColor = UIColor.red
            print("nopes😵")
        }
    }
    
                
    //            ***end button Fns***
    
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
