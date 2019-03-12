//
//  tweetCellTableViewCell.swift
//  Twitter
//
//  Created by user150601 on 3/4/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class tweetCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func retweetTweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetID: tweetID, success: {
            self.setRetweeted(true)
        }, failure: { (Error) in
            print("Error is retweeting: \(Error)")
        })
    }
    
    
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if (toBeFavorited) {
            TwitterAPICaller.client?.favTweet(tweetID: tweetID, success: {
                self.setFavorite(true)
            }, failure: { (Error) in
                print("Favorite did not succeed: \(Error)")
            })
        } else {
            TwitterAPICaller.client?.unfavTweet(tweetID: tweetID, success: {
                self.setFavorite(false)
            }, failure: { (Error) in
                print("unFavorite did not succeed: \(Error)")
            })
        }
        
    }
    
    var favorited:Bool = false
    var tweetID:Int = -1
    
    
    func setRetweeted(_ isRetweeted:Bool) {
        if (isRetweeted) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    func setFavorite(_ isFavorited:Bool) {
    favorited = isFavorited
        if(favorited){
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else {
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
}
