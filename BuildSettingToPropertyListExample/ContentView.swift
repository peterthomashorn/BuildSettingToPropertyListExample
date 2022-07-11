//
//  ContentView.swift
//  BuildSettingToPropertyListExample
//
//  Created by Peter Thomas Horn on 11.07.22.
//

import SwiftUI

struct ContentView: View {
    var serverURL: String {
        guard let customizationPropertyList = Bundle.main
            .url(forResource: "Customization", withExtension: "plist") else {
            assertionFailure("Failed to find property list!")
            return ""
        }

        guard let data = FileManager.default.contents(atPath: customizationPropertyList.path) else {
            assertionFailure("Failed to read property list!")
            return ""
        }

        guard let dictionary = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any] else {
            assertionFailure("Failed to deserialize property list!")
            return ""
        }

        guard let serverURL = dictionary["serverURL"] as? String else {
            assertionFailure("Failed to retrieve server URL!")
            return ""
        }

        return serverURL
    }

    var body: some View {
        Text("This app connects to \(serverURL)")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
