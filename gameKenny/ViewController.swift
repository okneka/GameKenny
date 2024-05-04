import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var bestLabel: UILabel!
    
    @IBOutlet weak var Kenny1: UIImageView!
    @IBOutlet weak var Kenny2: UIImageView!
    @IBOutlet weak var Kenny3: UIImageView!
    @IBOutlet weak var Kenny4: UIImageView!
    @IBOutlet weak var Kenny5: UIImageView!
    @IBOutlet weak var Kenny6: UIImageView!
    @IBOutlet weak var Kenny7: UIImageView!
    @IBOutlet weak var Kenny8: UIImageView!
    @IBOutlet weak var Kenny9: UIImageView!
    
    @IBOutlet weak var startButton: UIButton!
    
    var score = 0
    
    var time = Timer()
    var counter = 0
    
    var kennyArray = [UIImageView]()
    var hideTimer = Timer()
    
    var bestScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score: \(score)"
        
        //best score check
        let storedBest = UserDefaults.standard.object(forKey: "best")
        
        if storedBest == nil {
            bestScore = 0
            bestLabel.text = "High Score: \(bestScore)"
        }
        
        if let newScore = storedBest as? Int{
            bestScore = newScore
            bestLabel.text = "High Score: \(bestScore)"
        }
        
        //images tıklanabilir hale getirildi
        Kenny1.isUserInteractionEnabled = true
        Kenny2.isUserInteractionEnabled = true
        Kenny3.isUserInteractionEnabled = true
        Kenny4.isUserInteractionEnabled = true
        Kenny5.isUserInteractionEnabled = true
        Kenny6.isUserInteractionEnabled = true
        Kenny7.isUserInteractionEnabled = true
        Kenny8.isUserInteractionEnabled = true
        Kenny9.isUserInteractionEnabled = true
        
        //images için jest algılayıcılar oluşturuldu
        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        //images bir jest algılayıcı atandı
        Kenny1.addGestureRecognizer(gestureRecognizer1)
        Kenny2.addGestureRecognizer(gestureRecognizer2)
        Kenny3.addGestureRecognizer(gestureRecognizer3)
        Kenny4.addGestureRecognizer(gestureRecognizer4)
        Kenny5.addGestureRecognizer(gestureRecognizer5)
        Kenny6.addGestureRecognizer(gestureRecognizer6)
        Kenny7.addGestureRecognizer(gestureRecognizer7)
        Kenny8.addGestureRecognizer(gestureRecognizer8)
        Kenny9.addGestureRecognizer(gestureRecognizer9)
        
        //timers
        counter = 30
        timeLabel.text = String(counter)
        
        //kenny rastgele gelmesi için array oluşturuldu
        kennyArray = [Kenny1, Kenny2, Kenny3, Kenny4, Kenny5, Kenny6, Kenny7, Kenny8, Kenny9]
        
        hideKenny()
    }
    
    //score arttırıldı
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
    }

    @IBAction func startClicked(_ sender: Any) {
        counter = 30
        score = 0
        scoreLabel.text = "Score: \(score)"
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
    }
    
    @objc func countDown(){
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter <= 0{
            time.invalidate()
            hideTimer.invalidate()
            timeLabel.text = "Time's Up"
            
            for kenny in kennyArray{
                kenny.isHidden = true
            }
            
            //best score
            if score > bestScore{
                bestScore = score
                bestLabel.text = "High Score \(bestScore)"
                UserDefaults.standard.set(bestScore, forKey: "best")
            }
            
            //alert
            let alert = UIAlertController(title: "that's over", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 30
                self.timeLabel.text = String(self.counter)
                
                self.time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @objc func hideKenny(){
        for kenny in kennyArray{
            kenny.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
    }
    
}

