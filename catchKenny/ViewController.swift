//
//  ViewController.swift
//  catchKenny
//
//  Created by Emre Köseoğlu on 5.07.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var timerText: UILabel!
    @IBOutlet var highscoreText: UILabel!
    @IBOutlet var scoreText: UILabel!

    @IBOutlet var image_view: UIImageView!
    var timer = Timer()
    var timer2 = Timer()
    var counter = 10
    var randomWidth: Double = 120
    var randomHeight: Double = 240
    var score = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        counter = 10
        timerText.text = "\(counter)"
        image_view.frame = CGRect(x: randomWidth, y: randomHeight, width: 120, height: 120)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onImageTap))

        highscoreText.text = "Highscore: \(UserDefaults.standard.integer(forKey: "score"))"

        image_view.isUserInteractionEnabled = true
        image_view.addGestureRecognizer(tapGesture)
    }

    override func viewDidAppear(_: Bool) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(showDialog), userInfo: self, repeats: true)

        timer2 = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(setImageLocation), userInfo: self, repeats: true)
    }

    @objc func onImageTap() {
        score += 1
        scoreText.text = "Score: \(score)"
    }

    @objc func setImageLocation() {
        let maxWidth = view.frame.width - 120
        randomWidth = Double.random(in: 120 ..< maxWidth)
        randomHeight = Double.random(in: 240 ..< 540)
        image_view.frame = CGRect(x: randomWidth, y: randomHeight, width: 120, height: 120)
    }

    @objc func showDialog() {
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            _ in
            self.counter = 10
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.showDialog), userInfo: self, repeats: true)
            self.timer2 = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.setImageLocation), userInfo: self, repeats: true)
        }
        counter -= 1
        timerText.text = "\(counter)"
        if counter == 0 {
            timer.invalidate()
            timer2.invalidate()
            let alert = UIAlertController(title: "Time's Up", message: "Dou you want to play again", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(okAction)

            present(alert, animated: true, completion: nil)
            if score > UserDefaults.standard.integer(forKey: "score") {
                UserDefaults.standard.set(score, forKey: "score")
                highscoreText.text = "Highscore: \(score)"
            }
        }
    }
}
