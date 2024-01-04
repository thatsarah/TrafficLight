//
//  TrafficLightViewController.swift
//  TrafficLight
//
//  Created by Sarah Rodrigues on 18/12/23.
//

import UIKit

class TrafficLightViewController: UIViewController {
    
    let trafficLightView = TrafficLightView()
    
    override func loadView() {
        view = trafficLightView
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .lightGray
        super.viewDidLoad()
    }
}
