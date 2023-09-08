

class Dragon:Enemy{
    func spitFire(){
        print("Spit fire, does \(attackStength) damage")
    }
    
    override func move() {
        print("Fly forwards.")
    }
}
