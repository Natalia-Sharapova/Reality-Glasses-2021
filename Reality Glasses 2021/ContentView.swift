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
    var body: some View {
        return ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func createBox() -> Entity {
        
        //Create mesh (geometry)
        let mesh = MeshResource.generateBox(size: 0.2)
        
        //Create entity based on mesh
        let entity = ModelEntity(mesh: mesh)
        
        return entity
    }
    
    func createSphere(x: Float = 0, y: Float = 0, z: Float = 0) -> Entity {
        
        //Create sphere mesh
        let mesh = MeshResource.generateSphere(radius: 0.075)
        
        //Create entity based on mesh
        let entity = ModelEntity(mesh: mesh)
        entity.position = SIMD3(x, y, z)
        
        return entity
    }
    
    func makeUIView(context: Context) -> ARView {
        
        //Create AR view
        let arView = ARView(frame: .zero)
        
        //Check that AR face tracking configuration is suppirted
        guard ARFaceTrackingConfiguration.isSupported else {
            print("Sorry, face tracking isn't supported by your advise")
            return arView
        }
        
        //Create face tpacking configuration
        
        let configurarion = ARFaceTrackingConfiguration()
        configurarion.isLightEstimationEnabled = true
        
        //Run face tracking session
        
        arView.session.run(configurarion, options: [])
        
        //Create face anchor
        let faceAnchor = AnchorEntity(.face)
        
        //Add box to the face anchor
        faceAnchor.addChild(createSphere(y: 0.25))
        
        //Add face anchor to the scene
        arView.scene.anchors.append(faceAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
