import Cocoa
import CreateML


let data = try MLDataTable(contentsOf:URL(fileURLWithPath: "/Users/huangyikai/Desktop/Swift Learning/Machine Learning Create ML/Tweets Ratings Recognizer/twitter-sanders-apple3.csv"))


let (trainingData, testingData) = data.randomSplit(by: 0.8, seed: 5)

let sentimentClassifier = try MLTextClassifier(trainingData: data, textColumn: "text", labelColumn: "class")

let evaluationMetrics = sentimentClassifier.evaluation(on: testingData, textColumn: "text", labelColumn: "class")

let accuracy = (1.0 - evaluationMetrics.classificationError) * 100

let metaData = MLModelMetadata(author: "Eric Huang", shortDescription: "A model trained for twitter sentiment classification.", license: nil, version: "1.0", additional: nil)

// Export Machine Learning model
//try sentimentClassifier.write(to: URL(fileURLWithPath: "/Users/huangyikai/Desktop/Swift Learning/Machine Learning Create ML/Tweets Ratings Recognizer/"))

try sentimentClassifier.prediction(from: "@Apple is discriminant")
