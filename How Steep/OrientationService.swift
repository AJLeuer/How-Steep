import Foundation
import CoreMotion

class OrientationService : ObservableObject
{
    private var motionManager : CMMotionManager = CMMotionManager()

    @Published
    public var gradient: Double = 0
    
    private var dataUpdateTimer : Timer? = nil
 
    public init()
    {
        motionManager.startDeviceMotionUpdates()
        dataUpdateTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: self.computeCurrentGradient)
    }
    
    deinit
    {
        motionManager.stopDeviceMotionUpdates()
    }
    
    public func computeCurrentGradient(_ : Timer)
    {
        gradient = convertRadiansToGradient(radians : motionManager.deviceMotion?.attitude.pitch);
    }
    
    private func convertRadiansToGradient(radians : Double?) -> Double
    {
        if radians == nil
        {
            return 0.0
        }
        else
        {
            let percent : Double = ((400 / Double.pi) * (radians!)) / 100
            print(percent)
            return percent;
        }
    }

}
