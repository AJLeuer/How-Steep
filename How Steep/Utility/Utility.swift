import Foundation

func formatGradientForDisplay(gradient : Double) -> String
{
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = NumberFormatter.Style.percent
    
    return numberFormatter.string(from: gradient as NSNumber)!
}
