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
