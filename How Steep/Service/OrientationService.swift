import Foundation
import CoreMotion

class OrientationService : ObservableObject {
    private var motionManager: CMMotionManager = CMMotionManager()

    @Published
    public var gradientAbsoluteValue: Double = 0

    @objc
    private var gradientOffset: Double = 0

    public var gradient: Double
    {
        get
        {
            return gradientAbsoluteValue - gradientOffset
        }
    }

    private var dataUpdateTimer: Timer? = nil

    public init()
    {
        motionManager.startDeviceMotionUpdates()
        dataUpdateTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: self.computeCurrentGradient)
        loadSavedState()
    }

    deinit
    {
        motionManager.stopDeviceMotionUpdates()
    }

    public func loadSavedState()
    {
        let gradientOffsetKey: String = #keyPath(OrientationService.gradientOffset)

        if UserDefaults.standard.object(forKey: gradientOffsetKey) != nil
        {
            gradientOffset = UserDefaults.standard.double(forKey: gradientOffsetKey)
        }
    }

    public func saveCurrentGradientAsOffset()
    {
        gradientOffset = gradientAbsoluteValue

        let gradientOffsetKey: String = #keyPath(OrientationService.gradientOffset)
        UserDefaults.standard.set(gradientOffset, forKey: gradientOffsetKey)
    }
    
    public func computeCurrentGradient(_ : Timer)
    {
        gradientAbsoluteValue = convertRadiansToGradient(radians : motionManager.deviceMotion?.attitude.pitch);
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
            return percent;
        }
    }

}
