
import Foundation
import UIKit
import MediaPlayer
import Jukebox

class PodcastPlayer: UIViewController, JukeboxDelegate {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var replayButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var centerContainer: UIView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    
    var jukebox : Jukebox!
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var url = ""
    var podcastTitle = ""
    var playTinted = UIImage()
    var pauseTinted = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        UIApplication.shared.beginReceivingRemoteControlEvents()
        
        jukebox = Jukebox(delegate: self, items: [
            JukeboxItem(URL: URL(string: url)!)])!
        titleLabel.text = podcastTitle
        
        if (podcastTitle.hasPrefix("Sunday Worship")){
            imageView.image = UIImage(named: "worship.png")
        }else{
            imageView.image = UIImage(named: "sermon.jpg")
        }
        
        let rewindImage = UIImage(named: "replaybutton.png");
        let rewindTinted = rewindImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        replayButton.setImage(rewindTinted, for: .normal)
        replayButton.tintColor = UIColor(red: 0/255, green: 128/255, blue: 255/255, alpha: 1.0)
        
        let stopImage = UIImage(named: "stopbutton.png");
        let stopTinted = stopImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        stopButton.setImage(stopTinted, for: .normal)
        stopButton.tintColor = UIColor(red: 0/255, green: 128/255, blue: 255/255, alpha: 1.0)
        
        let playImage = UIImage(named: "playbutton.png");
        playTinted = (playImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate))!
        playPauseButton.setImage(playTinted, for: .normal)
        playPauseButton.tintColor = UIColor(red: 0/255, green: 128/255, blue: 255/255, alpha: 1.0)
        
        let pauseImage = UIImage(named: "pausebutton.png");
        pauseTinted = (pauseImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate))!

    }
    
    func dismissPlayer(){
        jukebox.stop()
        self.dismiss(animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden : Bool {
        return false
    }
    
    func configureUI ()
    {
        resetUI()
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 64))
        let navigationItem = UINavigationItem()
        navigationItem.title = podcastTitle
        navBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir-Light", size: 15.0)!]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: nil, action: #selector(dismissPlayer))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.gray
        navBar.items = [navigationItem]
        self.view.addSubview(navBar)
        
        slider.setThumbImage(UIImage(named: "sliderThumb"), for: UIControlState())
        
        centerContainer.layer.cornerRadius = 12
    }
    
    func jukeboxDidLoadItem(_ jukebox: Jukebox, item: JukeboxItem) {
        print("Jukebox did load: \(item.URL.lastPathComponent)")
    }
    
    func jukeboxPlaybackProgressDidChange(_ jukebox: Jukebox) {
        
        if let currentTime = jukebox.currentItem?.currentTime, let duration = jukebox.currentItem?.meta.duration {
            let value = Float(currentTime / duration)
            slider.value = value
            populateLabelWithTime(currentTimeLabel, time: currentTime)
            populateLabelWithTime(durationLabel, time: duration)
        } else {
            resetUI()
        }
    }
    
    func jukeboxStateDidChange(_ jukebox: Jukebox) {
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.indicator.alpha = jukebox.state == .loading ? 1 : 0
            self.playPauseButton.alpha = jukebox.state == .loading ? 0 : 1
            self.playPauseButton.isEnabled = jukebox.state == .loading ? false : true
        })
        
        if jukebox.state == .ready {
            playPauseButton.setImage(playTinted, for: UIControlState())
        } else if jukebox.state == .loading  {
            playPauseButton.setImage(pauseTinted, for: UIControlState())
        } else {
            volumeSlider.value = jukebox.volume
            let imageName: String
            switch jukebox.state {
            case .playing, .loading:
                imageName = "pausebutton.png"
            case .paused, .failed, .ready:
                imageName = "playbutton.png"
            }
            if (imageName == "pausebutton.png"){
                playPauseButton.setImage(pauseTinted, for: UIControlState())
            }else{
                playPauseButton.setImage(playTinted, for: UIControlState())
            }
        }
        
        print("Jukebox state changed to \(jukebox.state)")
    }
    
    func jukeboxDidUpdateMetadata(_ jukebox: Jukebox, forItem: JukeboxItem) {
        print("Item updated:\n\(forItem)")
    }
    
    
    override func remoteControlReceived(with event: UIEvent?) {
        if event?.type == .remoteControl {
            switch event!.subtype {
            case .remoteControlPlay :
                jukebox.play()
            case .remoteControlPause :
                jukebox.pause()
            case .remoteControlNextTrack :
                jukebox.playNext()
            case .remoteControlPreviousTrack:
                jukebox.playPrevious()
            case .remoteControlTogglePlayPause:
                if jukebox.state == .playing {
                    jukebox.pause()
                } else {
                    jukebox.play()
                }
            default:
                break
            }
        }
    }
    
    @IBAction func volumeSliderValueChanged() {
        if let jk = jukebox {
            jk.volume = volumeSlider.value
        }
    }
    
    @IBAction func progressSliderValueChanged() {
        if let duration = jukebox.currentItem?.meta.duration {
            jukebox.seek(toSecond: Int(Double(slider.value) * duration))
        }
    }
    
    @IBAction func playPauseAction() {
        switch jukebox.state {
            case .ready :
                jukebox.play(atIndex: 0)
            case .playing :
                jukebox.pause()
            case .paused :
                jukebox.play()
            default:
                jukebox.stop()
        }
    }
    
    @IBAction func replayAction() {
        resetUI()
        jukebox.replay()
        
    }
    
    @IBAction func stopAction() {
        resetUI()
        jukebox.stop()
    }
        
    func populateLabelWithTime(_ label : UILabel, time: Double) {
        let minutes = Int(time / 60)
        let seconds = Int(time) - minutes * 60
        
        label.text = String(format: "%02d", minutes) + ":" + String(format: "%02d", seconds)
    }
    
    
    func resetUI()
    {
        durationLabel.text = "00:00"
        currentTimeLabel.text = "00:00"
        slider.value = 0
    }
}

