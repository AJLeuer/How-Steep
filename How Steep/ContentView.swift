import SwiftUI
import CoreMotion


struct ContentView: View
{
    @ObservedObject
    var orientationService : OrientationService

    init(orientationService: OrientationService)
    {
        self.orientationService = orientationService
    }

    var body: some View
    {
        Text(formatGradientForDisplay(gradient: orientationService.gradient))
            .font(.system(size: 120.0))
        Button(action: orientationService.saveCurrentGradientAsOffset)
        {
            Text("Set Baseline")
        }
        .padding()
        .foregroundColor(.white)
        .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor(rgb: 0x00bdff)), Color(UIColor(rgb: 0x005e80))]), startPoint: .leading, endPoint: .trailing))
        .cornerRadius(15)
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ContentView(orientationService: OrientationService())
    }
}


