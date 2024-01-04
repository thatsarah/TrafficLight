//
//  TrafficLightView.swift
//  TrafficLight
//
//  Created by Sarah Rodrigues on 18/12/23.
//

import UIKit

class TrafficLightView: UIView {
    
    var state = TrafficLightState.intermitent
    
    let trafficLight: UIView = {
        let innerView = UIView(frame: CGRect(x: 20, y: 20, width: 160, height: 160))
        innerView.backgroundColor = .darkGray
        innerView.translatesAutoresizingMaskIntoConstraints = false
        return innerView
    }()
    
    let redLight: UIView = { 
        let redView = UIView()
        redView.backgroundColor = .red
        redView.translatesAutoresizingMaskIntoConstraints = false
        return redView
    }()
    
    let yellowLight: UIView = { 
        let yellowView = UIView()
        yellowView.backgroundColor = .yellow
        yellowView.translatesAutoresizingMaskIntoConstraints = false
        return yellowView
    }()
    
    let greenLight: UIView = { 
        let greenView = UIView()
        greenView.backgroundColor = .green
        greenView.translatesAutoresizingMaskIntoConstraints = false
        return greenView
    }()
  
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateLightAppearance()
    }
    
    func updateLightAppearance() {
        redLight.layer.cornerRadius = lightSide / 2
        redLight.clipsToBounds = true
        
        yellowLight.layer.cornerRadius = lightSide / 2
        yellowLight.clipsToBounds = true
        
        greenLight.layer.cornerRadius = lightSide / 2
        greenLight.clipsToBounds = true
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRectZero)
        addViews()
        updateColors()
    }
    
    let lightSide = 90.0
    
    
    func addViews() {
        addSubview(trafficLight)
        trafficLight.addSubview(redLight)
        trafficLight.addSubview(yellowLight)
        trafficLight.addSubview(greenLight)
        let distanceBetweenLights = 25.0
        
        NSLayoutConstraint.activate([
            
            trafficLight.topAnchor.constraint(equalTo: self.topAnchor, constant: 220),
            trafficLight.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            trafficLight.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            trafficLight.widthAnchor.constraint(equalToConstant: 160),
            
            redLight.centerXAnchor.constraint(equalTo: trafficLight.centerXAnchor),
            redLight.bottomAnchor.constraint(equalTo: yellowLight.topAnchor, constant: -distanceBetweenLights),
            redLight.widthAnchor.constraint(equalToConstant: lightSide),
            redLight.heightAnchor.constraint(equalToConstant: lightSide),   
            
            yellowLight.centerXAnchor.constraint(equalTo: trafficLight.centerXAnchor),
            yellowLight.centerYAnchor.constraint(equalTo: trafficLight.centerYAnchor),
            yellowLight.widthAnchor.constraint(equalToConstant: lightSide),
            yellowLight.heightAnchor.constraint(equalToConstant: lightSide),
            
            greenLight.centerXAnchor.constraint(equalTo: trafficLight.centerXAnchor),
            greenLight.topAnchor.constraint(equalTo: yellowLight.bottomAnchor, constant: distanceBetweenLights),
            greenLight.widthAnchor.constraint(equalToConstant: lightSide),
            greenLight.heightAnchor.constraint(equalToConstant: lightSide),
            
        ])
        
        setNeedsLayout()
        
    } 
    
    func updateColors() {
        
        switch state {
        case TrafficLightState.red:
            redLight.backgroundColor = .red
            yellowLight.backgroundColor = .black
            greenLight.backgroundColor = .black
            
        case .yellow:
            redLight.backgroundColor = .black
            yellowLight.backgroundColor = .yellow
            greenLight.backgroundColor = .black
            
        case .green: 
            redLight.backgroundColor = .black
            yellowLight.backgroundColor = .black
            greenLight.backgroundColor = .green
            
        case .intermitent:
            redLight.backgroundColor = .black
            greenLight.backgroundColor = .black
            intermitentLight()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func intermitentLight() {
        var timer = Timer()
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
            self.pisk()
        }
    }
    
    func pisk() {
        let isOn = yellowLight.backgroundColor == .yellow
        
        if isOn {
            yellowLight.backgroundColor = .black
        } else {
            yellowLight.backgroundColor = .yellow
        }
    }
    
}
    
    enum TrafficLightState {
        case red, yellow, green, intermitent
    }
    

