//
//  ViewController.swift
//  Testing App
//
//  Created by Hamza Ansari on 09/06/15.
//  Copyright (c) 2015 Thought Chimp. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {


  var videoID: String!
  var player:MPMoviePlayerController!
  var videoIds:[String?] = []
  var currentIndex = 0

  override func viewDidLoad() {
    super.viewDidLoad()
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "playNext", name: MPMoviePlayerPlaybackDidFinishNotification, object: nil)
  }
  
  @IBAction func fetch(sender: AnyObject) {
    
    let videoObject = PFQuery(className: "Video")
    videoObject.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
      if let objects = objects{
        for object in objects{
          
          let object  = object as! PFObject
          let video = object.objectForKey("videos") as! PFFile
          if let id = object.objectId{
            self.videoIds.append(id)
          }
          video.getDataInBackgroundWithBlock({ (data, error) -> Void in
            if let data = data{
              let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
              let documentsDirectory = paths[0] as! String
              let path = documentsDirectory + "/\(object.objectId!).mov"
              data.writeToFile(path, atomically: true)
              println("Saved\nPath \(path)")
              if self.currentIndex==0{
              self.playVideo()
              }
            }
          })
        }
      }
    }
    
  }
  
  func playNext(){
    if currentIndex < videoIds.count{
    playVideo()
    }else{
      currentIndex = 0
      playVideo()
    }
  }
  
  func playVideo(){
    if let id = videoIds[currentIndex]{
      currentIndex++
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
    let documentsDirectory = paths[0] as! String
    let path = documentsDirectory + "/\(id).mov"
      println("Path\n\n to play \(path)")
    player = MPMoviePlayerController(contentURL: NSURL(fileURLWithPath: path))
    player.prepareToPlay()
    player.view.frame = CGRect(x: 0, y: 20, width: 320, height: 320)
    view.addSubview(player.view)
    player.play()
    }
  }

}
