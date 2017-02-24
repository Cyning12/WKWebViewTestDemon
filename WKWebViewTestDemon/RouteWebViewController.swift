//
//  RouteWebViewController.swift
//  TestAnyThing
//
//  Created by 刘新宁 on 2017/2/15.
//  Copyright © 2017年 刘新宁. All rights reserved.
//

import UIKit
import WebKit


class RouteWebViewController: UIViewController,WKNavigationDelegate,WKUIDelegate,UIAlertViewDelegate  {
    
    lazy var alertViewController : UIAlertController = {
        return UIAlertController.init(title: "我是一个VC", message: "message", preferredStyle: UIAlertControllerStyle.alert)
    }()
    
    var OKAlertAction : UIAlertAction = UIAlertAction()
    
    var CancelAlertAction : UIAlertAction = UIAlertAction()
    
    var clickButtonTime : Int = 0
    
    let webView : WKWebView = {
        let webConfig = WKWebViewConfiguration();

        let webView = WKWebView(frame: CGRect.zero, configuration: webConfig)
        
        return webView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.__setupWebView()
    }
    @IBOutlet weak var webPlaceholderView: UIView!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func __setupWebView(){
        self.webView.frame = self.webPlaceholderView.bounds;
        self.webView.navigationDelegate = self
        self.webView.uiDelegate = self
        
        let indexPath = Bundle.main.path(forResource: "index", ofType: "html")
        let fileUrl = URL.init(fileURLWithPath: indexPath!)
//        self.webView.load(URLRequest.init(url: fileRrl!))
        
        self.webView.loadFileURL(fileUrl, allowingReadAccessTo: fileUrl)
        
    }
    //MARK: - WKUIDelegate
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        print("confirm message : \(message)")
        
        completionHandler(true)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        print("webView run JS: \(message) ")
        completionHandler()
    }

    
    //MARK: - WKNavigationDelegate
    
    /**
     执行层级：①
     webView发起请求之前调用
     allow后才会进行后面的代理方法
     decisionHandler 必须执行
     - parameter webView:          响应webView
     - parameter navigationAction: 包含响应事件的信息对象
     - parameter decisionHandler:  回调block，参数:allow or cancel
     */
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        debugPrint("class: \(object_getClassName(self))" + #function + "LINE: \(#line)")
        let url = navigationAction.request.url
        let urlString   = url?.absoluteString
        let components  = url?.pathComponents
        if (urlString?.hasPrefix("https") == true ||
            urlString?.hasPrefix("http") == true  ||
            urlString?.hasPrefix("file") == true  ){
           decisionHandler(.allow)
        }else {
            decisionHandler(.cancel)
        }
        
        debugPrint("urlString : \(components)")
    }
    /**
     执行层级：③
     URL响应正确,接收到相应数据后,决定是否跳转
     decisionHandler 必须执行
     - parameter webView:            响应webView
     - parameter navigationResponse: 请求地址
     - parameter decisionHandler:    回调block，参数:allow or cancel
     */
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        debugPrint("class: \(object_getClassName(self))" + #function + "LINE: \(#line)")

        decisionHandler(WKNavigationResponsePolicy.allow)
        
    }
    /**
     执行层级：②
     允许请求后开始
     
     - parameter webView:    响应webView
     - parameter navigation: navigation
     */
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        debugPrint("class: \(object_getClassName(self))" + #function + "LINE: \(#line)")
    }
    /**
     主机地址被重定向时调用
     
     - parameter webView:    webView description
     - parameter navigation: navigation description
     */
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        debugPrint("class: \(object_getClassName(self))" + #function + "LINE: \(#line)")
    }
    /**
     执行层级：④
     页面加载失败时调用
     
     - parameter webView:    响应webView
     - parameter navigation: navigation
     - parameter error:      error
     */
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        debugPrint(#function + "\nerror: \(error.localizedDescription)")
    }
    /**
     执行层级:④
     当内容开始返回时调用
     
     - parameter webView:    webView description
     - parameter navigation: navigation description
     */
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        debugPrint("class: \(object_getClassName(self))" + #function + "LINE: \(#line)")
        
    }
    /**
     执行层级:⑤
     内容接受完毕后（JS等执行完毕后,在此之前执行 WKUIDelegate 的对应方法）
     
     - parameter webView:    webView
     - parameter navigation: navigation
     */
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.webPlaceholderView.addSubview(self.webView)
        self.navigationItem.title = webView.title;
        debugPrint("class: \(object_getClassName(self))" + #function + "LINE: \(#line)")
        self.webView.evaluateJavaScript("myFunction()") { (object, error) in
            
        }
    }
    /**
     跳转失败时调用
     
     - parameter webView:    webView description
     - parameter navigation: navigation description
     - parameter error:      error description
     */
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        debugPrint("class: \(object_getClassName(self))" + #function + "LINE: \(#line)")
        
    }
    /**
     在访问资源的时候，如果服务器返回需要授权(提供一个NSURLCredential对象)
     
     - parameter webView:           webView description
     - parameter challenge:         challenge description
     - parameter completionHandler:   completionHandler description
     */
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        debugPrint("class: \(object_getClassName(self))" + #function + "LINE: \(#line)")
        
        // 认证服务器证书
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            debugPrint("获得服务端证书认证！")
            completionHandler(.performDefaultHandling, nil)
            /*
             /*
                将服务端证书与本地证书对比
             */
            completionHandler(.performDefaultHandling, nil)
            let serverTrust:SecTrust = challenge.protectionSpace.serverTrust!
            let certificate = SecTrustGetCertificateAtIndex(serverTrust, 0)!
            let remoteCertificateData
                = CFBridgingRetain(SecCertificateCopyData(certificate))!
            let cerPath = Bundle.main.path(forResource: "tomcat", ofType: "cer")!
            let localCertificateData = NSData(contentsOfFile:cerPath)!
            // 对比证书
            if (remoteCertificateData.isEqual(to: localCertificateData as Data) == true) {
             // 将客户端证书返回给服务端
                let credential = URLCredential.init(trust: serverTrust)
                challenge.sender?.use(credential,
                                      for: challenge)
                completionHandler(.useCredential,
                                  URLCredential.init(trust: challenge.protectionSpace.serverTrust!))
                
            } else {
             // 认证不通过取消请求
                completionHandler(.cancelAuthenticationChallenge, nil)
            }
             */
        }else if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodClientCertificate{
            debugPrint("客户端证书认证！")
            //获取客户端证书相关信息
            
            completionHandler(.useCredential, nil);
        }else {
            debugPrint("其它情况（不接受认证）")
            completionHandler(.cancelAuthenticationChallenge, nil);
        }
        
    }
    /**
     9.0 later，web内容处理中断时会触发
     
     - parameter webView: webView description
     */
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
       debugPrint("class: \(object_getClassName(self))" + #function + "LINE: \(#line)")
    }
    
    @IBAction func close(_ sender: UIButton) {
        self.navigationController?.dismiss(animated: true, completion: {
            
        })
    }
    
    @IBAction func refresh(_ sender: UIButton) {
        if self.webView.url == nil {
            debugPrint("webview's url is nil")
        }else{
            self.webView.reload()
        }
    }

}
