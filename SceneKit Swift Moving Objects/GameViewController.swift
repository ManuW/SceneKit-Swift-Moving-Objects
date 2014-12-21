//
//  GameViewController.swift
//  SceneKit Swift Moving Objects
//
//  Created by Manuel Wentenschuh on 21.Dec.14.
//  example code
//

import SceneKit


class GameViewController: NSViewController {
    
    @IBOutlet weak var gameView: GameView!
    
    override func awakeFromNib(){
        let scene = GameScene()
        self.gameView!.scene = scene
        self.gameView!.allowsCameraControl = true
        self.gameView!.showsStatistics = true
        self.gameView!.autoenablesDefaultLighting = true
        self.gameView!.backgroundColor = NSColor(calibratedRed: 0.15, green: 0.15, blue: 0.15, alpha: 1.0)
    }
    
}
