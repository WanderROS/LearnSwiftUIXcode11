//
//  ContentView.swift
//  LearnSwiftUIXcode11
//
//  Created by wander on 2021/10/18.
//  Copyright © 2021 xcode11. All rights reserved.
//

import SwiftUI
import Combine


class ReactiveFormModel : ObservableObject {

    @Published var firstEntry: String = "" {
        didSet {
            firstEntryPublisher.send(self.firstEntry)
        }
    }
    private let firstEntryPublisher = CurrentValueSubject<String, Never>("")
    
    // NOTE(heckj): this didSet {} structure and the CurrentValueSubject
    // firstEntryPublisher could be removed.
    //
    // The @Published property wrapper presents a publisher
    // for the values as they change.
    //
    // It's not entirely obvious, but the relevant publisher is
    // _firstEntry.projectedValue which is an instance of the type
    // Published<String>.Publisher - with an Output type of String
    // and a failure type of Never.
    @Published var secondEntry: String = "" {
        didSet {
            secondEntryPublisher.send(self.secondEntry)
        }
    }
    private let secondEntryPublisher = CurrentValueSubject<String, Never>("")

    @Published var validationMessages = [String]()
    private var cancellableSet: Set<AnyCancellable> = []

    var submitAllowed: AnyPublisher<Bool, Never>
    
    init() {

        let validationPipeline = Publishers.CombineLatest(firstEntryPublisher, secondEntryPublisher)
            .map { (arg) -> [String] in
                var diagMsgs = [String]()
                let (value, value_repeat) = arg
                if !(value_repeat == value) {
                    diagMsgs.append("Values for fields must match.")
                }
                if (value.count < 5 || value_repeat.count < 5) {
                    diagMsgs.append("Please enter values of at least 5 characters.")
                }
                return diagMsgs
            }
            .share()

        submitAllowed = validationPipeline
            .map { stringArray in
                return stringArray.count < 1
            }
            .eraseToAnyPublisher()

        let _ = validationPipeline
            .assign(to: \.validationMessages, on: self)
            .store(in: &cancellableSet)
    }
}

struct ReactiveForm: View {

    @ObservedObject var model: ReactiveFormModel
    // $model is a ObservedObject<ExampleModel>.Wrapper
    // and $model.objectWillChange is a Binding<ObservableObjectPublisher>
    @State private var buttonIsDisabled = true
    // $buttonIsDisabled is a Binding<Bool>
    var body: some View {
        VStack {
            Text("Reactive Form")
                .font(.headline)

            Form {
                TextField("first entry", text: $model.firstEntry)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .lineLimit(1)
                    .multilineTextAlignment(.center)
                    .padding()

                TextField("second entry", text: $model.secondEntry)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
                    .padding()

                VStack {
                    ForEach(model.validationMessages, id: \.self) { msg in
                        Text(msg)
                            .foregroundColor(.red)
                            .font(.callout)
                    }
                }
            }

            Button(action: {}) {
                Text("Submit")
            }.disabled(buttonIsDisabled)
                .onReceive(model.submitAllowed) { submitAllowed in
                    self.buttonIsDisabled = !submitAllowed
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10)      .stroke(Color.blue, lineWidth: 1)
            )

            
            Spacer()
        }
    }
}


struct ContentView : View {
    var localModel = ReactiveFormModel()
    var body: some View {
        ReactiveForm(model: localModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
