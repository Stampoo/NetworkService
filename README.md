# NetworkService

### While in working
Simple network bicycle:)

<details><summary>Example</summary>
  
```swift
  DataTaskProcessor()
      .startTask(url: TestRoute.url, method: .get)
      .decode(on: [String: String].self)
      .perform(in: .main)
      .map(\.count)
      .onComplete { countOfKeys in
          print(countOfKeys)
      }
      .onError { error in
          print(error)
      }
```

</details>

<details><summary>or with Publisher</summary>
  
```swift
  @available(iOS 13, *)
  DataTaskProcessor()
      .startTask(url: TestRoute.url, method: .get)
      .publisher
      .compactMap(\.data)
      .decode(type: [String: String].self, decoder: JSONDecoder())
      .sink { result in
         switch result {
         case .finished:
             print("Success!")
         case .failure(let error):
             print("Error \(error.localizedDescription)")
         }
      } receiveValue: { response in
          print(response)
      }
      .store(in: &cancellabelEventsContainer)
```

</details>
