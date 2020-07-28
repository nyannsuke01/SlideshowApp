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

    }

    @objc func updateTimer(_ timer: Timer) {
        self.timer_sec += 2.0
        print(timer_sec)
        //冗長化を防ぎたい
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
        print("画像がタップされました")
        performSegue(withIdentifier: "showPicture", sender: nil)
    }

    @IBAction func goNext(_ sender: Any) {
        if imagePictureCount < imagePictureArray.count - 1 {
            imagePictureCount += 1
            changeImage()
        } else {
            imagePictureCount = 0
            changeImage()
        }
    }

    @IBAction func goBack(_ sender: Any) {
        //配列の個数のカウント
        if imagePictureCount > 0 {
            imagePictureCount -= 1
            changeImage()
        } else {
            imagePictureCount = imagePictureArray.count - 1
            changeImage()
        }
    }

    @IBAction func playAndPause(_ sender: Any) {

        if playAndPauseFlag == 0 {
            //自動送りの間は、進むボタンと戻るボタンはタップ不可にしてください
            nextButton.isEnabled = false
            backButton.isEnabled = false
            //再生停止フラグ 停止:「0」再生:「1」
            playAndPauseFlag = 1

            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
        } else {
            //自動送りの間は、進むボタンと戻るボタンはタップ不可にしてください
            nextButton.isEnabled = true
            backButton.isEnabled = true
            //再生停止フラグ 停止:「0」再生:「1」
            playAndPauseFlag = 0
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

