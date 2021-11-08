//
//  GameViewController.swift
//  DouYu_Project
//
//  Created by 崔林豪 on 2021/11/6.
//

import UIKit
import Kingfisher


class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let img = UIImageView(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        img.backgroundColor = .systemGray
        
        view.addSubview(img)
        
        let url = URL(string: "https://pic.netbian.com/uploads/allimg/211103/234237-1635954157f0ce.jpg")
        img.kf.setImage(with: url)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
