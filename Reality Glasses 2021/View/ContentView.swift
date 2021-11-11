//
//  ContentView.swift
//  Reality Glasses 2021
//
//  Created by Наталья Шарапова on 05.11.2021.
//
import ARKit
import SwiftUI
import RealityKit


struct ContentView : View {
    
    @State var currentColor: Colors = .black
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            ARViewContainer(currentColor: $currentColor)
            ColorChooser(currentColor: $currentColor)
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    @Binding var currentColor: Colors
    
    func makeUIView(context: Context) -> ARView {
        
        //Create AR view
        let arView = ARView(frame: .zero)
        
        //Check that AR face tracking configuration is suppirted
        
        guard ARFaceTrackingConfiguration.isSupported else {
            print("Sorry, face tracking isn't supported by your devise")
            return arView
        }
        
        //Create face tracking configuration
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        
        //Run face tracking session
        arView.session.run(configuration, options: [])
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
        uiView.scene.anchors.removeAll()
        
        // Create face Anchor
        let faceAnchor = AnchorEntity(.face)
        
        // Add Glasses and shackle Entity to the faceAnchor
        
        createGlasses(faceAnchor)
        createShackle(faceAnchor)
        uiView.scene.anchors.append(faceAnchor)
        
    }
    
    func createGlasses(_ faceAnchor: AnchorEntity) {
        
        let color = UIColor.orange
        
        //Create mesh
        let meshGlasses = MeshResource.generateBox(width: 0.068, height: 0.05, depth: 0.001, cornerRadius: 0.03, splitFaces: true)
        
        //Create material
        var material = SimpleMaterial(color: color, isMetallic: true)
        
        switch currentColor {
        
        case .black:
            material.baseColor = MaterialColorParameter.color(UIColor.black)
        case .blue:
            material.baseColor = MaterialColorParameter.color(UIColor.blue)
        case .red:
            material.baseColor = MaterialColorParameter.color(UIColor.red)
            
        }
        
        //Create entity
        let leftEntity = ModelEntity(mesh: meshGlasses, materials: [material])
        let rightEntity = ModelEntity(mesh: meshGlasses, materials: [material])
        
        //Create entuty position
        leftEntity.position = SIMD3(x: 0.035, y: 0.025, z: 0.06)
        rightEntity.position = SIMD3(x: -0.035, y: 0.025, z: 0.06)
        
        //Adding entities to the faceAnchor
        faceAnchor.addChild(leftEntity)
        faceAnchor.addChild(rightEntity)
        
    }
    
    func createShackle(_ faceAnchor: AnchorEntity) {
        
        //Create mesh
        let meshShackle = MeshResource.generateBox(width: 0.02, height: 0.003, depth: 0.001, cornerRadius: 0.001, splitFaces: true)
        
        //Create material
        let material = SimpleMaterial(color: .black, isMetallic: false)
        
        //Create Entity
        let entityShackle = ModelEntity(mesh: meshShackle, materials: [material])
        
        //Create entity position
        entityShackle.position = SIMD3(x: 0, y: 0.025, z: 0.06)
        
        faceAnchor.addChild(entityShackle)
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
#endif



