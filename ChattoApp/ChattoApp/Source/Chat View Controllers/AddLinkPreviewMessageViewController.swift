//
//  AddLinkPreviewMessageViewController.swift
//  ChattoApp
//
//  Created by Vidit Paliwal on 17/01/19.
//  Copyright © 2019 Badoo. All rights reserved.
//
import UIKit

class AddLinkPreviewMessageViewController: DemoChatViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIBarButtonItem(
            title: "Add message",
            style: .plain,
            target: self,
            action: #selector(addRandomMessage)
        )
        self.navigationItem.rightBarButtonItem = button

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc
    private func addRandomMessage() {
        
        self.dataSource.addLinkPreviewMessage(linkTitle: "Google.com", linkDescription: "Largest Search Engine in the world. Search whatever you want", linkImageUrl: "https://cdn-images-1.medium.com/max/1600/1*0rwy_PxAGuWJNJhlh2GPAA.png", linkUrl: "https://www.google.com", canonicalUrl: "google.com", messageText: "This is testing Text. Please ignore this")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
