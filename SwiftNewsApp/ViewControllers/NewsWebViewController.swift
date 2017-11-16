//
//  NewsWebViewController.swift
//  SwiftNewsApp
//
//  Created by Maneesh Yadav on 29/07/2017.
//  Copyright © 2017 Maneesh Yadav. All rights reserved.
//

import UIKit
import NJKWebViewProgress
import TUSafariActivity

class NewsWebViewController: UIViewController, NJKWebViewProgressDelegate, UIWebViewDelegate {
  
  //MARK: - Dependency
  public var link : String?

  // MARK: - Outlet
  @IBOutlet weak var webView: UIWebView!

  //MARK: - Private Properties
  private var progressView = NJKWebViewProgressView()
  private var progressProxy = NJKWebViewProgress()
  
  // MARK: - Functions
  override func viewDidLoad() {
    super.viewDidLoad()
    guard let link = link, let url = URL(string: link) else { return }
    let urlRequest = URLRequest(url: url)
    webView.loadRequest(urlRequest)
    
    setUpProgressView()
    self.title = "Loading..."
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(action(_:)))
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    self.navigationController?.navigationBar.addSubview(progressView)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(true)
    progressView.removeFromSuperview()
    webView.delegate = nil;
  }
  
  func webViewProgress(_ webViewProgress: NJKWebViewProgress!, updateProgress progress: Float) {
    progressView.setProgress(progress, animated: true)
    self.title = webView.stringByEvaluatingJavaScript(from: "document.title")
  }
  
  fileprivate func setUpProgressView() {
    webView.delegate = progressProxy
    progressProxy.webViewProxyDelegate = self
    progressProxy.progressDelegate = self
  
    let progressBarHeight : CGFloat = 2.0
    guard let navigationBarBounds = self.navigationController?.navigationBar.bounds else { return }
    let barFrame = CGRect.init(x: 0, y: navigationBarBounds.size.height - progressBarHeight, width: (navigationBarBounds.size.width), height: progressBarHeight)
  
    progressView = NJKWebViewProgressView.init(frame: barFrame)
    progressView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
    progressView.progressBarView.backgroundColor = UIColor.white
  }
  
  @IBAction func action(_ sender: UIBarButtonItem) {
    guard
      let link = link,
      let URL = NSURL(string: link)
    else {
      return
    }
    let safariActivity = TUSafariActivity()
    let activityVC = UIActivityViewController(activityItems: [URL], applicationActivities: [safariActivity])
    activityVC.excludedActivityTypes = [.assignToContact];
    self.present(activityVC, animated: true, completion: nil)
  }

}
