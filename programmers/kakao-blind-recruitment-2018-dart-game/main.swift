func solution(_ dartResult:String) -> Int {
    var points: [Int] = []
    let chars: [Character] = Array(dartResult)
    var i = 0

    for _ in 0..<3 {
        var num: Int = 0
        
        if chars[i] == "1" && i + 1 < chars.count && chars[i + 1] == "0" {
            num = 10
            i += 2
        } else {
            num = Int(String(chars[i]))!
            i += 1
        }
        
        let bonus = chars[i]
        var point: Int = 0
        switch bonus {
        case "S":
            point = num
        case "D":
            point = num * num
        case "T":
            point = num * num * num
        default:
            break
        }
        i += 1
        
        if i < chars.count && (chars[i] == "*" || chars[i] == "#") {
            let option: Character = chars[i]
            if option == "*" {
                point *= 2
                if !points.isEmpty {
                    points[points.count - 1] *= 2
                }
            } else if option == "#" {
                point *= -1
            }
            i += 1 
        }
        
        points.append(point)
    }
    
    var total: Int = 0
    for point in points {
        total += point
    }
    
    return total
}

let testCases: [(String, Int)] = [
    ("1S2D*3T", 37),
    ("1D2S#10S", 9),
    ("1D2S0T", 3),
    ("1S*2T*3S", 23),
    ("1D#2S*3S", 5),
    ("1T2D3D#", -4),
    ("1D2S3T*", 59)
]

for (input, expected) in testCases {
    let result: Int = solution(input)
    print("Input: \(input) → 결과: \(result) (예상: \(expected))")
}
