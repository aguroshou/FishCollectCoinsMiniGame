//
//  TestScene.swift
//

import Foundation
import SpriteKit
struct Point {
    var x:Double = 0
    var y:Double = 0
}

func angle(a:Point, b:Point) -> Double {
    var r = atan2(b.y - a.y, b.x - a.x)
    if r < 0 {
        r = r + 2 * .pi
    }
    return floor(r * 360 / (2 * .pi))
}
class TestScene:SKScene {
    
    var ball:SKSpriteNode!
    var fish:SKSpriteNode!
    var fishSpeedX = 0.0
    var fishSpeedY = 0.0
    var coin1:SKSpriteNode!
    var coin2:SKSpriteNode!
    var coin3:SKSpriteNode!
    var syuriken1:SKSpriteNode!
    var syuriken1SpeedY = 0.0
    var syuriken2:SKSpriteNode!
    var syuriken2SpeedX = 0.0
    var syuriken3:SKSpriteNode!
    var syuriken3Speed = 0.0
    var syuriken3Angle = 0.0
    var syuriken4:SKSpriteNode!
    var syuriken4Speed = 0.0
    var syuriken4Angle = 0.0
    var syuriken5:SKSpriteNode!
    var syuriken5Speed = 0.0
    var syuriken5SpeedX = 0.0
    var syuriken5SpeedY = 0.0
    var syuriken5Angle = 0.0
    var gameover:SKSpriteNode!
    var restart:SKSpriteNode!
    
    var beganLocation=CGPoint(x:0.0,y:0.0)
    var dragLocation=CGPoint(x:0.0,y:0.0)
    var ballLocation = CGPoint(x:0.0, y:0.0)
    
    var score = 0
    var timer = 0
    var isGameOver = false
    var isLabelExist = false
    var scoreLabel = SKLabelNode()
    
    //現在シーン設定時の呼び出しメソッド
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.white
        //シーンを画面サイズに合わせる。
        self.scaleMode = .aspectFit
        
        //画面端に物理ボディを設定する。
        //self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        //ボールノードを取得する。
        ball = self.childNode(withName: "ball") as? SKSpriteNode
        //フィッシュノードを取得する。
        fish = self.childNode(withName: "fish") as? SKSpriteNode
        //コインノードを取得する。
        coin1 = self.childNode(withName: "coin1") as? SKSpriteNode
        coin2 = self.childNode(withName: "coin2") as? SKSpriteNode
        coin3 = self.childNode(withName: "coin3") as? SKSpriteNode
        //手裏剣ノードを取得する。
        syuriken1 = self.childNode(withName: "syuriken1") as? SKSpriteNode
        syuriken2 = self.childNode(withName: "syuriken2") as? SKSpriteNode
        syuriken3 = self.childNode(withName: "syuriken3") as? SKSpriteNode
        syuriken4 = self.childNode(withName: "syuriken4") as? SKSpriteNode
        syuriken5 = self.childNode(withName: "syuriken5") as? SKSpriteNode
        //画像ノードを取得する。
        gameover = self.childNode(withName: "gameover") as? SKSpriteNode
        restart = self.childNode(withName: "restart") as? SKSpriteNode
        
        ballLocation = CGPoint(x: self.frame.midX, y: self.frame.midY)
        fish.position = CGPoint(x: self.frame.midX, y: self.frame.midY-5.0)
        coin1.position=CGPoint(x:Double((arc4random() % (UInt32(self.frame.maxX)-20))+10),y:Double((arc4random() % (UInt32(self.frame.maxY)-20))+10))
        scoreLabel.text = "SCORE:\(score)";
        scoreLabel.fontName = "Times New Roman"
        scoreLabel.fontSize = 15;
        scoreLabel.position = CGPoint(x:self.frame.midX, y:5.5);
        scoreLabel.fontColor = SKColor.black
        self.addChild(scoreLabel)
        self.removeChildren(in: [scoreLabel])
    }
    //画面タッチ時の呼び出しメソッド
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        beganLocation = touches.first!.location(in: self)
        dragLocation = touches.first!.location(in: self)
        if isGameOver == true && timer>40 {
            timer = 0
            score = 0
            ballLocation = CGPoint(x: self.frame.midX, y: self.frame.midY)
            fish.position = CGPoint(x: self.frame.midX, y: self.frame.midY-5.0)
            coin1.position=CGPoint(x:Double((arc4random() % (UInt32(self.frame.maxX)-20))+10),y:Double((arc4random() % (UInt32(self.frame.maxY)-20))+10))
            coin2.position=CGPoint(x:-100.0,y:-100.0)
            coin3.position=CGPoint(x:-100.0,y:-100.0)
            fishSpeedX=0.0
            fishSpeedY=0.0
            syuriken1.position=CGPoint(x:-100.0,y:-100.0)
            syuriken1SpeedY=0.0
            syuriken2.position=CGPoint(x:-100.0,y:-100.0)
            syuriken2SpeedX=0.0
            syuriken3.position=CGPoint(x:-100.0,y:-100.0)
            syuriken3Speed=0.0
            syuriken4.position=CGPoint(x:-100.0,y:-100.0)
            syuriken4Speed=0.0
            syuriken5.position=CGPoint(x:-100.0,y:-100.0)
            syuriken5Speed=0.0
            isGameOver = false
            gameover.position = CGPoint(x: -100.0, y: -100.0)
            restart.position = CGPoint(x: -100.0, y: -100.0)
        }
    }

    
    //画面タッチ移動時の呼び出しメソッド
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        dragLocation = touches.first!.location(in: self)
    }
    //画面タッチ終了時の呼び出しメソッド
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        ballLocation = CGPoint(x:min(max(ballLocation.x-beganLocation.x+dragLocation.x,0.0),self.frame.maxX), y:min(max(ballLocation.y-beganLocation.y+dragLocation.y,0.0),self.frame.maxY))
        beganLocation=CGPoint(x:0.0,y:0.0)
        dragLocation=CGPoint(x:0.0,y:0.0)
        
    }

    //1フレームごとの呼び出しメソッド
    override func update(_ currentTime: TimeInterval) {
        if isGameOver == true{
            gameover.position = CGPoint(x: self.frame.midX, y: self.frame.midY+50.0)
            restart.position = CGPoint(x: self.frame.midX, y: self.frame.midY-50.0)
            timer += 1
        }
        else{
            //タッチした位置まで移動するアクションを作成する。
            let ballAction = SKAction.move(to: CGPoint(x:ballLocation.x-beganLocation.x+dragLocation.x, y:ballLocation.y-beganLocation.y+dragLocation.y), duration:0.1)
            //アクションを実行する。
            ball.run(ballAction)
            
            //ボールの位置まで回転するアクションを作成する。
            let fishRotateAction = SKAction.rotate(toAngle: CGFloat((angle(a: Point(x: Double(fish.position.x), y: Double(fish.position.y)), b: Point(x: Double(ball.position.x), y: Double(ball.position.y))))+180) * .pi/180, duration: 0.0)
            //アクションを実行する。
            fish.run(fishRotateAction)
            fishSpeedX+=cos(angle(a: Point(x: Double(fish.position.x), y: Double(fish.position.y)), b: Point(x: Double(ball.position.x), y: Double(ball.position.y))) * .pi/180)
            fishSpeedY+=sin(angle(a: Point(x: Double(fish.position.x), y: Double(fish.position.y)), b: Point(x: Double(ball.position.x), y: Double(ball.position.y))) * .pi/180)
            if fishSpeedX<0 && Double(fish.position.x)<0 {
                fishSpeedX = -fishSpeedX * 0.8
            }
            if fishSpeedX>0 && fish.position.x>self.frame.maxX {
                fishSpeedX = -fishSpeedX * 0.8
            }
            if fishSpeedY<0 && Double(fish.position.y)<0 {
                fishSpeedY = -fishSpeedY * 0.8
            }
            if fishSpeedY>0 && fish.position.y>self.frame.maxY {
                fishSpeedY = -fishSpeedY * 0.8
            }
            fish.position=CGPoint(x:Double(fish.position.x)+fishSpeedX/60.0,y:Double(fish.position.y)+fishSpeedY/60.0)
            //fish.position.y+=fishSpeedY
            
            //タッチした位置まで移動するアクションを作成する。
            let fishMoveAction = SKAction.rotate(toAngle: CGFloat(angle(a: Point(x: Double(fish.position.x), y: Double(fish.position.y)), b: Point(x: Double(ball.position.x), y: Double(ball.position.y)))) * .pi/180, duration: 0.1)
            //アクションを実行する。
            fish.run(fishMoveAction)
            if (timer == 100){
                syuriken1.position=CGPoint(x:Double((arc4random() % UInt32(self.frame.maxX-10))+5),y:Double(-100.0))
                syuriken1SpeedY = 1.0
            }
            //syuriken1
            if (Double(syuriken1.position.y) < -100.0&&syuriken1SpeedY<0.0){
                syuriken1SpeedY = -syuriken1SpeedY
                syuriken1.position=CGPoint(x:Double((arc4random() % UInt32(self.frame.maxX-10))+5),y:Double(syuriken1.position.y))
            }
            if (syuriken1.position.y > self.frame.maxY+100&&syuriken1SpeedY>0.0){
                syuriken1SpeedY = -syuriken1SpeedY
                syuriken1.position=CGPoint(x:Double((arc4random() % UInt32(self.frame.maxX-10))+5),y:Double(syuriken1.position.y))
            }
        syuriken1.position=CGPoint(x:Double(syuriken1.position.x),y:Double(syuriken1.position.y)+syuriken1SpeedY)

            //syuriken2
            if (timer == 500){
                syuriken2.position=CGPoint(x:Double(-100.0),y:Double((arc4random() % UInt32(self.frame.maxY-10))+5))
                syuriken2SpeedX = 1.0
            }
            if (Double(syuriken2.position.x) < -100.0&&syuriken2SpeedX<0.0){
                syuriken2SpeedX = -syuriken2SpeedX
                syuriken2.position=CGPoint(x:Double(syuriken2.position.x),y:Double((arc4random() % UInt32(self.frame.maxY-10))+5))
            }
            if (syuriken2.position.x > self.frame.maxX+100&&syuriken2SpeedX>0.0){
                syuriken2SpeedX = -syuriken2SpeedX
                syuriken2.position=CGPoint(x:Double(syuriken2.position.x),y:Double((arc4random() % UInt32(self.frame.maxY-10))+5))
            }
            syuriken2.position=CGPoint(x:Double(syuriken2.position.x)+syuriken2SpeedX,y:Double(syuriken2.position.y))
            if (pow(Double(fish.position.x - coin1.position.x),2.0)+pow(Double(fish.position.y - coin1.position.y),2.0)<400.0) {
                score += 10
                coin1.position=CGPoint(x:Double((arc4random() % UInt32(self.frame.maxX-5))+10),y:Double((arc4random() % UInt32(self.frame.maxY-5))+10))
            }
            //syuriken3
            if (timer == 1000){
                syuriken3.position=CGPoint(x:Double(0.0),y:Double(-100.0))
                syuriken3Speed = 1.0
            }
            if (timer % 700 == 0){
                syuriken3Angle = angle(a: Point(x: Double(syuriken3.position.x), y: Double(syuriken3.position.y)), b: Point(x: Double(fish.position.x), y: Double(fish.position.y))) * .pi/180
            }
            syuriken3.position = CGPoint(x:Double(syuriken3.position.x)+cos(syuriken3Angle)*syuriken3Speed,y:Double(syuriken3.position.y)+sin(syuriken3Angle)*syuriken3Speed)
            //syuriken4
            if (timer == 1500){
                syuriken4.position=CGPoint(x:Double(0.0),y:Double(self.frame.maxY+100))
                syuriken4Speed = 0.5
            }
            
            syuriken4Angle = angle(a: Point(x: Double(syuriken4.position.x), y: Double(syuriken4.position.y)), b: Point(x: Double(fish.position.x), y: Double(fish.position.y))) * .pi/180
            
            syuriken4.position = CGPoint(x:Double(syuriken4.position.x)+cos(syuriken4Angle)*syuriken4Speed,y:Double(syuriken4.position.y)+sin(syuriken4Angle)*syuriken4Speed)
            //syuriken5
            if (timer == 2000){
                syuriken5.position=CGPoint(x:Double(0.0),y:Double(-100.0))
                syuriken5Speed = 1.0
            }
            if (Double(syuriken5.position.x)<0.0||Double(syuriken5.position.x)>320.0||Double(syuriken5.position.y)<0.0||Double(syuriken5.position.y)>560.0){
                syuriken5Angle = Double(arc4random() % 360) * .pi/180
                syuriken5SpeedX = cos(syuriken5Angle)
                syuriken5SpeedY = sin(syuriken5Angle)
                if Double(syuriken5.position.x)<0.0 && syuriken5SpeedX<0.0{
                    syuriken5SpeedX = -syuriken5SpeedX
                }
                if syuriken5.position.x>self.frame.maxX && syuriken5SpeedX>0.0{
                    syuriken5SpeedX = -syuriken5SpeedX
                }
                if Double(syuriken5.position.y)<0.0 && syuriken5SpeedY<0.0{
                    syuriken5SpeedY = -syuriken5SpeedY
                }
                if syuriken5.position.y>self.frame.maxY && syuriken5SpeedY>0.0{
                    syuriken5SpeedY = -syuriken5SpeedY
                }
            }
            syuriken5.position = CGPoint(x:Double(syuriken5.position.x)+syuriken5SpeedX*syuriken5Speed,y:Double(syuriken5.position.y)+syuriken5SpeedY*syuriken5Speed)
            if (pow(Double(syuriken1.position.x - fish.position.x),2.0)+pow(Double(syuriken1.position.y - fish.position.y),2.0)<400.0) {
                isGameOver = true
                timer = 0
            }
            if (pow(Double(syuriken2.position.x - fish.position.x),2.0)+pow(Double(syuriken2.position.y - fish.position.y),2.0)<400.0) {
                isGameOver = true
                timer = 0
            }
            if (pow(Double(syuriken3.position.x - fish.position.x),2.0)+pow(Double(syuriken3.position.y - fish.position.y),2.0)<400.0) {
                isGameOver = true
                timer = 0
            }
            if (pow(Double(syuriken4.position.x - fish.position.x),2.0)+pow(Double(syuriken4.position.y - fish.position.y),2.0)<400.0) {
                isGameOver = true
                timer = 0
            }
            if (pow(Double(syuriken5.position.x - fish.position.x),2.0)+pow(Double(syuriken5.position.y - fish.position.y),2.0)<400.0) {
                isGameOver = true
                timer = 0
            }
            //回転のアクションを実行する。
            let rotateAction = SKAction.rotate(byAngle: 0.1 , duration: 0)
            syuriken1.run(rotateAction)
            syuriken2.run(rotateAction)
            syuriken3.run(rotateAction)
            syuriken4.run(rotateAction)
            syuriken5.run(rotateAction)
            if (pow(Double(fish.position.x - coin1.position.x),2.0)+pow(Double(fish.position.y - coin1.position.y),2.0)<800.0) {
                score += 10
                coin1.position=CGPoint(x:Double((arc4random() % UInt32(self.frame.maxX-5))+10),y:Double((arc4random() % UInt32(self.frame.maxY-5))+10))
            }
            if (pow(Double(fish.position.x - coin2.position.x),2.0)+pow(Double(fish.position.y - coin2.position.y),2.0)<800.0) {
                score += 20
                coin2.position=CGPoint(x:Double((arc4random() % UInt32(self.frame.maxX-5))+10),y:Double((arc4random() % UInt32(self.frame.maxY-5))+10))
            }
            if (pow(Double(fish.position.x - coin3.position.x),2.0)+pow(Double(fish.position.y - coin3.position.y),2.0)<800.0) {
                score += 30
                coin3.position=CGPoint(x:Double((arc4random() % UInt32(self.frame.maxX-5))+10),y:Double((arc4random() % UInt32(self.frame.maxY-5))+10))
            }
            switch timer{
            case 2000:
                coin2.position=CGPoint(x:Double((arc4random() % UInt32(self.frame.maxX-5))+10),y:Double((arc4random() % UInt32(self.frame.maxY-5))+10))
            case 4000:
               coin3.position=CGPoint(x:Double((arc4random() % UInt32(self.frame.maxX-5))+10),y:Double((arc4random() % UInt32(self.frame.maxY-5))+10))
            case 2500:
                syuriken1SpeedY*=1.5
            case 3000:
                syuriken2SpeedX*=1.5
            case 3500:
                syuriken3Speed*=1.5
            case 4001:
                syuriken4Speed*=1.5
            case 4500:
                syuriken5Speed*=1.5
            case 5000:
                syuriken1SpeedY*=1.5
            case 5500:
                syuriken2SpeedX*=1.5
            case 6000:
                syuriken3Speed*=1.5
            case 6500:
                syuriken4Speed*=1.5
            case 7000:
                syuriken5Speed*=1.5
            case 7500:
                syuriken1SpeedY*=1.5
            case 8000:
                syuriken2SpeedX*=1.5
            case 8500:
                syuriken3Speed*=1.5
            case 9000:
                syuriken4Speed*=1.5
            case 9500:
                syuriken5Speed*=1.5
            default:
                break
            }
            timer += 1
            if timer == 1000000000 {timer = 0}
            scoreLabel.text = "SCORE:\(score)";
            self.removeChildren(in: [scoreLabel])
            self.addChild(scoreLabel)
        }
    }
}
