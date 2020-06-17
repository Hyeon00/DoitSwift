//
//  ViewController.swift
//  Audio
//
//  Created by 임성현 on 2020/06/16.
//  Copyright © 2020 임성현. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    var audioPlayer: AVAudioPlayer!
    var audioFile: URL!
    let MAX_VOLUME: Float = 10.0
    var progressTimer: Timer!
    let timePlayerSelector: Selector = #selector(ViewController.updatePlayTime)

    @IBOutlet var pvProgressPlay: UIProgressView!
    
    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblEndTime: UILabel!
    
    @IBOutlet var btnPlay: UIButton!
    @IBOutlet var btnPause: UIButton!
    @IBOutlet var btnStop: UIButton!
    
    @IBOutlet var slVolume: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        audioFile = Bundle.main.url(forResource: "Sicilian_Breeze", withExtension: "mp3")
        initPlay()
    }
    
    // 오디오 재생을 위한 초기화 함수.
    func initPlay() -> Void {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile)
        } catch let error as NSError {
            print("Error-initPlay: \(error)")
        }
        // 볼륨 및 프로그레스 뷰 진행 상황 초기화.
        slVolume.maximumValue = MAX_VOLUME
        slVolume.value = 1.0
        pvProgressPlay.progress = 0
        // 오디오 초기화
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
        audioPlayer.volume = slVolume.value
        // 재생 시간 초기화
        lblEndTime.text = convertNSTimeInterval2String(audioPlayer.duration)
        lblCurrentTime.text = convertNSTimeInterval2String(0)
        // 버튼 제어.
        setPlayButtons(true, pause: false, stop: false)
    }
    
    // 버튼 제어 함수.
    func setPlayButtons(_ play:Bool, pause: Bool, stop: Bool) -> Void {
        btnPlay.isEnabled = play
        btnPause.isEnabled = pause
        btnStop.isEnabled = stop
    }
    
    // 재생 시간 초기화 함수.
    func convertNSTimeInterval2String(_ time: TimeInterval) -> String {
        let min = Int(time/60)      // 몫
        let sec = Int(time.truncatingRemainder(dividingBy: 60))     // 나머지
        let strTime = String(format: "%02d:%02d", min, sec)
        return strTime
    }

    @IBAction func btnPlayAudio(_ sender: UIButton) {
        audioPlayer.play()
        setPlayButtons(false, pause: true, stop: true)
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil , repeats: true)
    }
    
    @objc func updatePlayTime() -> Void {
        lblCurrentTime.text = convertNSTimeInterval2String(audioPlayer.currentTime)
        pvProgressPlay.progress = Float(audioPlayer.currentTime/audioPlayer.duration)
    }
    
    @IBAction func btnPauseAudio(_ sender: UIButton) {
        audioPlayer.pause()
        setPlayButtons(true, pause: false, stop: true)
    }
    
    @IBAction func btnStopAudio(_ sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        lblCurrentTime.text = convertNSTimeInterval2String(0)
        setPlayButtons(true, pause: false, stop: false)
        progressTimer.invalidate()      // 타이머 무효화
    }
    
    @IBAction func slChangeVolume(_ sender: UISlider) {
        audioPlayer.volume = slVolume.value
    }
    
    // 오디오 재생이 끝났을 때의 함수.
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        progressTimer.invalidate()
        setPlayButtons(true, pause: false, stop: false)
    }
}

