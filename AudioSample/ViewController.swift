import UIKit
import AVFoundation

 
class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    let musicPath = Bundle.main.bundleURL.appendingPathComponent("hoge.mp3")
    var musicPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.CODE.keyboardType = UIKeyboardType.numberPad
        self.ANGLE.keyboardType = UIKeyboardType.numberPad
    }
    
    @IBOutlet weak var CODE: UITextField!
    @IBOutlet weak var ANGLE: UITextField!
    @IBOutlet weak var result: UITextField!
    
    @IBAction func start(_ sender: Any) {
        let code:Int = (CODE.text! as NSString).integerValue
        let angle:Int = (ANGLE.text! as NSString).integerValue
        let mp3 = String(format: "wm%05d_%d.mp3",code,angle)
        result.text = mp3
        let check = Audio().checkAudio(String: mp3)
        let data = Audio().readData(mp3: mp3)
        print(data)
        do{
            //print(data)
            musicPlayer = try AVAudioPlayer(data:data as Data)
            
            musicPlayer.play()
        }catch{
            print("エラー")
        }
    }
    
    @IBAction func stop(_ sender: Any) {
        musicPlayer.stop()
        }
    }
    func getFileData(_ filePath: String) -> Data? {
        let fileData: Data?
        do {
            let fileUrl = URL(fileURLWithPath: filePath)
            fileData = try Data(contentsOf: fileUrl)
        } catch {
            // ファイルデータの取得でエラーの場合
            fileData = nil
        }
        return fileData
    }
    func existingFile(fileName: String) -> Bool {

        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        if let pathComponent = url.appendingPathComponent("\(fileName)") {
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath)

           {

            return true

            } else {

            return false

            }

        } else {

            return false

            }


    }
