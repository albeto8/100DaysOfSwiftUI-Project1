//
//  ContentView.swift
//  WeSplit
//
//  Created by Mario Alberto Barragan Espinosa on 10/9/19.
//  Copyright © 2019 Mario Alberto Barragan Espinosa. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State private var checkAmount = ""
  //@State private var numberOfPeople = 2
  @State private var numberOfPeople = ""
  @State private var tipPercentage = 2

  let tipPercentages = [10, 15, 20, 25, 0]

  var totalPerPerson: Double {
    // calculate the total per person here
    let peopleCount = Double(numberOfPeople) ?? 1
    //let peopleCount = Double(peopleValue + 2)
    let tipSelection = Double(tipPercentages[tipPercentage])
    let orderAmount = Double(checkAmount) ?? 0
    let tipValue = orderAmount / 100 * tipSelection
    let grandTotal = orderAmount + tipValue
    let amountPerPerson = grandTotal / peopleCount

    return amountPerPerson
  }

  var totalAmount: Double {
    let orderAmount = Double(checkAmount) ?? 0
    let tipSelection = Double(tipPercentages[tipPercentage])
    let tipValue = orderAmount / 100 * tipSelection

    return orderAmount + tipValue
  }

  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField("Amount", text: $checkAmount)
            .keyboardType(.decimalPad)
          TextField("Number of people", text: $numberOfPeople)
            .keyboardType(.decimalPad)

          /*
          Picker("Number of people", selection: $numberOfPeople) {
            ForEach(2 ..< 100) {
              Text("\($0) people")
            }
          }
          */
        }

        Section(header: Text("How much tip do you want to leave?")) {
          Picker("Tip percentage", selection: $tipPercentage) {
            ForEach(0 ..< tipPercentages.count) {
              Text("\(self.tipPercentages[$0])%")
            }
          }.pickerStyle(SegmentedPickerStyle())
        }

        Section(header: Text("Amount per person")) {
          Text("$\(totalPerPerson, specifier: "%.2f")")
        }

        Section(header: Text("Total amount")) {
            Text("$\(totalAmount, specifier: "%.2f")")
                .foregroundColor(tipPercentage == 4 ? Color.red : .black)
        }
      }
      .navigationBarTitle("WeSplit")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
      ContentView()
  }
}
