//
//  GarbageMateView.swift
//  GarbageMate
//
//  Created by Iker on 18/11/21.
//

import SwiftUI

struct GarbageMateView: View {
    
    private var delegate: AppDelegate
    
    @State private var deleting: Bool = false
    @State private var rotationDegrees: Double = 0
    
    public init(delegate: AppDelegate) {
        self.delegate = delegate
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Button(action: {
                deleting = true
                rotationDegrees = 180
                deleteDerivedData {
					rotationDegrees = 0
                    deleting = false
                    delegate.collapse()
                }
            }, label: {
                Label(
                    title: { Text("Delete") },
                    icon: {
                        Image(systemName: "trash")
                            .rotationEffect(.degrees(rotationDegrees))
                            .animation(.easeInOut, value: rotationDegrees)
                    }
                )
                .frame(width: 80)
            })
            
            Button(action: {
                NSApplication.shared.terminate(self)
            }, label: {
                Text("Quit")
                    .frame(width: 80)
            })
            .foregroundColor(Color.red)
            
        }
        .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
        .background(Color.clear)
    }
    
    private func deleteDerivedData(completion: @escaping() -> Void) {
        let folderPath = "/Developer/Xcode/DerivedData"
		let queue = DispatchQueue(label: "Deletion", attributes: .concurrent)
		queue.async {
            guard var url = FileManager.default.urls(
                    for: .libraryDirectory,
                    in: .userDomainMask
            ).first else {
                return
            }
            url.appendPathComponent(folderPath)
            do {
                guard let enumerator = FileManager.default.enumerator(
                        at: url,
                        includingPropertiesForKeys: nil
                ) else { return }
                while let fileURL = enumerator.nextObject() as? URL {
                    try FileManager.default.removeItem(at: fileURL)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.75, execute: {
                    completion()
                })
                
            } catch { }
		}
    }
}

