//
//  CreateGlasses.swift
//  Reality Glasses 2021
//
//  Created by Наталья Шарапова on 11.11.2021.
//

import ARKit
import SwiftUI
import RealityKit

enum Colors: CaseIterable, Equatable {
    
    case black
    case blue
    case red
    
}

struct ColorChooser: View {
    
    @Binding var currentColor: Colors
    
    // Cteating 3 buttons
    var body: some View {
        
        HStack {
            Button(action: {
                currentColor = Colors.black
            }) {
                Text("Black")
                    .frame(width: 70, height: 30, alignment: .center)
                    .foregroundColor(.black)
                    .font(.title)
                    .padding()
                    .border(Color.black, width: 5)
            }
            
            Spacer()
            
            Button(action: {
                currentColor = Colors.blue
            }) {
                Text("Blue")
                    .frame(width: 70, height: 30, alignment: .center)
                    .foregroundColor(.blue)
                    .font(.title)
                    .padding()
                    .border(Color.blue, width: 5)
            }
            Spacer()
            
            Button(action: {
                currentColor = Colors.red
            }) {
                Text("Red")
                    .frame(width: 70, height: 30, alignment: .center)
                    .foregroundColor(.red)
                    .font(.title)
                    .padding()
                    .border(Color.red, width: 5)
            }
        }
        .padding()
    }
}
