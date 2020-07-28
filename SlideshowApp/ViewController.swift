//
//  ViewController.swift
//  SlideshowApp
//
//  Created by user on 2020/07/26.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var playAndPauseButton: UIButton!
    
    //画像を配列に格納
    var imagePictureArray: Array = ["0","1","2","3","4","5"]
    //imageViewのカウンター
    var imagePictureCount = 0
    //タイマー
    var timer: Timer!
    //タイマー用の時間のための変数
    var timer_sec: Float = 0
    //再生/停止フラグ　(停止:0　再生:1)
    var playAndPauseFlag = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        //画像の取り込み
        let image = UIImage(named: "0")
        slideImageView.image = image
        //再生ボタンとしてセット
        playAndPauseButton.setTitle("再生", for: .normal)
    }
    
    @objc func updateTimer(_ timer: Timer) {
        //計測用
        self.timer_sec += 2.0
        print(timer_sec)
        //次の画像に移る　最後の画像の次は最初の画像に戻る。
        if imagePictureCount < imagePictureArray.count - 1 {
            imagePictureCount += 1
            changeImage()
        } else {
            imagePictureCount = 0
            changeImage()
        }
    }
    
    func changeImage() {
        let name = imagePictureArray[imagePictureCount]
        let image = UIImage(named: name)
        slideImageView.image = image
    }
    
    @IBAction func tapImage(_ sender: Any) {
        performSegue(withIdentifier: "showPicture", sender: nil)
        stopSlide()
    }
    
    @IBAction func goNext(_ sender: Any) {
        //次の画像に移る　最後の画像で押されたら、最初の画像に戻る
        if imagePictureCount < imagePictureArray.count - 1 {
            imagePictureCount += 1
            changeImage()
        } else {
            imagePictureCount = 0
            changeImage()
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        //前のスライドに戻る　最初の画像で押されたら、最後の画像に移る
        if imagePictureCount > 0 {
            imagePictureCount -= 1
            changeImage()
        } else {
            imagePictureCount = imagePictureArray.count - 1
            changeImage()
        }
    }
    
    @IBAction func playAndPause(_ sender: Any) {
        //再生停止フラグ 停止:「0」中であれば再生、再生:「1」中であれば停止
        if playAndPauseFlag == 0 {
            playSlide()
        } else {
            stopSlide()
        }
    }
    
    func playSlide() {
        //進むボタンと戻るボタンを非活性
        nextButton.isEnabled = false
        backButton.isEnabled = false
        //再生停止フラグ 停止:「0」再生:「1」
        playAndPauseFlag = 1
        //停止ボタンにする
        playAndPauseButton.setTitle("停止", for: .normal)
        //タイマーを２秒毎にセット
        self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
    }
    
    func stopSlide() {
        //進むボタンと戻るボタンを活性化
        nextButton.isEnabled = true
        backButton.isEnabled = true
        //再生停止フラグ 停止:「0」再生:「1」
        playAndPauseFlag = 0
        //再生ボタンにする
        playAndPauseButton.setTitle("再生", for: .normal)
        //タイマーが動いていたら
        if self.timer != nil {
            //タイマー停止
            self.timer.invalidate()
        }
    }
    
    //遷移と共に画像を渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let showPictureVC = segue.destination as? ShowPictureViewController
        showPictureVC?.resultImage = slideImageView.image!
    }
}

