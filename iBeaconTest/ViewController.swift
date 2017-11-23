//
//  ViewController.swift
//  iBeaconTest
//
//  Created by Koen Vestjens on 13/10/2017.
//  Copyright © 2017 Koen Vestjens. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    
    var beacons: [Beacon] = []
    var paintings: [Painting] = []
    
    @IBOutlet weak var ivPainting: UIImageView!
    @IBOutlet weak var lblPaintingName: UILabel!
    @IBOutlet weak var lblPainter: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beacons.append(Beacon(uuid: UUID(uuidString: "E584FBCB-829C-48B2-88CC-F7142B926AEA")!, name: "Mona_Lisa", paintingId: 0, majorValue: 8, minorValue: 1))
        beacons.append(Beacon(uuid: UUID(uuidString: "E584FBCB-829C-48B2-88CC-F7142B926AEA")!, name: "Self_Portrait", paintingId: 1, majorValue: 10, minorValue: 1))
        
        paintings.append(Painting(id: 0, name: "Mona Lisa", info: "", img: "Mona_Lisa.png", painter: "Leonardo Da Vinci"))
        paintings.append(Painting(id: 1, name: "Self Portrait", info: "", img: "Vincent_van_Gogh_Self_Portrait.png", painter: "Vincent van Gogh"))
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    for beacon in beacons {
                        startScanning(beacon: beacon)
                    }
                }
            }
        }
    }
    
    func startScanning(beacon: Beacon) {
        let beaconRegion = beacon.asBeaconRegion()
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
    }
    
    func stopScanning(beacon: Beacon) {
        let beaconRegion = beacon.asBeaconRegion()
        locationManager.stopMonitoring(for: beaconRegion)
        locationManager.stopRangingBeacons(in: beaconRegion)
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {

        if beacons.count > 0 {
            if(beacons[0].accuracy < 0.1){
                updateUI(id: Int(region.identifier)!)
                
                //stop scanning for found beacon
               
            }
            
        } else {
            
        }
    }
    
    func updateUI(id: Int){
        let painting: Painting = paintings[id]
        
        self.ivPainting.image = UIImage(named: painting.img)
        self.lblPaintingName.text = painting.name
        self.lblPainter.text = painting.painter
    }
    
    func updateDistance(_ distance: CLProximity) {
        UIView.animate(withDuration: 0.8) {
            switch distance {
            case .unknown:
                self.view.backgroundColor = UIColor.gray
                
            case .far:
                self.view.backgroundColor = UIColor.blue
                
            case .near:
                self.view.backgroundColor = UIColor.orange
                
            case .immediate:
                self.view.backgroundColor = UIColor.red
            }
        }
    }

}

//https://www.hackingwithswift.com/example-code/location/how-to-detect-ibeacons

