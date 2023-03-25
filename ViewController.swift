//
//  ViewController.swift
//  FareYakala
//
//  Created by ELANUR KIZILAY on 19.03.2023.
//

import UIKit

class ViewController: UIViewController {
    //variable
    var timer = Timer()
    var hideTimer = Timer()
    var counter = 0
    var score = 0
    var highScore = 0
    var fareArray = [UIImageView]()
    
    //view
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var fare1: UIImageView!
    @IBOutlet weak var fare2: UIImageView!
    @IBOutlet weak var fare3: UIImageView!
    @IBOutlet weak var fare4: UIImageView!
    @IBOutlet weak var fare5: UIImageView!
    @IBOutlet weak var fare6: UIImageView!
    @IBOutlet weak var fare7: UIImageView!
    @IBOutlet weak var fare8: UIImageView!
    @IBOutlet weak var fare9: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storeHighScore = UserDefaults.standard.object(forKey: "highscore")
        if storeHighScore == nil {
            highScore = 0
            highscoreLabel.text = "En Yüksek Skor: \(highScore)"
        }
        if let newScore = storeHighScore as? Int {
            highScore = newScore
            highscoreLabel.text = "En Yüksek Skore: \(highScore)"
        }
        
        
        counter = 30
        timerLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideFare), userInfo: nil, repeats: true)
        
     //Resimlerin gizleme ve tek tek gösterme işlemi yapalım
        //images
        fare1.isUserInteractionEnabled = true //resmin üzerine geldiğimizde tıklayabileceğiz
        fare2.isUserInteractionEnabled = true
        fare3.isUserInteractionEnabled = true
        fare4.isUserInteractionEnabled = true
        fare5.isUserInteractionEnabled = true
        fare6.isUserInteractionEnabled = true
        fare7.isUserInteractionEnabled = true
        fare8.isUserInteractionEnabled = true
        fare9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore)) // her üzerine geldiğinde tetkiklenecek fonksiyonu istiyor.
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        
        fare1.addGestureRecognizer(recognizer1)
        fare2.addGestureRecognizer(recognizer2)
        fare3.addGestureRecognizer(recognizer3)
        fare4.addGestureRecognizer(recognizer4)
        fare5.addGestureRecognizer(recognizer5)
        fare6.addGestureRecognizer(recognizer6)
        fare7.addGestureRecognizer(recognizer7)
        fare8.addGestureRecognizer(recognizer8)
        fare9.addGestureRecognizer(recognizer9)


        fareArray = [fare1, fare2,fare3,fare4,fare5,fare6,fare7,fare8,fare9]
        
        hideFare()

    }
    
    @objc func hideFare() {
        // önce bütün fareleri gizleyeceğiz
        for fare in fareArray {
            fare.isHidden = true
        }
      //şimdi içinden birini açma işlemini yapalım
        let random = Int(arc4random_uniform(UInt32(fareArray.count - 1)))
        fareArray[random].isHidden = false
        
        
        
        
        
    }
    
    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Skor: \(score)"
        print("Yakaladın")
    }

    @objc func countDown() {
        counter -= 1
        timerLabel.text = String(counter)
        //bitip bitmediğini anlamak için if kullan
        if counter == 0 {
            print("timer bitti")
            timer.invalidate() //timer durur.
            hideTimer.invalidate()
            for fare in fareArray {
                fare.isHidden = true
            }
            
            if self.score > self.highScore{
                self.highScore = self.score
                highscoreLabel.text = "En Yüksek Skor: \(highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highsore") //kaydettik
            }
            
        // Mesaj verelim
            let alert = UIAlertController(title: "Süe Bitti!", message: "Tekrar Oynamak İster misin?", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Tamam", style: .cancel)
            let replayButton = UIAlertAction(title: "Tekrar Oynat", style: .default) { (UIAlertAction) in
                
                self.score = 0
                self.scoreLabel.text = "Skor: \(self.score)"
                self.counter = 30
                self.timerLabel.text = String(self.counter)
                
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                
        self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideFare), userInfo: nil, repeats: true)
                
            }
            
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    
    
}

