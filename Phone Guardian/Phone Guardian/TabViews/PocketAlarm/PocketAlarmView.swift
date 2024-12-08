//
//  PocketAlarmView.swift
//  Phone Guardian
//
//  Created by Tipu Sultan on 12/2/24.
//

//
//  PocketAlarmView.swift
//  Phone Guardian
//
//  Created by Tipu Sultan on 12/2/24.
//

import SwiftUI
import CoreMotion
import AVFoundation

struct PocketAlarmView: View {
    @State private var isAlarmEnabled = false
    @State private var isInPocket = false
    @State private var motionManager = CMMotionManager()
    @State private var audioPlayer: AVAudioPlayer?

    var body: some View {
        VStack {
            Text("Pocket Alarm")
                .font(.largeTitle)
                .padding()

            Spacer()

            // Status Indicator
            Text(isAlarmEnabled ? "Alarm is Active" : "Alarm is Disabled")
                .font(.headline)
                .foregroundColor(isAlarmEnabled ? .green : .red)
                .padding()

            // Toggle Button
            Button(action: toggleAlarm) {
                Text(isAlarmEnabled ? "Disable Alarm" : "Enable Alarm")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200)
                    .background(isAlarmEnabled ? Color.red : Color.blue)
                    .cornerRadius(15)
            }

            Spacer()

            Text("Ensure your phone is in your pocket for this feature to work.")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding()
        }
        .onAppear(perform: setupMotionDetection)
        .onDisappear(perform: stopMotionDetection)
    }

    // MARK: - Toggle Alarm
    private func toggleAlarm() {
        isAlarmEnabled.toggle()

        if isAlarmEnabled {
            checkPocketState()
        } else {
            stopAlarm()
        }
    }

    // MARK: - Motion Detection Setup
    private func setupMotionDetection() {
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: .main) { data, error in
            guard let data = data else { return }
            let acceleration = abs(data.acceleration.x) + abs(data.acceleration.y) + abs(data.acceleration.z)

            // Pocket detection logic (arbitrary threshold for motion)
            isInPocket = acceleration < 0.5
            if isAlarmEnabled && !isInPocket {
                playAlarm()
            }
        }
    }

    private func stopMotionDetection() {
        motionManager.stopAccelerometerUpdates()
    }

    // MARK: - Alarm Logic
    private func checkPocketState() {
        if !isInPocket {
            playAlarm()
        }
    }

    private func playAlarm() {
        guard let soundURL = Bundle.main.url(forResource: "alarm", withExtension: "mp3") else {
            print("Alarm sound file not found.")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
        } catch {
            print("Failed to play alarm sound: \(error.localizedDescription)")
        }
    }

    private func stopAlarm() {
        audioPlayer?.stop()
    }
}

#Preview {
    PocketAlarmView()
}
