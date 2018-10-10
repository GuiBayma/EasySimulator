//
//  LoadingView.swift
//  Easy Simulator
//

import UIKit

class LoadingView: UIView {
    fileprivate lazy var loadingPoint: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    fileprivate lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .white
        return label
    }()

    lazy var shapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.white.cgColor
        layer.strokeStart = 0
        layer.strokeEnd = 1
        layer.lineWidth = 3
        return layer
    }()

    fileprivate let duration: CGFloat = 2

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(text: String) {
        super.init(frame: .zero)
        setupViewHierarchy()
        setupConstraints()
        configureViews(text: text)
    }

    deinit {
        DispatchQueue.main.async {
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
}

// MARK: - Configuration

extension LoadingView {
    fileprivate func setupViewHierarchy() {
        addSubview(loadingPoint)
        addSubview(label)
    }

    fileprivate func setupConstraints() {
        loadingPoint
            .centerXAnchor(equalTo: self.centerXAnchor)
            .centerYAnchor(equalTo: self.centerYAnchor)

        label
            .leadingAnchor(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 15)
            .topAnchor(equalTo: loadingPoint.bottomAnchor, constant: 64)
            .trailingAnchor(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -15)
    }

    fileprivate func configureViews(text: String) {
        let center = loadingPoint.center
        let radius: CGFloat = 32
        let bezierPath = UIBezierPath(arcCenter: center,
                                      radius: radius,
                                      startAngle: 0,
                                      endAngle: 2 * .pi,
                                      clockwise: true)

        shapeLayer.path = bezierPath.cgPath
        loadingPoint.layer.addSublayer(shapeLayer)

        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        label.text = text
        accessibilityLabel = "LoadingView"
    }
}

// MARK: - Animations

extension LoadingView {
    fileprivate func animateStrokeStart() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "strokeStart")
        animation.beginTime = CFTimeInterval(duration / 2.0)
        animation.duration = CFTimeInterval(duration / 2.0)
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        return animation
    }

    fileprivate func animateStrokeEnd() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.beginTime = 0
        animation.duration = CFTimeInterval(duration / 2.0)
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        return animation
    }

    fileprivate func animateRotation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = 2.0 * .pi
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.repeatCount = Float.infinity
        return animation
    }

    fileprivate func animateGroup() {
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [animateStrokeEnd(), animateStrokeStart(), animateRotation()]
        animationGroup.duration = CFTimeInterval(duration)
        animationGroup.fillMode = .both
        animationGroup.isRemovedOnCompletion = false
        animationGroup.repeatCount = Float.infinity
        shapeLayer.add(animationGroup, forKey: "loading")
    }
}

// MARK: - Start & Stop

extension LoadingView {
    func startAnimation() {
        DispatchQueue.main.async {
            UIApplication.shared.beginIgnoringInteractionEvents()
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            self.animateGroup()
        }
    }

    func stopAnimation() {
        DispatchQueue.main.async {
            UIApplication.shared.endIgnoringInteractionEvents()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.shapeLayer.removeAllAnimations()
        }
    }
}
