//
//  TrafficLightView.swift
//  TrafficLight
//
//  Created by Sarah Rodrigues on 18/12/23.
//

import UIKit

class TrafficLightView: UIView {
    
    var state = TrafficLightState.intermittent
    var timer = Timer()
    
    @IBAction func segmentedControlState(_ sender: UISegmentedControl) {
        print("Segmented control value changed")
        
    }
    
    let redButton: UIButton = {
        let redButton = UIButton()
        redButton.backgroundColor = .red
        redButton.setTitle("Red", for: .normal)
        redButton.translatesAutoresizingMaskIntoConstraints = false
        return redButton
        
    }()
        
    let yellowButton: UIButton = {
        let yellowButton = UIButton()
        yellowButton.backgroundColor = .yellow
        yellowButton.setTitle("Yellow", for: .normal)
        yellowButton.translatesAutoresizingMaskIntoConstraints = false
        return yellowButton
    }()
    
    let greenButton: UIButton = {
        let greenButton = UIButton()
        greenButton.backgroundColor = .green
        greenButton.setTitle("Green", for: .normal)
        greenButton.translatesAutoresizingMaskIntoConstraints = false
        return greenButton
    }()
    
    let intermittentButton: UIButton = {
        let intermittentButton = UIButton()
        intermittentButton.backgroundColor = .black
        intermittentButton.setTitleColor(.yellow, for: .normal)
        intermittentButton.setTitle("Intermittent", for: .normal)
        intermittentButton.translatesAutoresizingMaskIntoConstraints = false
        return intermittentButton
        
    }()
    
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
        
        redButton.addTarget(self, action: #selector(stateChanged), for: .touchUpInside)
        
    }
    
    let lightSide = 90.0
    let buttonHeight = 35.0
    
    func addViews() {
        addSubview(trafficLight)
        trafficLight.addSubview(redLight)
        trafficLight.addSubview(yellowLight)
        trafficLight.addSubview(greenLight)
        trafficLight.addSubview(redButton)
        trafficLight.addSubview(yellowButton)
        trafficLight.addSubview(greenButton)
        trafficLight.addSubview(intermittentButton)
        
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
            
            redButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            redButton.topAnchor.constraint(equalTo: trafficLight.bottomAnchor, constant: 15),
            redButton.widthAnchor.constraint(equalToConstant: lightSide),
            redButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            yellowButton.leadingAnchor.constraint(equalTo: redButton.trailingAnchor, constant: 5),
            yellowButton.topAnchor.constraint(equalTo: trafficLight.bottomAnchor, constant: 15),
            yellowButton.widthAnchor.constraint(equalToConstant: lightSide),
            yellowButton.heightAnchor.constraint(equalToConstant: buttonHeight),

            greenButton.leadingAnchor.constraint(equalTo: yellowButton.trailingAnchor, constant: 5),
            greenButton.topAnchor.constraint(equalTo: trafficLight.bottomAnchor, constant: 15),
            greenButton.widthAnchor.constraint(equalToConstant: lightSide),
            greenButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            intermittentButton.leadingAnchor.constraint(equalTo: greenButton.trailingAnchor, constant: 5),
            intermittentButton.topAnchor.constraint(equalTo: trafficLight.bottomAnchor, constant: 15),
            intermittentButton.widthAnchor.constraint(equalToConstant: lightSide),
            intermittentButton.heightAnchor.constraint(equalToConstant: buttonHeight),
        ])
        
        setNeedsLayout()
        
    }
    
    @objc func stateChanged(_ sender: UIButton) {
     
        if sender == redButton {
            self.state = .red
        }
        
        print("ta vermelho")
        
        updateColors()
    }
    
    @objc func updateColors() {
        
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
            
        case .intermittent:
            redLight.backgroundColor = .black
            greenLight.backgroundColor = .black
            intermittentLight()
        }
        
        if self.state != TrafficLightState.intermittent {
            timer.invalidate()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func intermittentLight() {
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.7, repeats: true) { timer in
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
        case red, yellow, green, intermittent
    }
    

