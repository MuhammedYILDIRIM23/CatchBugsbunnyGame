//
//  EasyVC.swift
//  CatchBugsbunnyGame
//
//  Created by Muhammed YILDIRIM  on 10.04.2021.
//

import UIKit

class EasyVC: UIViewController {
    
    // Variables
    var time = Timer()
    var counter = 30
    var score = 0
    var bugsbunnyArray = [UIImageView]()
    var timeHidden = Timer()
    var highscore = 0
    
    //Views
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var bugsbunny1: UIImageView!
    @IBOutlet weak var bugsbunny2: UIImageView!
    @IBOutlet weak var bugsbunny3: UIImageView!
    @IBOutlet weak var bugsbunny4: UIImageView!
    @IBOutlet weak var bugsbunny5: UIImageView!
    @IBOutlet weak var bugsbunny6: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score: \(score)"
        
        // Highscore Check
        let storedHighScore = UserDefaults.standard.object(forKey: "highscoreeasy")
            
        if storedHighScore == nil {
            highscore = 0
            highscoreLabel.text = "Highscore: \(highscore)"
        }
        if let newHighScore = storedHighScore as? Int {
            highscore = newHighScore
            highscoreLabel.text = "Highscore: \(highscore)"
        }
        
        
        
        //İmages
        bugsbunny1.isUserInteractionEnabled = true
        bugsbunny2.isUserInteractionEnabled = true
        bugsbunny3.isUserInteractionEnabled = true
        bugsbunny4.isUserInteractionEnabled = true
        bugsbunny5.isUserInteractionEnabled = true
        bugsbunny6.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        bugsbunny1.addGestureRecognizer(recognizer1)
        bugsbunny2.addGestureRecognizer(recognizer2)
        bugsbunny3.addGestureRecognizer(recognizer3)
        bugsbunny4.addGestureRecognizer(recognizer4)
        bugsbunny5.addGestureRecognizer(recognizer5)
        bugsbunny6.addGestureRecognizer(recognizer6)
        
        bugsbunnyArray = [bugsbunny1, bugsbunny2, bugsbunny3, bugsbunny4, bugsbunny5, bugsbunny6]
        
        //Timers
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        timeHidden = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(bugsbunnyhide), userInfo: nil, repeats: true)
        
        bugsbunnyhide()
    }
    
    @objc func bugsbunnyhide()  {
        for bugs in bugsbunnyArray {
            bugs.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(bugsbunnyArray.count - 1)))
        bugsbunnyArray[random].isHidden = false
    }
    
    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
     
        for clickedbugsbunny in bugsbunnyArray {
            clickedbugsbunny.isHidden = true
        }
    }
    
    @objc func countDown() {
        timeLabel.text = String(counter)
        counter -= 1
        
        if counter == -1 {
            timeLabel.text = "Time's Over"
            time.invalidate()
            timeHidden.invalidate()
           
            for bugs in bugsbunnyArray {
                bugs.isHidden = true
            }
            
            // Highsscore
            if self.score > self.highscore {
                self.highscore = self.score
                self.highscoreLabel.text = "Highscore: \(self.highscore)"
                
                // Alert
                let alertTebrik = UIAlertController(title: "Congratulations 👏👏👏", message: "New Highscore", preferredStyle: UIAlertController.Style.alert)
                let replayTebrikButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                    
                    // replay function
                    self.score = 0
                    self.scoreLabel.text = "Score: \(self.score)"
                    self.counter = 30
                    self.timeLabel.text = String(self.counter)
        
                    self.time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                    self.timeHidden = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.bugsbunnyhide), userInfo: nil, repeats: true)
                }
                let cancelTebrikButton = UIAlertAction(title: "Exit", style: .cancel) { (UIAlertAction) in
                    exit(0)
                }
                alertTebrik.addAction(replayTebrikButton)
                alertTebrik.addAction(cancelTebrikButton)
                self.present(alertTebrik, animated: true, completion: nil)
                
                UserDefaults.standard.set(self.highscore, forKey: "highscoreeasy")
            }
            
            // Alert
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Exit", style: UIAlertAction.Style.cancel) { (UIAlertAction) in
                exit(0)
            }
            let rapleyButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                
                // replay function
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 30
                self.timeLabel.text = String(self.counter)
                
                self.time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.timeHidden = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.bugsbunnyhide), userInfo: nil, repeats: true)
            }
            alert.addAction(okButton)
            alert.addAction(rapleyButton)
            self.present(alert, animated: true, completion: nil)
        }
    }

}
