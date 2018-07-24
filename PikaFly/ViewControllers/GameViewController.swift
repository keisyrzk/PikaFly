//
//  GameViewController.swift
//  PikaFly
//
//  Created by Esteban on 18.07.2018.
//  Copyright © 2018 Selfcode. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController, SceneDelegate {

    var scene: GameScene!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var popupLabel: UILabel!
    @IBOutlet weak var popupImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startNewGame()
    }

    func startNewGame() {
        popupView.isHidden = false
        popupLabel.text = "TAP TO START"
        popupImage.image = #imageLiteral(resourceName: "pikachu")
        
        let skView = view as! SKView
        skView.isMultipleTouchEnabled = false
        skView.showsPhysics = true
        
        if let _scene = SKScene(fileNamed: "GameScene") {
            scene = _scene as! GameScene
            scene.scaleMode = .resizeFill
            skView.presentScene(scene)
        }
        
        scene.sceneDelegate = self
    }
    
    func distanceDidChange(distance: String) {
        distanceLabel.text = distance
    }
    
    func gameShouldStart() {
        startNewGame()
    }
    
    func pikachuDidStart() {
        popupView.isHidden = true
    }
    
    func pikachuDidStop(isTeamR: Bool) {
        popupView.isHidden = false
        popupLabel.text = isTeamR ? "PIKACHU BEEN CAUGHT BY TEAM R \nat \(String(describing: distanceLabel.text!))\nyou lose all pokemon" : "PIKACHU REACHED \(String(describing: distanceLabel.text!))"
        popupImage.image = isTeamR ? #imageLiteral(resourceName: "teamR") : #imageLiteral(resourceName: "pikachu")
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        scene.size = size
        scene.resetCameraPosition()
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func pokedexAction(_ sender: Any) {
        let pokedexVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "pokedexVC") as! PokedexViewController
        pokedexVC.assignDependencies(pokemons: pokedex)
        self.present(pokedexVC, animated: true, completion: nil)
    }
    
}
