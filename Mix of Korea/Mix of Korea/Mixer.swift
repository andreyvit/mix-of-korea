import Foundation
import AVFoundation

public class Mixer {

    public static let instance = Mixer()

    private let radioPlayer = Player(debugName: "Radio")
    private let musicPlayer = Player(debugName: "Music")

    private var playing = false

    public func activateAudioSession() {
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayback)
        try! session.setActive(true)
        //        do {
        //        } catch let e {
        //            print("Failed: \(e)")
        //        }
    }

    public func startPlaying() {
        if playing {
            return
        }

        playing = true

        let url = NSBundle.mainBundle().URLForResource("podfm_golos-korei_northk_318.mp3", withExtension: nil)!
        radioPlayer.startPlaying(url)
    }

}