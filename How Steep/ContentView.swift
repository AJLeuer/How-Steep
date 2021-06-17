import SwiftUI
import CoreMotion


struct ContentView: View
{
    @ObservedObject
    var orientationService : OrientationService = OrientationService()
    
    var body: some View
    {
        Text(formatGradient())
            .font(.system(size: 120.0))
    }
    
    func formatGradient() -> String
    {
        let gradient : Double = orientationService.gradient
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.percent
        
        return numberFormatter.string(from: gradient as NSNumber)!
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ContentView()
    }
}


