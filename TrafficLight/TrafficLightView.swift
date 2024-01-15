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
    
    let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.backgroundColor = .white
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
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
    }
    
    let lightSide = 90.0
    
    
    func addViews() {
        addSubview(trafficLight)
        trafficLight.addSubview(redLight)
        trafficLight.addSubview(yellowLight)
        trafficLight.addSubview(greenLight)
        trafficLight.addSubview(segmentedControl)
        let distanceBetweenLights = 25.0
        
        segmentedControl.insertSegment(withTitle: "Red", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Yellow", at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "Green", at: 2, animated: false)
        segmentedControl.insertSegment(withTitle: "Intermittent", at: 3, animated: false)
        segmentedControl.isUserInteractionEnabled = true
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)

        
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
            
            segmentedControl.topAnchor.constraint(equalTo: trafficLight.bottomAnchor, constant: 60),
            segmentedControl.centerXAnchor.constraint(equalTo: self.centerXAnchor)

            
        ])
        
        setNeedsLayout()
        
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        
        switch selectedIndex {
        case 0:
            state = .red
        case 1:
            state = .yellow
        case 2:
            state = .green
        case 3:
            state = .intermittent
        default:
            break
        }
        
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
    

