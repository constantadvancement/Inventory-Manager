//
//  MapView.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 12/31/20.
//

import SwiftUI
import MapKit

struct Annotation: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    
    @State var interactionModes: MapInteractionModes = MapInteractionModes.init()
    @State private var region = MKCoordinateRegion()
    
    var coordinate: CLLocationCoordinate2D
    
    var body: some View {
        Map(coordinateRegion: $region, interactionModes: interactionModes, annotationItems: [Annotation(coordinate: coordinate)]) { place in
            MapMarker(coordinate: place.coordinate)
        }
        .onAppear {
            setRegion(coordinate)
        }
    }
    
    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        )
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(interactionModes: .all, coordinate: CLLocationCoordinate2D(latitude: 40.7128, longitude: 74.0060))
    }
}
