//
//  SongTableViewController.swift
//  MusicWiz
//
//  Created by Adriana Graybill on 11/6/19.
//  Copyright © 2019 Adriana Graybill. All rights reserved.
//


import UIKit
import MediaPlayer

class SongTableViewController: UITableViewController {
    
    var defaults = UserDefaults.standard
    var mediaPlayer: MPMusicPlayerApplicationController?
    
    var dataSource = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
    
    func initializeSongTitles() -> [String] {
        var titles = [String]()
        
        // We want the correct title to be in there
        if let title = mediaPlayer?.nowPlayingItem?.title {
            titles.append(title)
        }
        
        // Generate three other random songs
        let songs = MPMediaQuery.songs()
        
        for _ in 0..<3 {
            if let title = songs.items?.randomElement()?.title {
                titles.append(title)
            }
        }
        
        return titles.shuffled()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)

        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
//    this is the code that will helps us select the song.
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // If correct, highlight green then move to the next song
    let songTitle = dataSource[indexPath.row]
    let cell = tableView.cellForRow(at: indexPath)
        cell?.selectionStyle = .none
        
    
//        mediaPlayer?.skipToNextItem()
        
    if songTitle == mediaPlayer?.nowPlayingItem?.title {
        // user got it right
            UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                cell?.backgroundColor = .green
                    }, completion: {
                        (finished: Bool) -> Void in
             // Fade in
                UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                    cell?.backgroundColor = .clear
                     }, completion: nil)
                        self.mediaPlayer?.skipToNextItem()
            }) }else {
                UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                    cell?.backgroundColor = .red
                        }, completion: {
                            (finished: Bool) -> Void in
           
               // Fade in
                        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                            cell?.backgroundColor = .clear
                             }, completion: nil)
                            self.mediaPlayer?.skipToNextItem()

                })
        var updateScore = defaults.integer(forKey: "totalScore") + defaults.integer(forKey: "currentScore")
            defaults.set(updateScore, forKey: "totalScore")
            tableView.reloadRows(at: [indexPath], with: .none)
//        self.mediaPlayer?.skipToNextItem()


        }
            }
    
    
        
        }
    
    

        
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


