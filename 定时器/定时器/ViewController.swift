//
//  ViewController.swift
//  定时器
//
//  Created by strong on 2017/6/30.
//  Copyright © 2017年 strong. All rights reserved.



import UIKit

class ViewController: UIViewController {
    var timeCount = 10
    var timeP:Timer?
    var link : CADisplayLink?
    
    
    @IBOutlet weak var bel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
//开始计时
    @IBAction func startBtn(_ sender: Any) {

    
        self.gcdTextChanges()
//        self.timerText()
//        self.linkTimer()   

    }

    
    //MARK: 使用Timer
    func timerText()  {
        self.timeP = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (Timer) in
        if self.timeCount <= 0 {
        //取消时间
        self.timeP?.invalidate()
        self.bel.text = "发送完成"
//        print("222")
        }
        else{
            self.timeCount = self.timeCount - 1
            self.bel.text = String(format: "剩余%02d秒", self.timeCount)
//            print("333")
           }
       
        }
    }
    //MARK:使用gcd时间源DispatchSource
    func gcdTextChanges() {
        // 定义需要计时的时间
        var timeCount = 10
        // 创建一个时间源
        let codeTimer = DispatchSource.makeTimerSource( queue:DispatchQueue.global())
        // 设定这个时间源每秒循环一次，立即开始
        codeTimer.scheduleRepeating(deadline: .now(), interval: .seconds(1))
        // 设定时间源的触发事件
        codeTimer.setEventHandler(handler: {
            // 每秒计时一次
            timeCount = timeCount - 1
            if timeCount <= 0 {
               // 取消时间源
                codeTimer.cancel()
                DispatchQueue.main.async {
                   self.bel.text = "完成"
                }
            }
            else{
                DispatchQueue.main.async {
                self.bel.text = String(format: "剩余%02d秒", timeCount)
                }
            }
           
        })
        // 启动时间源
        codeTimer.resume()
    }
    
    //MARK:使用CADisplayLink
    func linkTimer() {
        let link = CADisplayLink(target: self, selector: #selector(changeTimer))
        //时间间隔1秒   CADisplayLink是每秒60帧(即是1/60秒)
        link.frameInterval = 60
        link.add(to: RunLoop.current, forMode: .commonModes)
        self.link = link
    }
    func changeTimer ()  {
        if self.timeCount <= 0{
            self.link?.invalidate()
            self.bel.text = "发送完成"
//            print("222")
        }
        else{
            self.timeCount = self.timeCount - 1
            self.bel.text = String(format: "剩余%02d秒", self.timeCount)
//            print("333")
        }
    }
    
}

