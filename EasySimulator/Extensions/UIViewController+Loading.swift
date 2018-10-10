//
//  UIViewController+Loading.swift
//  Easy Simulator
//

import UIKit

extension UIViewController {
    func startLoading(text: String) -> LoadingView {
        let loadingView = LoadingView(text: text)
        loadingView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(loadingView)
        loadingView
            .leadingAnchor(equalTo: self.view.leadingAnchor)
            .topAnchor(equalTo: self.view.topAnchor)
            .trailingAnchor(equalTo: self.view.trailingAnchor)
            .bottomAnchor(equalTo: self.view.bottomAnchor)
        self.view.bringSubviewToFront(loadingView)

        loadingView.startAnimation()

        return loadingView
    }

    func stopLoading(_ loadingView: LoadingView) {
        DispatchQueue.main.async {
            loadingView.removeFromSuperview()
        }
        loadingView.stopAnimation()
    }
}
