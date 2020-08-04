//
//  SoundFileViewController.swift
//  Swift SDK
//
//  Created by u3237 on 2018/08/23.
//  Copyright © 2018年 Star Micronics. All rights reserved.
//

import UIKit

class SoundFileViewController: UITableViewController {
    var soundFileList: [String] = []
    
    var didSelectSoundFileHandler: ((String) -> Void)? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSoundFiles()
    }
    
    func loadSoundFiles() {
        guard let documentsDir = FileManager.default.urls(for: .documentDirectory,
                                                          in: .userDomainMask ).first else {
                                                            return
        }
        
        do {
            let fileUrls = try FileManager.default.contentsOfDirectory(at: documentsDir,
                                                                       includingPropertiesForKeys: nil)
            soundFileList = fileUrls.map{ $0.absoluteString }
                                    .filter{ NSString(string: $0).pathExtension == "wav" }
        } catch {
            soundFileList = []
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return soundFileList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        cell.textLabel?.text = NSString(string: soundFileList[indexPath.row]).lastPathComponent.removingPercentEncoding
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        didSelectSoundFileHandler?(soundFileList[indexPath.row])
        
        self.navigationController?.popViewController(animated: true)
    }
}
