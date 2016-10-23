//
//  McCreeWeaponView.swift
//  Overwatch
//
//  Created by Jim Campagno on 10/23/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import UIKit
import SceneKit
import AVFoundation

class McCreeWeaponView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var smokeContainerView: UIView!
    var audioPlayer: AVAudioPlayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("McCreeWeaponView", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.constrainEdges(to: self)
        createSmokeParticle(in: smokeContainerView)
    }
    
    func createSmokeParticle(in view: UIView) {
        let smokeView = SCNView()
        smokeView.scene = SCNScene()
        smokeView.backgroundColor = UIColor.clear
        smokeView.translatesAutoresizingMaskIntoConstraints = false
        smokeContainerView.addSubview(smokeView)
        smokeView.constrainEdges(to: smokeContainerView)
        
        let smoke = SCNParticleSystem(named: "McCreeSmoke", inDirectory: nil)!
        
        smokeView.scene?.rootNode.addParticleSystem(smoke)
        let filePath = Bundle.main.path(forResource: "ItsHighNoon", ofType: "mp3")!
        let url = URL(fileURLWithPath: filePath)
        audioPlayer = try! AVAudioPlayer(contentsOf: url)
    }
    
    @IBAction func itsHighNoon(_ sender: UIButton) {
        print("It's high noon.")
        audioPlayer.play()
    }
    
    
}
