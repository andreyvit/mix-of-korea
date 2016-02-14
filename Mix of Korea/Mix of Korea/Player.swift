import Foundation
import AVFoundation

public class Player: NSObject {

    private let debugName: String

    private var avplayer: AVPlayer?
    private var avitem: AVPlayerItem?

    public init(debugName: String) {
        self.debugName = debugName

        super.init()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDidPlayToEndTime:", name: AVPlayerItemDidPlayToEndTimeNotification, object: nil)
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    public override var description: String {
        return "Player(\(debugName))"
    }

    public func startPlaying(url: NSURL) {
        print("\(self): startPlaying for \(url.absoluteString)")

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

