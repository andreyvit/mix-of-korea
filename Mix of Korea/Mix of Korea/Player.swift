import Foundation
import AVFoundation

public class Player: NSObject {

    public static let instance = Player()

    private var avplayer: AVPlayer?
    private var avitem: AVPlayerItem?

    public override init() {
        super.init()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDidPlayToEndTime:", name: AVPlayerItemDidPlayToEndTimeNotification, object: nil)
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    public func initializeAudioSession() {
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayback)
        try! session.setActive(true)
//        do {
//        } catch let e {
//            print("Failed: \(e)")
//        }
    }

    public func startPlaying() {
        print("startPlaying")
        initializeAudioSession()

        let url = NSBundle.mainBundle().URLForResource("podfm_golos-korei_northk_318.mp3", withExtension: nil)!
        let asset = AVAsset(URL: url)
        let avitem = AVPlayerItem(asset: asset)
        self.avitem = avitem
        let avplayer = AVPlayer(playerItem: avitem)
        self.avplayer = avplayer
        avplayer.addObserver(self, forKeyPath: "status", options: [], context: nil)
        avitem.addObserver(self, forKeyPath: "status", options: [], context: nil)
        print("avplayer.rate == \(avplayer.rate)")
        avplayer.play()
        print("avplayer.rate == \(avplayer.rate)")
    }

    public override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        print("value did change for \(keyPath) of \(object)")
    }

    @objc private func itemDidPlayToEndTime(notification: NSNotification) {
        print("Did play to end time")
    }

}

