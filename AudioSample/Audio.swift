//
//  Audio.swift
//  AudioSample
//
//  Created by matuilab on 2020/08/24.
//  Copyright © 2020 matuilab. All rights reserved.
//
import AVFoundation
import Foundation

class Audio {
    let Url = "http://ec2-3-136-168-45.us-east-2.compute.amazonaws.com/tenji/message/"
    let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    let docpath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    func readData(mp3: String) -> Data{
        let fileURL = docpath.appendingPathComponent(mp3)
        var musicData:Data
        do{
            musicData = try Data(contentsOf: fileURL)
        }catch {
            musicData = "".data(using: .utf8)!
        }
        return musicData
    }
    
    func checkAudio(String: String) ->Bool{
        //let mp3 = String(format: "wm%05d_%d.mp3",code,angle)
        if(existingFile(fileName: String)){
            print("ある")
            return true
        }
        else{
            print("ない")
            return false
        }
    }
    
    func callAudio(String: String,save:Bool) -> NSData{
        //let mp3 = String(format: "wm%05d_%d.mp3",code,angle)
        let Urlmp3 = Url + String
        let musicUrl = NSURL(string: Urlmp3)
        let musicData = NSData(contentsOf: musicUrl! as URL)
        let data = musicData!
        data.write(toFile: "\(documentsPath)/\(String)", atomically: true)
        return data
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
}
