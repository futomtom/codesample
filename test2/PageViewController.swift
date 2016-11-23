//
//  PageViewController.swift
//  test2
//
//  Created by Alex on 11/23/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class SampleViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    var index: Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleLabel.text = "ViewController #\(index)"
    }
}



class PageViewController: UIViewController {
    public var pageViewController: UIPageViewController!
    
    public var viewControllers: [UIViewController]? {
        didSet {
            setupViewControllers()
        }
    }
    
    public var nextIndex: Int = 0
    public var selectedIndex: Int = 0

    @IBOutlet weak var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageViewController()
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "sample") as! SampleViewController
        
        let vc1 = vc
        vc1.view.backgroundColor = .red
  //      vc1?.index = 0
        let vc2 = vc
        vc2.view.backgroundColor = .blue
    //    vc2?.index = 1
        let vc3 = vc
    //    vc3?.index = 2
        let vc4 = vc
   //     vc4?.index = 3
        
        self.viewControllers = [vc1, vc2, vc3, vc4]

        // Do any additional setup after loading the view.
    }

 
    private func setupPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.view.frame = containerView.bounds
        pageViewController.dataSource = self
        pageViewController.delegate = self
        addChildViewController(pageViewController)
        containerView.addSubview(pageViewController.view)
        pageViewController.didMove(toParentViewController: self)
        
        // add constrains
        pageViewController.view.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        pageViewController.view.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        pageViewController.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        pageViewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
        pageViewController.view.layer.borderColor=UIColor.red.cgColor
        pageViewController.view.layer.borderWidth=1
        
        
        self.view.layoutIfNeeded()
    }
    
    fileprivate func indexOfViewController(viewController: UIViewController)-> Int? {
        if let viewControllers = viewControllers {
            for i in 0..<viewControllers.count {
                let vc = viewControllers[i]
                if vc == viewController {
                    return i
                }
            }
        }
        return nil
    }
    
    fileprivate func setupViewControllers() {
        if let viewControllers = viewControllers {
            let viewController = viewControllers[selectedIndex]
            pageViewController.setViewControllers([viewController], direction: .forward, animated: false, completion: nil)
//            viewControllers.forEach { if !($0 is HQPagerViewControllerDataSource) { fatalError("Every child view controller must conform to  HQPagerViewControllerDataSource") }}
        }
    }
    
    fileprivate func selectViewController(atIndex index: Int, animated: Bool) {
        if let viewControllers = viewControllers {
            let oldIndex = selectedIndex
            selectedIndex = index
            let direction: UIPageViewControllerNavigationDirection = (oldIndex < selectedIndex) ? .forward : .reverse
            if index >= 0 && index < viewControllers.count {
                let viewController = viewControllers[index]
                pageViewController.setViewControllers([viewController], direction: direction, animated: animated, completion: nil)
            }
        }
    }
}



extension PageViewController: UIPageViewControllerDataSource {
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = indexOfViewController(viewController: viewController) {
            if index > 0 {
                return viewControllers?[index-1]
            }
        }
        return nil
    }
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = indexOfViewController(viewController: viewController) {
            if let viewControllers = viewControllers, index < viewControllers.count-1 {
                return viewControllers[index+1]
            }
        }
        return nil
    }
}

extension PageViewController: UIPageViewControllerDelegate {
    public func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        if let vc = pendingViewControllers.first, let index = indexOfViewController(viewController: vc) {
            self.nextIndex = index
        }
    }
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let vc = previousViewControllers.first, let previousIndex = indexOfViewController(viewController: vc) {
                if self.nextIndex != previousIndex {
                    if let currentVc = pageViewController.viewControllers?.first {
                        if let index = indexOfViewController(viewController: currentVc) {
                            self.selectedIndex = index
                           // menuView.setSelectedIndex(index: index, animated: true)
                        }
                    }
                }
            }
        }
        self.nextIndex = self.selectedIndex
    }
}

