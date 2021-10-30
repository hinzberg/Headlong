//  CLLocation+Extension.swift
//  Headlong
//  Created by Holger Hinzberg on 30.10.21.

import CoreLocation

extension CLLocation {
    func geocode(completion: @escaping (_ placemark: [CLPlacemark]?, _ error: Error?) -> Void)
    {
        //let locale = Locale.current
        let locale = Locale.init(identifier: "de-DE")
        CLGeocoder().reverseGeocodeLocation(self, preferredLocale: locale, completionHandler: completion)
    }
}
