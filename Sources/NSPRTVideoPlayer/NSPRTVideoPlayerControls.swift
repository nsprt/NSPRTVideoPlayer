//
//  NSPRTVideoPlayerControls.swift
//  NSPRTVideoPlayer
//
//  Created by Chaz Woodall on 3/19/19.
//  Copyright © 2019 NSPRT. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import MediaPlayer

open class NSPRTVideoPlayerTimeLabel: UITextField {
    public var timeFormat: String = "HH:mm:ss"
    
    open func update(toTime: TimeInterval) {
        let date = Date(timeIntervalSince1970: toTime)
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.init(secondsFromGMT: 0)
        formatter.dateFormat = self.timeFormat
        text = formatter.string(from: date)
    }
}

open class NSPRTVideoPlayerControls: UIView {
    /// NSPRTVideoPlayer intance being controlled
    public weak var handler: NSPRTVideoPlayerView!
    
    /// NSPRTVideoPlayerControlsBehaviour being used to validate ui
    public var behaviour: NSPRTVideoPlayerControlsBehaviour!
    
    public var airplayButton: MPVolumeView?
    
    /// NSPRTVideoPlayerControlsCoordinator instance (WIP)
    public var controlsCoordinator: NSPRTVideoPlayerControlsCoordinator!
    
    /// NSPRTVideoPlayerStatefulButton instance to represent the play/pause button
    public var playPauseButton: NSPRTVideoPlayerStatefulButton = NSPRTVideoPlayerPlayPauseButton()
    
    /// NSPRTVideoPlayerStatefulButton instance to represent the fullscreen toggle button
    public var fullscreenButton: NSPRTVideoPlayerStatefulButton = NSPRTVideoPlayerFullscreenButton()
    
    /// NSPRTVideoPlayerStatefulButton instance to represent the audio toggle button
    public var audioButton: NSPRTVideoPlayerStatefulButton = NSPRTVideoPlayerAudioButton()
    
    /// NSPRTVideoPlayerStatefulButton instance to represent the PIP button (WIP)
    public var pipButton: NSPRTVideoPlayerStatefulButton?
    
    /// UIViewContainer to implement the airplay button (WIP)
    public var airplayContainer: UIView?
    
    /// NSPRTVideoPlayerStatefulButton instance to represent the rewind button (WIP)
    public var rewindButton: NSPRTVideoPlayerStatefulButton?
    
    /// NSPRTVideoPlayerStatefulButton instance to represent the forward button (WIP)
    public var forwardButton: NSPRTVideoPlayerStatefulButton?
    
    /// NSPRTVideoPlayerStatefulButton instance to represent the skip forward button
    public var skipForwardButton: NSPRTVideoPlayerStatefulButton = NSPRTVideoPlayerForwardButton()
    
    /// NSPRTVideoPlayerStatefulButton instance to represent the skip backward button
    public var skipBackwardButton: NSPRTVideoPlayerStatefulButton = NSPRTVideoPlayerRewindButton()
    
    /// NSPRTVideoPlayerSeekbarSlider instance to represent the seekbar slider
    public var seekbarSlider: NSPRTVideoPlayerSeekbarSlider = NSPRTVideoPlayerSeekbarSlider()
    
    /// NSPRTVideoPlayerLabel instance to represent the current time label (WIP)
    public var currentTimeLabel: NSPRTVideoPlayerTimeLabel?
    
    /// NSPRTVideoTimeLabel instance to represent the total time label (WIP)
    public var totalTimeLabel: NSPRTVideoPlayerTimeLabel?
    
    /// UIView to be shown when buffering (WIP)
    public var bufferingView: UIActivityIndicatorView? = UIActivityIndicatorView(style: .gray)
    
    /// UIImage showing brand over video
    public lazy var brandImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    public var brandImage: UIImage?
    
    private var wasPlayingBeforeRewinding: Bool = false
    private var wasPlayingBeforeForwarding: Bool = false
    private var wasPlayingBeforeSeeking: Bool = false
    
    /// Skip size in seconds to be used for skipping forward or backwards
    public var skipSize: Double = 10
    
    public convenience init(frame: CGRect = .zero, brandImage: UIImage) {
        self.init(frame: frame)
        self.brandImage = brandImage
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard self.handler.isPlaying else { return }
        self.behaviour.hide()
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.layoutInSuperview()
    }
    
    public func layoutInSuperview() {
        guard let h = superview as? NSPRTVideoPlayerControlsCoordinator else { return }
        self.handler = h.player
        if self.behaviour == nil {
            self.behaviour = NSPRTVideoPlayerControlsBehaviour(with: self)
        }
        
        self.prepare()
    }
    
    /// Notifies when time changes
    ///
    /// - Parameters:
    ///     - time: CMTime representation of the current playback time
    open func timeDidChange(toTime time: CMTime) {
        self.currentTimeLabel?.update(toTime: time.seconds)
        self.totalTimeLabel?.update(toTime: handler.player.endTime().seconds)
        self.setSeekbarSlider(start: handler.player.startTime().seconds, end: handler.player.endTime().seconds, at: time.seconds)

        guard !(self.handler.isSeeking || self.handler.isRewinding || self.handler.isForwarding) else { return }
        self.behaviour.update(with: time.seconds)
    }
    
    public func setSeekbarSlider(start startValue: Double, end endValue: Double, at time: Double) {
        self.seekbarSlider.minimumValue = Float(startValue)
        self.seekbarSlider.maximumValue = Float(endValue)
        self.seekbarSlider.value = Float(time)
    }
    
    /// Remove coordinator from player
    open func removeFromPlayer() {
        self.controlsCoordinator.removeFromSuperview()
    }
    
    /// Prepare controls targets and notification listeners
    open func prepare() {
        self.stretchToEdges()
    
        self.playPauseButton.addTarget(self, action: #selector(self.togglePlayback), for: .touchUpInside)
        self.fullscreenButton.addTarget(self, action: #selector(self.toggleFullscreen), for: .touchUpInside)
        self.audioButton.addTarget(self, action: #selector(self.toggleAudio), for: .touchUpInside)
        self.rewindButton?.addTarget(self, action: #selector(self.rewindToggle), for: .touchUpInside)
        self.forwardButton?.addTarget(self, action: #selector(self.forwardToggle), for: .touchUpInside)
        self.skipForwardButton.addTarget(self, action: #selector(self.skipForward), for: .touchUpInside)
        self.skipBackwardButton.addTarget(self, action: #selector(self.skipBackward), for: .touchUpInside)
        
        self.prepareSeekbar()
        
        if !AVPictureInPictureController.isPictureInPictureSupported() {
            self.pipButton?.alpha = 0.3
            self.pipButton?.isUserInteractionEnabled = false
        } else {
            self.pipButton?.addTarget(self, action: #selector(togglePip), for: .touchUpInside)
        }
        
        self.airplayButton = MPVolumeView()
        self.airplayButton?.showsVolumeSlider = false
        self.airplayContainer?.addSubview(self.airplayButton!)
        self.airplayContainer?.clipsToBounds = false
        self.airplayButton?.frame = self.airplayContainer?.bounds ?? CGRect.zero
        
        self.seekbarSlider.addTarget(self, action: #selector(self.playheadChanged), for: .valueChanged)
        self.seekbarSlider.addTarget(self, action: #selector(self.seekingEnd), for: .touchUpInside)
        self.seekbarSlider.addTarget(self, action: #selector(self.seekingEnd), for: .touchUpOutside)
        self.seekbarSlider.addTarget(self, action: #selector(self.seekingStart), for: .touchDown)
        
        self.prepareNotificationListener()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        self.stretchToEdges()
        self.layoutControls()
    }
    
    public func stretchToEdges() {
        guard let parent = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: parent.topAnchor),
            self.leftAnchor.constraint(equalTo: parent.leftAnchor),
            self.rightAnchor.constraint(equalTo: parent.rightAnchor),
            self.bottomAnchor.constraint(equalTo: parent.bottomAnchor)
            ])
    }
    
    private func layoutControls() {
        if let bufferingView = self.bufferingView {
            self.addSubview(bufferingView)
            bufferingView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                bufferingView.heightAnchor.constraint(equalToConstant: 50),
                bufferingView.widthAnchor.constraint(equalToConstant: 50),
                bufferingView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                bufferingView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
                ])
        }
        
        if let brandImage = self.brandImage {
            self.brandImageView.image = brandImage
            self.addSubview(self.brandImageView)
            self.brandImageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.brandImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
                self.brandImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
                self.brandImageView.heightAnchor.constraint(equalToConstant: 25),
                self.brandImageView.widthAnchor.constraint(equalToConstant: (25 / brandImage.size.height) * brandImage.size.width)
                ])
        }
        
        let size = frame.height / 3 > 100 ? 100 : frame.height / 3
        self.addSubview(self.playPauseButton)
        self.playPauseButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.playPauseButton.heightAnchor.constraint(equalToConstant: size),
            self.playPauseButton.widthAnchor.constraint(equalToConstant: size),
            self.playPauseButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.playPauseButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
        
        self.addSubview(self.skipBackwardButton)
        self.skipBackwardButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.skipBackwardButton.heightAnchor.constraint(equalToConstant: 35),
            self.skipBackwardButton.widthAnchor.constraint(equalToConstant: 35),
            self.skipBackwardButton.centerYAnchor.constraint(equalTo: self.playPauseButton.centerYAnchor),
            self.skipBackwardButton.rightAnchor.constraint(equalTo: self.playPauseButton.leftAnchor, constant: -40)
            ])
        
        self.addSubview(self.skipForwardButton)
        self.skipForwardButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.skipForwardButton.heightAnchor.constraint(equalToConstant: 35),
            self.skipForwardButton.widthAnchor.constraint(equalToConstant: 35),
            self.skipForwardButton.centerYAnchor.constraint(equalTo: self.playPauseButton.centerYAnchor),
            self.skipForwardButton.leftAnchor.constraint(equalTo: self.playPauseButton.rightAnchor, constant: 40)
            ])
        
        self.addSubview(self.seekbarSlider)
        self.seekbarSlider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.seekbarSlider.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40),
            self.seekbarSlider.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            self.seekbarSlider.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
        
        self.addSubview(self.fullscreenButton)
        self.fullscreenButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.fullscreenButton.heightAnchor.constraint(equalToConstant: 25),
            self.fullscreenButton.widthAnchor.constraint(equalToConstant: 25),
            self.fullscreenButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            self.fullscreenButton.bottomAnchor.constraint(equalTo: self.seekbarSlider.topAnchor, constant: -5)
            ])
        
        self.addSubview(self.audioButton)
        self.audioButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.audioButton.heightAnchor.constraint(equalToConstant: 25),
            self.audioButton.widthAnchor.constraint(equalToConstant: 25),
            self.audioButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            self.audioButton.centerYAnchor.constraint(equalTo: self.fullscreenButton.centerYAnchor)
            ])
    }
    
    /// Detect the notfication listener
    private func checkOwnershipOf(object: Any?, completion: @autoclosure ()->()?) {
        guard let ownerPlayer = object as? NSPRTVideoPlayer else { return }
        guard ownerPlayer.isEqual(self.handler?.player) else { return }
        completion()
    }
    
    /// Prepares the notification observers/listeners
    open func prepareNotificationListener() {
        NotificationCenter.default.addObserver(forName: NSPRTVideoPlayer.PlayerNotificationName.timeChanged.notification, object: nil, queue: OperationQueue.main) { [weak self] (notification) in
            guard let self = self else { return }
            guard let time = notification.userInfo?[NSPRTVideoPlayer.PlayerNotificationInfoKey.time.rawValue] as? CMTime else { return }
            self.checkOwnershipOf(object: notification.object, completion: self.timeDidChange(toTime: time))
        }
        NotificationCenter.default.addObserver(forName: NSPRTVideoPlayer.PlayerNotificationName.didEnd.notification, object: nil, queue: OperationQueue.main) { [weak self] (notification) in
            guard let self = self else { return }
            self.checkOwnershipOf(object: notification.object, completion: self.playPauseButton.set(active: false))
            self.handler.onStart = false
        }
        NotificationCenter.default.addObserver(forName: NSPRTVideoPlayer.PlayerNotificationName.play.notification, object: nil, queue: OperationQueue.main) { [weak self]  (notification) in
            guard let self = self else { return }
            self.checkOwnershipOf(object: notification.object, completion: self.playPauseButton.set(active: true))
        }
        NotificationCenter.default.addObserver(forName: NSPRTVideoPlayer.PlayerNotificationName.pause.notification, object: nil, queue: OperationQueue.main) {[weak self] (notification) in
            guard let self = self else { return }
            self.checkOwnershipOf(object: notification.object, completion: self.playPauseButton.set(active: false))
        }
        NotificationCenter.default.addObserver(forName: NSPRTVideoPlayer.PlayerNotificationName.endBuffering.notification, object: nil, queue: OperationQueue.main) {[weak self] (notification) in
            guard let self = self else { return }
            self.checkOwnershipOf(object: notification.object, completion: self.hideBuffering())
        }
        NotificationCenter.default.addObserver(forName: NSPRTVideoPlayer.PlayerNotificationName.buffering.notification, object: nil, queue: OperationQueue.main) {[weak self] (notification) in
            guard let self = self else { return }
            self.checkOwnershipOf(object: notification.object, completion: self.showBuffering())
        }
    }
    
    /// Prepare the seekbar values
    open func prepareSeekbar() {
        self.setSeekbarSlider(start: self.handler.player.startTime().seconds, end: self.handler.player.endTime().seconds, at: self.handler.player.currentTime().seconds)
    }
    
    /// Show buffering view
    open func showBuffering() {
        self.bufferingView?.startAnimating()
        self.bufferingView?.isHidden = false
    }
    
    /// Hide buffering view
    open func hideBuffering() {
        self.bufferingView?.stopAnimating()
        self.bufferingView?.isHidden = true
    }
    
    /// Skip forward (n) seconds in time
    @objc open func skipForward(sender: Any? = nil) {
        let time = self.handler.player.currentTime() + CMTime(seconds: skipSize, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        self.handler.player.seek(to: time)
    }
    
    /// Skip backward (n) seconds in time
    @objc open func skipBackward(sender: Any? = nil) {
        let time = self.handler.player.currentTime() - CMTime(seconds: skipSize, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        self.handler.player.seek(to: time)
    }
    
    /// End seeking
    @objc open func seekingEnd(sender: Any? = nil) {
        self.handler.isSeeking = false
        guard self.wasPlayingBeforeSeeking else { return }
        self.handler.play()
    }
    
    /// Start Seeking
    @objc open func seekingStart(sender: Any? = nil) {
        self.wasPlayingBeforeSeeking = self.handler.isPlaying
        self.handler.isSeeking = true
        self.handler.pause()
    }
    
    /// Playhead changed in UISlider
    ///
    /// - Parameters:
    ///     - sender: UISlider that updated
    @objc open func playheadChanged(with sender: UISlider) {
        self.handler.isSeeking = true
        let value = Double(sender.value)
        let time = CMTime(seconds: value, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        self.handler.player.seek(to: time)
        self.behaviour.update(with: time.seconds)
    }
    
    /// Toggle PIP mode
    @objc open func togglePip() {
        self.handler.setNativePip(enabled: !self.handler.isPipModeEnabled)
    }
    
    /// Toggle fullscreen mode
    @objc open func toggleFullscreen(sender: Any? = nil) {
        self.fullscreenButton.set(active: !self.handler.isFullscreenModeEnabled)
        self.handler.setFullscreen(enabled: !self.handler.isFullscreenModeEnabled)
    }
    
    /// Toggle audio
    @objc open func toggleAudio(sender: Any? = nil) {
        if !self.handler.isMuted {
            self.audioButton.set(active: false)
            self.handler.player.volume = 0.0
            self.handler.isMuted = true
        } else {
            self.audioButton.set(active: true)
            self.handler.player.volume = 1.0
            self.handler.isMuted = false
        }
    }
    
    /// Toggle playback
    @objc open func togglePlayback(sender: Any? = nil) {
        if self.handler.isRewinding || self.handler.isForwarding {
            self.handler.player.rate = 1
            self.playPauseButton.set(active: true)
            return
        }
        if self.handler.isPlaying {
            self.playPauseButton.set(active: false)
            self.handler.pause()
        } else {
            guard self.handler.playbackDelegate?.playbackShouldBegin(player: self.handler.player) ?? true else { return }
            self.playPauseButton.set(active: true)
            self.handler.play()
        }
    }
    
    /// Toggle rewind
    @objc open func rewindToggle(sender: Any? = nil) {
        if self.handler.player.currentItem?.canPlayFastReverse ?? false {
            if self.handler.isRewinding {
                self.rewindButton?.set(active: false)
                self.handler.player.rate = 1
                self.wasPlayingBeforeRewinding ? self.handler.play() : self.handler.pause()
            } else {
                self.playPauseButton.set(active: false)
                self.rewindButton?.set(active: true)
                self.wasPlayingBeforeRewinding = self.handler.isPlaying
                if !self.handler.isPlaying {
                    self.handler.play()
                }
                self.handler.player.rate = -1
            }
        }
    }
    
    /// Forward toggle
    @objc open func forwardToggle(sender: Any? = nil) {
        if self.handler.player.currentItem?.canPlayFastForward ?? false {
            if self.handler.isForwarding {
                self.forwardButton?.set(active: false)
                self.handler.player.rate = 1
                self.wasPlayingBeforeForwarding ? self.handler.play() : self.handler.pause()
            } else {
                self.playPauseButton.set(active: false)
                self.forwardButton?.set(active: true)
                self.wasPlayingBeforeForwarding = self.handler.isPlaying
                if !self.handler.isPlaying {
                    self.handler.play()
                }
                self.handler.player.rate = 2
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSPRTVideoPlayer.PlayerNotificationName.timeChanged.notification, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSPRTVideoPlayer.PlayerNotificationName.play.notification, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSPRTVideoPlayer.PlayerNotificationName.pause.notification, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSPRTVideoPlayer.PlayerNotificationName.buffering.notification, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSPRTVideoPlayer.PlayerNotificationName.endBuffering.notification, object: nil)
    }
}
