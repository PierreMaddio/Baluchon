//
//  LoaderView.swift
//  Baluchon
//
//  Created by Pierre on 19/06/2022.
//

import Foundation

import SwiftUI

struct LoaderView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.hidesWhenStopped = false
        activityView.color = .black
        activityView.startAnimating()
        return activityView
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        
    }
    
    typealias UIViewType = UIActivityIndicatorView
}
