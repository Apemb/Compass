//
//  MapDestinationAnnotationView.swift
//  Compass
//
//  Created by Antoine Boileau on 18/12/16.
//  Copyright © 2016 Antoine Boileau. All rights reserved.
//

import MapKit

class MapDestinationAnnotationView: MKAnnotationView {

  init(annotation: MapDestinationAnnotation) {
    super.init(annotation: annotation,
               reuseIdentifier: MapDestinationAnnotationView.reuseIdentifier)
    image = Asset.arrivalIcon.image

    centerOffset = CGPoint(x:0, y: -Asset.arrivalIcon.image.size.height / 2.0 + 2)
    canShowCallout = false
  }

  override func didMoveToSuperview() {
    shadow()
    self.transform = CGAffineTransform(scaleX: 0, y: 0)
    UIView.animate(withDuration: 0.5,
                   delay: 0,
                   usingSpringWithDamping: 0.75,
                   initialSpringVelocity: 1.0,
                   options: UIViewAnimationOptions.curveEaseOut,
                   animations: {
                    self.transform = CGAffineTransform(scaleX: 1, y: 1)
    },
                   completion: nil)
  }

  private func shadow() {
    clipsToBounds = false
    layer.masksToBounds = false
    layer.shadowOffset = CGSize(width: 0, height: 3)
    layer.shadowRadius = 2
    layer.shadowOpacity = 0.1
    layer.shadowColor = UIColor.black.cgColor
  }

  static var reuseIdentifier: String {
    return String(describing: MapDestinationAnnotationView.self)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
