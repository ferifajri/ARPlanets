//
//  ViewController.swift
//  Planets
//
//  Created by Feri Fajri on 14/05/20.
//  Copyright © 2020 Feri Fajri. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    
    let configuration = ARWorldTrackingConfiguration()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let sun = SCNNode(geometry: SCNSphere(radius: 0.35))
        let earthParents = SCNNode()
        let venusParents = SCNNode()
        let moonParents = SCNNode()
        
        sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named : "Sun.png")
        sun.position = SCNVector3(0,0,-2)
        self.sceneView.scene.rootNode.addChildNode(sun)
        
        // Add Earth and Venus Parents to root Node and give its position same with sun
        self.sceneView.scene.rootNode.addChildNode(earthParents)
        self.sceneView.scene.rootNode.addChildNode(venusParents)
        earthParents.position = SCNVector3(0,0,-2)
        venusParents.position = SCNVector3(0,0,-2)
        moonParents.position = SCNVector3(1.2,0,0)
        
//        let earth = SCNNode()
//        earth.geometry = SCNSphere(radius: 0.2)
//        // To add teksture instead of color, use diffuse and choose UIImage name on the asset < exact match >
//        earth.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "Earth day.png")
//        earth.geometry?.firstMaterial?.specular.contents = UIImage(named: "Earth specular.png")
//        earth.geometry?.firstMaterial?.emission.contents = UIImage(named: "Earth emission.png")
//        earth.geometry?.firstMaterial?.normal.contents = UIImage(named: "Earth normal.png")
//        earth.position = SCNVector3(3,0,0)
        
        //Using func planet
        let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth day"), specular: #imageLiteral(resourceName: "Earth specular"), emission: #imageLiteral(resourceName: "Earth emission"), normal: #imageLiteral(resourceName: "Earth normal"), position: SCNVector3(1.2,0,0))
        let venus = planet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "Venus Surface"), specular: nil, emission: #imageLiteral(resourceName: "Venus Atmosphere"), normal: nil, position: SCNVector3(0.7,0,0))
        let earthMoon = planet(geometry: SCNSphere(radius: 0.03), diffuse: #imageLiteral(resourceName: "Moon"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0,0,-0.3))
        let venusMoon = planet(geometry: SCNSphere(radius: 0.03), diffuse: #imageLiteral(resourceName: "Moon"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0,0,-0.3))
        
//        //Give sun action to rotate
//        let action = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 8)
//        let forever = SCNAction.repeatForever(action)
//        sun.runAction(forever)
//
//        //Give earth and venus rotate to its parents and add action
//        earthParents.addChildNode(earth)
//        venusParents.addChildNode(venus)
//
//        let earthRotateToParents = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 14)
//        let foreverEarth = SCNAction.repeatForever(earthRotateToParents)
//        earthParents.runAction(foreverEarth)
//        let venusRotateToParents = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 10)
//        let foreverVenus = SCNAction.repeatForever(venusRotateToParents)
//        venusParents.runAction(foreverVenus)
        
        
        
        // Using func Rotation
        
        //Both MoonParents and Earth rotate to the EarthParents
        earthParents.addChildNode(earth)
        earthParents.addChildNode(moonParents)
        //Venus will rotate to Venus parents
        venusParents.addChildNode(venus)
        //EarthMoon will roatate to both Earth and MoonParents
        earth.addChildNode(earthMoon)
        moonParents.addChildNode(earthMoon)
        // Venus Moon will rotate according to venus rotation
        venus.addChildNode(venusMoon)
        
        
        let sunRotation = Rotation(time: 8)
        sun.runAction(sunRotation)
        
        let earthParentsRotation = Rotation(time: 14)
        let venusParentsRotation = Rotation(time: 10)
        earthParents.runAction(earthParentsRotation)
        venusParents.runAction(venusParentsRotation)
        
        let venusActionRotation = Rotation(time: 8)
        venus.runAction(venusActionRotation)
        
        let earthActionRotation = Rotation(time: 8)
        let moonActionRotation = Rotation(time: 1)
        earth.runAction(earthActionRotation)
        moonParents.runAction(moonActionRotation)
        
        //self.sceneView.scene.rootNode.addChildNode(earth)
        
//        //To rotate action, use SCNAction.rotateBy
//        let action = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 8)
//        // Use repeatForever to do action forever
//        let forever = SCNAction.repeatForever(action)
//        earth.runAction(forever)
        
    }
    
    
    
    func planet(geometry: SCNGeometry, diffuse: UIImage?, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode {
        let planet = SCNNode(geometry: geometry)
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position
        return planet
    }
    
    func Rotation(time: TimeInterval) -> SCNAction {
        let Rotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: time)
        let foreverRotation = SCNAction.repeatForever(Rotation)
        return foreverRotation
    }
    

}


// Function / ekstension to convert degree to radian
extension Int {
    var degreesToRadians: Double { return Double(self) * .pi/180}
}
