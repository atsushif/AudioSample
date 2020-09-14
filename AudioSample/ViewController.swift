import UIKit
import AVFoundation

 
class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    let musicPath = Bundle.main.bundleURL.appendingPathComponent("hoge.mp3")
    var audioPlayer = AVAudioPlayer()
    var userDefaults = UserDefaults.standard
    var config_bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.CODE.keyboardType = UIKeyboardType.numberPad
        self.ANGLE.keyboardType = UIKeyboardType.numberPad
        config_bool = userDefaults.bool(forKey: "config_bool")
        config.text = "設定 : " + String(config_bool)
    }
    //値の送受信
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //segueの指定は省く(今回は1対1なので)
        let next = segue.destination as? Config
        //値を送信
        next?.config_bool = config_bool
        //値を受信
        next?.resultHandler = { setting in
            self.config_bool = setting
            self.config.text = "設定 : " + String(self.config_bool)
            //設定の保存
            self.userDefaults.set(self.config_bool, forKey: "config_bool")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBOutlet weak var CODE: UITextField!
    @IBOutlet weak var ANGLE: UITextField!
    @IBOutlet weak var result: UITextField!
    @IBOutlet weak var config: UILabel!
    @IBOutlet weak var checker: UILabel!
    
    @IBAction func play(_ sender: Any) {
        let code:Int = (CODE.text! as NSString).integerValue
        let angle:Int = (ANGLE.text! as NSString).integerValue
        let mp3 = String(format: "wm%05d_%d.mp3",code,angle)
        result.text = mp3
        let check = Audio().existingFile(fileName: mp3)
        self.checker.text = "ローカルファイル確認 : " + String(check)
        
        if ((check == false) || (config_bool == true)){
            Audio().writeAudio(mp3: mp3)
        }
        
        let data = Audio().readAudio(mp3: mp3)
        do{
            self.audioPlayer = try AVAudioPlayer(data:data as Data)
            self.audioPlayer.play()
        }catch{
            print("再生エラー")
        }
    }
    
    @IBAction func stop(_ sender: Any) {
        audioPlayer.stop()
    }
}
