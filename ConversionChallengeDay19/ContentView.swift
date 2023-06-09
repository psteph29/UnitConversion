//
//  ContentView.swift
//  ConversionChallengeDay19
//
//  Created by Paige Stephenson on 6/7/23.
//

import SwiftUI

//Length Conversion
//Segmented control for meters, kilometers, feet, yard or miles for input
//second segmented control for meters, kilometers, feet, yard, or miles, for the output unit
//Text field where users enter a number
//Text view showing the result of the conversion


//struct ContentView: View {
//
//    @State private var inputNumber = 0.0
//    @State private var inputUnit = "Meters"
//    @State private var outputUnit = "Kilometers"
//    @FocusState private var inputIsFocused: Bool
//
//    let units = ["Kilometers", "Meters", "Miles", "Yards", "Feet"]
//
//    var result: String {
//        let inputToMetersMultiplier: Double
//        let metersToOutputMultiplier: Double
//        switch inputUnit {
//        case "Kilometers":
//            inputToMetersMultiplier = 1000
//        case "Miles":
//            inputToMetersMultiplier = 1609.34
//        case "Yards":
//            inputToMetersMultiplier = 0.9144
//        case "Feet":
//            inputToMetersMultiplier = 0.3048
//        default:
//            inputToMetersMultiplier = 1.0
//        }
//
//        switch outputUnit {
//        case "Kilometers":
//            metersToOutputMultiplier = 0.001
//        case "Miles":
//            metersToOutputMultiplier = 0.000621371
//        case "Yards":
//            metersToOutputMultiplier = 1.09361
//        case "Feet":
//            metersToOutputMultiplier = 3.28084
//        default:
//            metersToOutputMultiplier = 1.0
//        }
//
//        let inputInMeters = inputNumber * inputToMetersMultiplier
//        let output = inputInMeters * metersToOutputMultiplier
//
//        let outputString = output.formatted()
//        return outputString
//
//    }
//
//
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section {
//                    TextField("Input Number", value: $inputNumber, format: .number)
//                        .focused($inputIsFocused)
//                        .keyboardType(.decimalPad)
//                } header: {
//                    Text("Enter the amount to convert")
//                }
//
//                Picker("Convert From", selection: $inputUnit) {
//                    ForEach(units, id: \.self) {
//                        Text($0)
//                    }
//                }
//
//                Picker("Convert To", selection: $outputUnit) {
//                    ForEach(units, id: \.self) {
//                        Text($0)
//                    }
//                }
//
//                Section {
//                    Text("\(result)")
//                } header: {
//                    Text("Result")
//                }
//
//            }
//            .navigationTitle("Length Conversion")
//            .toolbar {
//                ToolbarItemGroup(placement: .keyboard) {
//                    Spacer()
//
//                    Button("Done") {
//                        inputIsFocused = false
//                    }
//                }
//            }
//        }
//    }
//}
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

//Second solution to use conversion API

struct ContentView: View {
    
    @State private var unitSelection = "Power"
    @State private var selectedInputUnit: Dimension = UnitLength.meters
    @State private var selectedOutputUnit: Dimension = UnitLength.kilometers
    
    @State private var inputNumber = 100.0
    @FocusState private var inputIsFocused: Bool
    
    let unitTypes = ["Length", "Temperature", "Power", "Area", "Duration", "Volume", "Mass", "Pressure", "Energy", "Angle", "Speed"].sorted()
    
    let lengthUnits: [UnitLength] = [UnitLength.feet, UnitLength.meters, UnitLength.miles, UnitLength.decameters, UnitLength.yards, UnitLength.furlongs, UnitLength.astronomicalUnits, UnitLength.fathoms, UnitLength.hectometers, UnitLength.centimeters, UnitLength.millimeters]
    let temperatureUnits: [UnitTemperature] = [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin]
    let powerUnits: [UnitPower] = [UnitPower.watts, UnitPower.femtowatts, UnitPower.horsepower, UnitPower.milliwatts, UnitPower.kilowatts]
    let angleUnits: [UnitAngle] = [UnitAngle.degrees, UnitAngle.radians, UnitAngle.arcMinutes, UnitAngle.arcSeconds, UnitAngle.gradians]
    let durationUnits: [UnitDuration] = [UnitDuration.seconds, UnitDuration.minutes, UnitDuration.hours, UnitDuration.picoseconds, UnitDuration.nanoseconds, UnitDuration.microseconds, UnitDuration.milliseconds]
    let speedUnits: [UnitSpeed] = [UnitSpeed.metersPerSecond, UnitSpeed.milesPerHour, UnitSpeed.kilometersPerHour, UnitSpeed.knots]
    let volumeUnits: [UnitVolume] = [UnitVolume.milliliters, UnitVolume.liters, UnitVolume.cups, UnitVolume.pints, UnitVolume.gallons, UnitVolume.bushels, UnitVolume.fluidOunces, UnitVolume.quarts]
    let areaUnits: [UnitArea] = [UnitArea.acres, UnitArea.squareFeet, UnitArea.squareFeet, UnitArea.squareInches]
    let massUnits: [UnitMass] = [UnitMass.kilograms, UnitMass.grams, UnitMass.milligrams, UnitMass.nanograms, UnitMass.pounds, UnitMass.metricTons, UnitMass.picograms]
    let pressureUnits: [UnitPressure] = [UnitPressure.bars, UnitPressure.millimetersOfMercury, UnitPressure.gigapascals, UnitPressure.hectopascals, UnitPressure.inchesOfMercury, UnitPressure.millibars]
    let energyUnits: [UnitEnergy] = [UnitEnergy.kilocalories, UnitEnergy.calories, UnitEnergy.joules, UnitEnergy.kilocalories, UnitEnergy.kilojoules, UnitEnergy.kilowattHours]
    let defaultValue = [Dimension].self()
    

        var selectedCategory: [Dimension] {
            switch unitSelection {
            case "Length":
                return lengthUnits
            case "Temperature":
                return temperatureUnits
            case "Power":
                return powerUnits
            case "Area":
                return areaUnits
            case "Duration":
                return durationUnits
            case "Volume":
                return volumeUnits
            case "Mass":
                return massUnits
            case "Pressure":
                return pressureUnits
            case "Energy":
                return energyUnits
            case "Angle":
                return angleUnits
            case "Speed":
                return speedUnits
            default:
                return defaultValue
            }
        }


    let formatter: MeasurementFormatter

    var result: String {
        let inputMeasurement = Measurement(value: inputNumber, unit: selectedInputUnit)
        let outputMeasurement = inputMeasurement.converted(to: selectedOutputUnit)
        return formatter.string(from: outputMeasurement)
    }

    var body: some View {
        NavigationView {
            Form {
                Picker("Select conversion unit type", selection: $unitSelection) {
                    ForEach(unitTypes, id: \.self) {
                        Text($0)
                    }

                }

                Section {
                    TextField("Input Number", value: $inputNumber, format: .number)
                        .focused($inputIsFocused)
                        .keyboardType(.decimalPad)
                } header: {
                    Text("Enter the amount to convert")
                }

                Picker("Convert From", selection: $selectedInputUnit) {
                    ForEach(selectedCategory, id: \.self) { unit in
                        Text(formatter.string(from: unit).capitalized)
                    }
                }

                Picker("Convert To", selection: $selectedOutputUnit) {
                    ForEach(selectedCategory, id: \.self) { unit in
                        Text(formatter.string(from: unit).capitalized)
                    }
                }

                Section {
                    Text(result)
                } header: {
                    Text("Result")
                }
                
            }
            
            
            .navigationTitle("Length Conversion")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
        }
    }
    init() {
        formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .long
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

